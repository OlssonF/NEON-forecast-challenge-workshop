``` r
#read in the targets data
targets <- read_csv('https://data.ecoforecast.org/neon4cast-targets/aquatics/aquatics-targets.csv.gz')

# read in the sites data
aquatic_sites <- read_csv("https://raw.githubusercontent.com/eco4cast/neon4cast-targets/main/NEON_Field_Site_Metadata_20220412.csv") |>
  dplyr::filter(aquatics == 1)

lake_sites <- aquatic_sites %>%
  filter(field_site_subtype == 'Lake')

# Filter the targets
targets <- targets %>%
  filter(site_id %in% lake_sites$field_site_id,
         variable == 'temperature')
```

``` r
# Past stacked weather
noaa_past_s3 <- neon4cast::noaa_stage3()

variables <- c("air_temperature")
#Other variable names can be found at https://projects.ecoforecast.org/neon4cast-docs/Shared-Forecast-Drivers.html#stage-3

noaa_past <- noaa_past_s3  |> 
  dplyr::filter(site_id %in% lake_sites$field_site_id,
                datetime >= ymd('2017-01-01'),
                variable %in% variables) |> 
  dplyr::collect()

# aggregate the past to mean values
noaa_past_mean <- noaa_past |> 
  mutate(datetime = as_date(datetime)) |> 
  group_by(datetime, site_id, variable) |> 
  summarize(prediction = mean(prediction, na.rm = TRUE), .groups = "drop") |> 
  pivot_wider(names_from = variable, values_from = prediction) |> 
  # convert air temp to C
  mutate(air_temperature = air_temperature - 273.15)
```

``` r
# Future weather
# New forecast only available at 5am UTC the next day
forecast_date <- Sys.Date() 
noaa_date <- forecast_date - days(1)

noaa_future_s3 <- neon4cast::noaa_stage2(start_date = as.character(noaa_date))
variables <- c("air_temperature")

noaa_future <- noaa_future_s3 |> 
  dplyr::filter(datetime >= forecast_date,
                site_id %in% lake_sites$field_site_id,
                variable %in% variables) |> 
  collect()

noaa_future_daily <- noaa_future |> 
  mutate(datetime = as_date(datetime)) |> 
  # mean daily forecasts at each site per ensemble
  group_by(datetime, site_id, parameter, variable) |> 
  summarize(prediction = mean(prediction)) |>
  pivot_wider(names_from = variable, values_from = prediction) |>
  # convert to Celsius
  mutate(air_temperature = air_temperature - 273.15) |> 
  select(datetime, site_id, air_temperature, parameter)
```

``` r
# Generate a dataframe to fit the model to 
targets_lm <- targets |> 
  filter(variable == 'temperature') |>
  pivot_wider(names_from = 'variable', values_from = 'observation') |> 
  left_join(noaa_past_mean, 
            by = c("datetime","site_id"))

# Loop through each site to fit the model
temp_lm_forecast <- NULL
```

``` r
for(i in 1:length(lake_sites$field_site_id)) {  
  
  example_site <- lake_sites$field_site_id[i]
  
  site_target <- targets_lm |>
    filter(site_id == example_site)

  noaa_future_site <- noaa_future_daily |> 
    filter(site_id == example_site)
  
  #Fit linear model based on past data: water temperature = m * air temperature + b
  fit <- lm(site_target$temperature ~ site_target$air_temperature)
  # fit <- lm(site_target$temperature ~ ....)
    
  # use linear regression to forecast water temperature for each ensemble member
  forecasted_temperature <- fit$coefficients[1] + fit$coefficients[2] * noaa_future_site$air_temperature
    
  # put all the relavent information into a tibble that we can bind together
  temperature <- tibble(datetime = noaa_future_site$datetime,
                        site_id = example_site,
                        parameter = noaa_future_site$parameter,
                        prediction = forecasted_temperature,
                        variable = "temperature")
  
  temp_lm_forecast <- dplyr::bind_rows(temp_lm_forecast, temperature)
  message(example_site, ' temperature forecast run')
  
}
```

    ## BARC temperature forecast run

    ## CRAM temperature forecast run

    ## LIRO temperature forecast run

    ## PRLA temperature forecast run

    ## PRPO temperature forecast run

    ## SUGG temperature forecast run

    ## TOOK temperature forecast run

``` r
# Make forecast fit the EFI standards
# Remember to change the model_id when you make changes to the model structure!
my_model_id <- 'example_ID'

temp_lm_forecast_EFI <- temp_lm_forecast %>%
  filter(datetime > forecast_date) %>%
  mutate(model_id = my_model_id,
         reference_datetime = forecast_date,
         family = 'ensemble',
         parameter = as.character(parameter)) %>%
  select(datetime, reference_datetime, site_id, family, parameter, variable, prediction, model_id)
```

``` r
# Write the forecast to file
theme <- 'aquatics'
date <- temp_lm_forecast_EFI$reference_datetime[1]
forecast_name_1 <- paste0(temp_lm_forecast_EFI$model_id[1], ".csv")
forecast_file_1 <- paste(theme, date, forecast_name_1, sep = '-')
forecast_file_1
```

    ## [1] "aquatics-2024-01-23-example_ID.csv"

``` r
if (!dir.exists('Forecasts')) {
  dir.create('Forecasts')
}

write_csv(temp_lm_forecast_EFI, file.path('Forecasts',forecast_file_1))

neon4cast::forecast_output_validator(file.path('Forecasts',forecast_file_1))
```

    ## Forecasts/aquatics-2024-01-23-example_ID.csv

    ## ✔ file has model_id column
    ## ✔ forecasted variables found correct variable + prediction column
    ## ✔ file has correct family and parameter columns
    ## ✔ file has site_id column
    ## ✔ file has datetime column
    ## ✔ file has correct datetime column

    ## Warning: file missing duration column (values for the column: daily = P1D,
    ## 30min = PT30M)

    ## Warning: file missing project_id column (use `neon4cast` as the project_id

    ## ✔ file has reference_datetime column
    ## Forecast format is valid

    ## [1] TRUE

``` r
## # can uses the neon4cast::forecast_output_validator() to check the forecast is in the right format

# UNCOMMMENT THIS WHEN YOU ARE READY TO SUBMIT
## neon4cast::submit(forecast_file = file.path('Forecasts', forecast_file_1),
##                   ask = FALSE) # if ask = T (default), it will produce a pop-up box asking if you want to submit
```

``` r
temp_lm_forecast_EFI |> 
  ggplot(aes(x=datetime, y=prediction, group = parameter)) +
  geom_line() +
  facet_wrap(~site_id) +
  labs(title = paste0('Forecast generated for ', temp_lm_forecast_EFI$variable[1], ' on ', temp_lm_forecast_EFI$reference_datetime[1]))
```

![](forecast_code_template_files/figure-markdown_github/plot-forecast-1.png)
