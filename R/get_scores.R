Sys.unsetenv("AWS_ACCESS_KEY_ID")
Sys.unsetenv("AWS_SECRET_ACCESS_KEY")
Sys.unsetenv("AWS_DEFAULT_REGION")
Sys.unsetenv("AWS_S3_ENDPOINT")
Sys.setenv(AWS_EC2_METADATA_DISABLED="TRUE")
library(arrow)
library(tidyverse)

# connect to the scores bucket
s3 <- s3_bucket("neon4cast-scores/parquet/aquatics", endpoint_override= "data.ecoforecast.org")

#these are the filters you will put in
get_models <- c('persistenceRW', 'climatology') # the name of your models/the models you are interested in

start_ref_date <- as_date('2023-04-13') # what period do you want the scores for?
end_ref_date <- Sys.Date()
get_refdates <- as.character(seq(start_ref_date, end_ref_date, by = 'day'))

get_sites <- readr::read_csv("https://raw.githubusercontent.com/eco4cast/neon4cast-targets/main/NEON_Field_Site_Metadata_20220412.csv") |> 
  dplyr::filter(field_site_subtype == 'Lake') |> 
  select(field_site_id) |> 
  pull() # get in a vector

get_variables <- c('temperature', 'oxygen', 'chla')

# connect to the bucket and grab the scores
scores <- open_dataset(s3) |>
  filter(reference_datetime %in% get_refdates,
         model_id %in% get_models,
         site_id %in% get_sites,
         variable %in% get_variables) |> 
  collect() |> 
# Note: this can be slow so be patient 
  # The dataframe might also be very large depending on the filters you put in above
  mutate(horizon = as.numeric(as_date(datetime) - as_date(reference_datetime)))


