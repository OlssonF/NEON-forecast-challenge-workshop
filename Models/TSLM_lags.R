# ARIMA model with air temperature

library(fable)
library(tsibble)
library(tidyverse)
library(neon4cast)
library(lubridate)
library(rMR)
library(arrow)

# submission information
team_name <- "ARIMA"

team_list <- list(list(individualName = list(givenName = "Freya", 
                                             surName = "Olsson"),
                       organizationName = "Virginia Tech",
                       electronicMailAddress = "freyao@vt.edu"))

# Target data
targets <- readr::read_csv("https://data.ecoforecast.org/neon4cast-targets/aquatics/aquatics-targets.csv.gz", guess_max = 1e6)

sites <- unique(targets$site_id)

site_data <- readr::read_csv("https://raw.githubusercontent.com/eco4cast/neon4cast-targets/main/NEON_Field_Site_Metadata_20220412.csv") |> 
  dplyr::filter(aquatics == 1)

# Do we need a value from yesterday to start?
forecast_starts <- targets %>%
  na.omit() %>%
  group_by(variable, site_id) %>%
  # Start the day after the most recent non-NA value
  dplyr::summarise(start_date = max(time) + lubridate::days(1)) %>% # Date
  dplyr::mutate(h = (Sys.Date() - start_date) + 30) %>% # Horizon value
  dplyr::ungroup()

# Past stacked weather
df_past <- neon4cast::noaa_stage3()

# Only need the air temperature from the lake sites
noaa_past <- df_past |> 
  dplyr::filter(site_id %in% sites,
                time >= ymd('2017-01-01'),
                variable == "air_temperature") |> 
  dplyr::collect()

# aggregate the past to mean daily values
noaa_past_mean <- noaa_past |> 
  mutate(date = as_date(time)) |> 
  group_by(date, site_id) |> 
  summarize(air_temperature = mean(predicted, na.rm = TRUE), .groups = "drop") |> 
  rename(time = date) |> 
  # convert air temp to C
  mutate(air_temperature = air_temperature - 273.15)


# Forecasts
# New forecast only available at 5am UTC the next day
forecast_date <- as.character(Sys.Date() - 1)

df_future <- neon4cast::noaa_stage2()

noaa_future <- df_future |> 
  dplyr::filter(cycle == 0,
                start_date == forecast_date,
                site_id %in% sites,
                variable == "air_temperature") |> 
  dplyr::collect()

# Aggregate for each ensemble for future
noaa_future <- noaa_future |> 
  mutate(time = as_date(time)) |> 
  group_by(time, site_id, ensemble) |> 
  summarize(air_temperature = mean(predicted)) |> 
  mutate(air_temperature = air_temperature - 273.15) |> 
  select(time, site_id, air_temperature, ensemble)


# Merge in past NOAA data into the targets file, matching by date.
# Before building our linear model we need merge in the historical air 
# temperature to match with the historical water temperature

targets <- targets |> 
  select(time, site_id, variable, observed) |> 
  filter(variable == 'temperature') |> 
  pivot_wider(names_from = "variable", values_from = "observed") 

targets <- left_join(targets, noaa_past_mean, by = c("time","site_id"))

# Function to convert to EFI standard
convert.to.efi_standard <- function(df){
  ## determine variable name
  var <- attributes(df)$dist
  ## Normal distribution: use distribution mean and variance
  df %>% 
    as_tibble() %>%
    dplyr::mutate(sigma = sqrt( distributional::variance( .data[[var]] ))) %>%
    dplyr::rename(mu = .mean) %>%
    dplyr::select(time, site_id, .model, mu, sigma, variable, ensemble) %>%
    tidyr::pivot_longer(c(mu, sigma), names_to = "parameter", values_to = var) %>%
    dplyr::rename('predicted' = var) %>%
    dplyr::mutate(family = "normal",
                  start_time = min(time) - lubridate::days(1)) %>%
    dplyr::select(any_of(c('time', 'start_time', 'site_id', 'family', 
                           'parameter', 'variable', 'predicted', 'ensemble')))
}


# Split the NOAA forecast into each ensemble
noaa_ensembles <- split(noaa_future, f = noaa_future$ensemble)
# For each ensemble make this into a tsibble that can be used to forecast
# then when this is supplied as the new_data argument it will run the forecast for each 
# air-temperature forecast ensemble
test_scenarios <- lapply(noaa_ensembles, as_tsibble, key = 'site_id', index = 'time')

# Fits separate LM with ARIMA errors for each site
TSLM_model <- targets %>%
  as_tsibble(key = 'site_id', index = 'time') %>%
  # add NA values up to today (index)
  fill_gaps(.end = Sys.Date()) %>%
  model(TSLM(temperature ~ air_temperature + lag(air_temperature)))

# Forecast using the fitted model
TSLM_fable <-  TSLM_model %>%
  forecast(new_data = test_scenarios) %>%
  mutate( variable = 'temperature')

# Convert to the EFI standard from a fable with distribution
TSLM_EFI <- convert.to.efi_standard(TSLM_fable)
