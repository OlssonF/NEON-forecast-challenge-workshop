-   <a href="#this-r-markdown-document" id="toc-this-r-markdown-document">1
    This R markdown document</a>
-   <a href="#introduction-to-neon-forecast-challenge"
    id="toc-introduction-to-neon-forecast-challenge">2 Introduction to NEON
    forecast challenge</a>
    -   <a href="#aquatics-challenge" id="toc-aquatics-challenge">2.1 Aquatics
        challenge</a>
    -   <a href="#submission-requirements" id="toc-submission-requirements">2.2
        Submission requirements</a>
-   <a href="#the-forecasting-workflow" id="toc-the-forecasting-workflow">3
    The forecasting workflow</a>
    -   <a href="#read-in-the-data" id="toc-read-in-the-data">3.1 Read in the
        data</a>
    -   <a href="#visualise-the-data" id="toc-visualise-the-data">3.2 Visualise
        the data</a>
-   <a href="#introducing-co-variates" id="toc-introducing-co-variates">4
    Introducing co-variates</a>
    -   <a href="#download-co-variates" id="toc-download-co-variates">4.1
        Download co-variates</a>
        -   <a href="#download-historic-data" id="toc-download-historic-data">4.1.1
            Download historic data</a>
        -   <a href="#download-future-weather-forecasts"
            id="toc-download-future-weather-forecasts">4.1.2 Download future weather
            forecasts</a>
-   <a href="#model-1-linear-model-with-covariates"
    id="toc-model-1-linear-model-with-covariates">5 Model 1: Linear model
    with covariates</a>
    -   <a href="#specify-forecast-model" id="toc-specify-forecast-model">5.1
        Specify forecast model</a>
    -   <a href="#convert-to-efi-standard-for-submission"
        id="toc-convert-to-efi-standard-for-submission">5.2 Convert to EFI
        standard for submission</a>
    -   <a href="#submit-forecast" id="toc-submit-forecast">5.3 Submit
        forecast</a>
    -   <a href="#tasks" id="toc-tasks">5.4 TASKS</a>
    -   <a href="#register-your-participation"
        id="toc-register-your-participation">5.5 Register your participation</a>
-   <a href="#model-2-persistence" id="toc-model-2-persistence">6 Model 2:
    Persistence</a>
    -   <a href="#convert-to-efi-standard-for-submission-1"
        id="toc-convert-to-efi-standard-for-submission-1">6.1 Convert to EFI
        standard for submission</a>
    -   <a href="#write-the-forecast-to-file"
        id="toc-write-the-forecast-to-file">6.2 Write the forecast to file</a>
    -   <a href="#submit-forecast-1" id="toc-submit-forecast-1">6.3 Submit
        forecast</a>
    -   <a href="#tasks-1" id="toc-tasks-1">6.4 TASKS</a>
-   <a href="#model-3-climatology-model"
    id="toc-model-3-climatology-model">7 Model 3: Climatology model</a>
    -   <a href="#write-the-forecast-for-neon-efi-challenge"
        id="toc-write-the-forecast-for-neon-efi-challenge">7.1 Write the
        forecast for NEON EFI challenge</a>
    -   <a href="#submit-forecast-2" id="toc-submit-forecast-2">7.2 Submit
        forecast</a>
    -   <a href="#tasks-2" id="toc-tasks-2">7.3 TASKS</a>
-   <a href="#other-things-that-might-be-useful"
    id="toc-other-things-that-might-be-useful">8 Other things that might be
    useful</a>
    -   <a href="#how-the-forecasts-are-scored"
        id="toc-how-the-forecasts-are-scored">8.1 How the forecasts are
        scored?</a>
    -   <a href="#other-useful-r-packages" id="toc-other-useful-r-packages">8.2
        Other useful R packages</a>
    -   <a href="#other-weather-variables" id="toc-other-weather-variables">8.3
        Other weather variables</a>
    -   <a href="#file-format" id="toc-file-format">8.4 File format</a>
    -   <a href="#automating-your-forecasting-workflow"
        id="toc-automating-your-forecasting-workflow">8.5 Automating your
        forecasting workflow</a>
    -   <a
        href="#alternative-methods-to-loop-through-each-variable-site_id-combination"
        id="toc-alternative-methods-to-loop-through-each-variable-site_id-combination">8.6
        Alternative methods to loop through each variable-site_id
        combination</a>

# 1 This R markdown document

This document present workshop materials initially presented in the
Forecast Challenge part of the GLEON2022 workshop “Introduction to
real-time lake forecasting: learn, teach, and generate forecasts with
Macrosystems EDDIE modules and the NEON Forecasting Challenge.” The
materials have been modified slightly for use in additional workshops.

To complete the workshop via this markdown document the following
packages will need to be installed:

-   `remotes`
-   `fpp3`
-   `tsibble`
-   `tidyverse`
-   `lubridate`
-   `neon4cast` (from github)

The following code chunk should be run to install packages.

``` r
install.packages('remotes')
install.packages('fpp3') # package for applying simple forecasting methods
install.packages('tsibble') # package for dealing with time series data sets and tsibble objects
install.packages('tidyverse') # collection of R packages for data manipulation, analysis, and visualisation
install.packages('lubridate') # working with dates and times
remotes::install_github('eco4cast/neon4cast') # package from NEON4cast challenge organisers to assist with forecast building and submission
```

Additionally, R version 4.2 is required to run the neon4cast package.
It’s also worth checking your Rtools is up to date and compatible with R
4.2, see
(<https://cran.r-project.org/bin/windows/Rtools/rtools42/rtools.html>).

``` r
version$version.string
```

    ## [1] "R version 4.2.0 (2022-04-22 ucrt)"

If you do not wish to run the code yourself you can follow along via the
html (GLEON_forecast_challenge.html), which can be downloaded from the
[Github
repository](https://github.com/OlssonF/GLEON-forecast-challenge).

# 2 Introduction to NEON forecast challenge

The EFI RCN NEON Forecast Challenge asks the scientific community to
produce ecological forecasts of future conditions at NEON sites by
leveraging NEON’s open data products. The Challenge is split into five
themes that span aquatic and terrestrial systems, and population,
community, and ecosystem processes across a broad range of ecoregions.
We are excited to use this Challenge to learn more about the
predictability of ecological processes by forecasting NEON data before
it is collected.

Which modeling frameworks, mechanistic processes, and statistical
approaches best capture community, population, and ecosystem dynamics?
These questions are answerable by a community generating a diverse array
of forecasts. The Challenge is open to any individual or team from
anywhere around the world that wants to submit forecasts. Sign up
[here.](https://projects.ecoforecast.org/neon4cast-docs/Participation.html).

## 2.1 Aquatics challenge

What: Freshwater surface water temperature, oxygen, and chlorophyll-a.

Where: 7 lakes and 27 river/stream NEON sites.

When: Daily forecasts for at least 30-days in the future. New forecast
submissions, that use new data to update the forecast, are accepted
daily. The only requirement is that submissions are predictions of the
future at the time the forecast is submitted.

Today we will focus on lake sites only, as used in the MacrosystemEDDIE
modules, and will start with forecasting water temperature. For the
challenge, you can chose to submit to either the lakes, rivers or
streams or all three! You can also chose to submit any of the three
focal variables (temperature, oxygen, and chlorophyll). Find more
information about the aquatics challenge
[here](https://projects.ecoforecast.org/neon4cast-docs/Aquatics.html).

## 2.2 Submission requirements

For the Challanges forecasts must include quantified uncertainty. The
file can represent uncertainty using an ensemble forecast (multiple
realizations of future conditions) or a distribution forecast (with mean
and standard deviation), specified in the family and parameter columns
of the forecast file.

For an ensemble forecast, the `family` column uses the word `ensemble`
to designate that it is a ensemble forecast and the parameter column is
the ensemble member number (1, 2, 3 …). For a distribution forecast, the
`family` column uses the word `normal` to designate a normal
distribution and the parameter column must have the words mu and sigma
for each forecasted variable, site_id, and datetime. For forecasts that
don’t have a normal distribution we recommend using the ensemble format
and sampling from your non-normal distribution to generate a set of
ensemble members that represents your distribution. I will go through
examples of both `ensemble` and `normal` forecasts as examples.

The full list of required columns and format can be found in the
[Challenge
documentation](https://projects.ecoforecast.org/neon4cast-docs/Submission-Instructions.html).

# 3 The forecasting workflow

## 3.1 Read in the data

We start forecasting by first looking at the historic data - called the
‘targets’. These data are available near real-time, with the latency of
approximately 24-48 hrs. Here is how you read in the data from the
targets file available from the EFI server.

``` r
#read in the targets data
targets <- read_csv('https://data.ecoforecast.org/neon4cast-targets/aquatics/aquatics-targets.csv.gz')
```

Information on the NEON sites can be found in the
`NEON_Field_Site_Metadata_20220412.csv` file on GitHub. It can be
filtered to only include aquatic sites. This table has information about
the field sites, including location, ecoregion, information about the
watershed (e.g. elevation, mean annual precipitation and temperature),
and lake depth.

``` r
# read in the sites data
aquatic_sites <- read_csv("https://raw.githubusercontent.com/eco4cast/neon4cast-targets/main/NEON_Field_Site_Metadata_20220412.csv") |>
  dplyr::filter(aquatics == 1)
```

Let’s take a look at the targets data!

    ## # A tibble: 11 × 4
    ##    datetime   site_id variable    observation
    ##    <date>     <chr>   <chr>             <dbl>
    ##  1 2018-11-16 ARIK    temperature       NA   
    ##  2 2018-11-17 ARIK    oxygen             8.62
    ##  3 2018-11-17 ARIK    temperature        4.85
    ##  4 2018-11-18 ARIK    oxygen             9.65
    ##  5 2018-11-18 ARIK    temperature        2.76
    ##  6 2018-11-19 ARIK    oxygen             9.60
    ##  7 2018-11-19 ARIK    temperature        3.07
    ##  8 2018-11-20 ARIK    oxygen             9.71
    ##  9 2018-11-20 ARIK    temperature        3.33
    ## 10 2018-11-21 ARIK    oxygen             9.27
    ## 11 2018-11-21 ARIK    temperature        3.76

The columns of the targets file show the time step (daily for aquatics
challenge), the 4 character site code (`site_id`), the variable being
measured, and the mean daily observation. To look at only the lakes we
can subset the targets and aquatic sites to those which have the
`field_site_subtype` of `Lake`.

``` r
lake_sites <- aquatic_sites %>%
  filter(field_site_subtype == 'Lake')

targets <- targets %>%
  filter(site_id %in% lake_sites$field_site_id)
```

## 3.2 Visualise the data

![Figure: Temperature targets data at aquatic sites provided by EFI for
the NEON forecasting
challgenge](GLEON_forecast_challenge_files/figure-markdown_github/unnamed-chunk-7-1.png)![Figure:
Oxygen targets data at aquatic sites provided by EFI for the NEON
forecasting
challgenge](GLEON_forecast_challenge_files/figure-markdown_github/unnamed-chunk-7-2.png)![Figure:
Chlorophyll targets data at aquatic sites provided by EFI for the NEON
forecasting challgenge. Chlorophyll data is only available at lake and
river
sites](GLEON_forecast_challenge_files/figure-markdown_github/unnamed-chunk-7-3.png)

We can think about what type of models might be useful to predict these
variables at these sites. Below are descriptions of three simple models
which have been constructed to get you started forecasting:

-   We could use information about current conditions to predict the
    next day. What is happening today is usually a good predictor of
    what will happen tomorrow (Model 2 - Persistence).
-   We could also look at the lake variables’ relationship(s) with other
    variable. Could we use existing forecasts about the weather to
    generate forecasts about lake variables (Model 1 - Linear Model with
    Co-variates).
-   And we could think about what the historic data tells us about this
    time of year. November this year is likely to be similar to November
    last year (Model 3 - Climatology/Seasonal Naive Model)

To start, we will produce forecasts for just one of these target
variables, surface water temperature.

``` r
targets <- targets %>%
  filter(variable == 'temperature')
```

# 4 Introducing co-variates

One important step to overcome when thinking about generating forecasts
is to include co-variates in the model. A water temperature forecast,
for example, may be benefit from information about past and future
weather. The neon4cast challenge package includes functions for
downloading past and future NOAA weather forecasts for all of the NEON
sites. The 3 types of data are as follows:

-   stage_1: raw forecasts - 31 member ensemble forecasts at 3 hr
    intervals for the first 10 days, and 6 hr intervals for up to 35
    days at the NEON sites.
-   stage_2: a processed version of Stage 1 in which fluxes are
    standardized to per second rates, fluxes and states are interpolated
    to 1 hour intervals and variables are renamed to match conventions.
    We recommend this for obtaining future weather by using
    `neon4cast::noaa_stage2()`. Future weather forecasts include a
    30-member ensemble of equally likely future weather conditions.
-   stage_3: can be viewed as the “historical” weather and is
    combination of day 1 weather forecasts (i.e., when the forecasts are
    most accurate). You can download this “stacked” NOAA product using
    `neon4cast::noaa_stage3()`.

These functions create a connection to the dataset hosted on the
eco4cast server. To download the data you have to tell the function to
`collect()` it. These data set can be subsetted and filtered using
`dplyr` functions prior to download to limit the memory usage.

You can read more about the NOAA forecasts available for the NEON sites
[here:](https://projects.ecoforecast.org/neon4cast-docs/Shared-Forecast-Drivers.html)

## 4.1 Download co-variates

### 4.1.1 Download historic data

We will generate a water temperature forecast using `air_temperature` as
a co-variate. Note: This code chunk can take a few minutes to execute as
it accesses the NOAA data.

``` r
# past stacked weather
df_past <- neon4cast::noaa_stage3()

variables <- c("air_temperature")
#Other variable names can be found at https://projects.ecoforecast.org/neon4cast-docs/Shared-Forecast-Drivers.html#stage-2

noaa_past <- df_past |> 
  dplyr::filter(site_id %in% lake_sites$field_site_id,
                datetime >= ymd('2017-01-01'),
                variable %in% variables) |> 
  dplyr::collect()

noaa_past
```

    ## # A tibble: 7,805,304 × 9
    ##    datetime            site_id longitude latitude family  param…¹ varia…² height
    ##    <dttm>              <chr>       <dbl>    <dbl> <chr>     <int> <chr>   <chr> 
    ##  1 2021-03-20 04:00:00 CRAM        -89.5     46.2 ensemb…       3 air_te… 2 m a…
    ##  2 2021-03-20 04:00:00 CRAM        -89.5     46.2 ensemb…       4 air_te… 2 m a…
    ##  3 2021-03-20 04:00:00 CRAM        -89.5     46.2 ensemb…       5 air_te… 2 m a…
    ##  4 2021-03-20 04:00:00 CRAM        -89.5     46.2 ensemb…       6 air_te… 2 m a…
    ##  5 2021-03-20 04:00:00 CRAM        -89.5     46.2 ensemb…       7 air_te… 2 m a…
    ##  6 2021-03-20 04:00:00 CRAM        -89.5     46.2 ensemb…       8 air_te… 2 m a…
    ##  7 2021-03-20 04:00:00 CRAM        -89.5     46.2 ensemb…       9 air_te… 2 m a…
    ##  8 2021-03-20 04:00:00 CRAM        -89.5     46.2 ensemb…      10 air_te… 2 m a…
    ##  9 2021-03-20 04:00:00 CRAM        -89.5     46.2 ensemb…      11 air_te… 2 m a…
    ## 10 2021-03-20 04:00:00 CRAM        -89.5     46.2 ensemb…      12 air_te… 2 m a…
    ## # … with 7,805,294 more rows, 1 more variable: prediction <dbl>, and
    ## #   abbreviated variable names ¹​parameter, ²​variable

This is a stacked ensemble forecast of the one day ahead forecasts. To
get an estimate of the historic conditions we can take a mean of these
ensembles. We will also need to convert the temperatures to Celsius from
Kelvin.

``` r
# aggregate the past to mean values
noaa_past_mean <- noaa_past |> 
  mutate(datetime = as_date(datetime)) |> 
  group_by(datetime, site_id, variable) |> 
  summarize(prediction = mean(prediction, na.rm = TRUE), .groups = "drop") |> 
  pivot_wider(names_from = variable, values_from = prediction) |> 
  # convert air temp to C
  mutate(air_temperature = air_temperature - 273.15)
```

We can then look at the future weather forecasts in the same way but
using the `noaa_stage2()`. The forecast becomes available from NOAA at
5am UTC the following day, so we take the air temperature forecast from
yesterday (`noaa_date`) to make the water quality forecasts. Then we can
use the ensembles to produce uncertainty in the water temperature
forecast by forecasting multiple (31) future water temperatures.

### 4.1.2 Download future weather forecasts

``` r
# New forecast only available at 5am UTC the next day

forecast_date <- Sys.Date() 
noaa_date <- forecast_date - days(1)

df_future <- neon4cast::noaa_stage2()

variables <- c("air_temperature")

noaa_future <- df_future |> 
  dplyr::filter(reference_datetime == noaa_date,
                datetime >= forecast_date,
                site_id %in% lake_sites$field_site_id,
                variable %in% variables) |> 
  dplyr::collect()
noaa_future
```

    ## # A tibble: 174,097 × 13
    ##    site_id prediction varia…¹ height horizon param…² reference_datetime  forec…³
    ##    <chr>        <dbl> <chr>   <chr>    <dbl>   <int> <dttm>              <chr>  
    ##  1 BARC          289. air_te… 2 m a…      24       1 2023-01-09 00:00:00 24 hou…
    ##  2 BARC          288. air_te… 2 m a…      25       1 2023-01-09 00:00:00 25 hou…
    ##  3 BARC          287. air_te… 2 m a…      26       1 2023-01-09 00:00:00 26 hou…
    ##  4 BARC          286. air_te… 2 m a…      27       1 2023-01-09 00:00:00 27 hou…
    ##  5 BARC          285. air_te… 2 m a…      28       1 2023-01-09 00:00:00 28 hou…
    ##  6 BARC          285. air_te… 2 m a…      29       1 2023-01-09 00:00:00 29 hou…
    ##  7 BARC          285. air_te… 2 m a…      30       1 2023-01-09 00:00:00 30 hou…
    ##  8 BARC          284. air_te… 2 m a…      31       1 2023-01-09 00:00:00 31 hou…
    ##  9 BARC          284. air_te… 2 m a…      32       1 2023-01-09 00:00:00 32 hou…
    ## 10 BARC          284. air_te… 2 m a…      33       1 2023-01-09 00:00:00 33 hou…
    ## # … with 174,087 more rows, 5 more variables: datetime <dttm>, longitude <dbl>,
    ## #   latitude <dbl>, family <chr>, start_date <chr>, and abbreviated variable
    ## #   names ¹​variable, ²​parameter, ³​forecast_valid

The forecasts are hourly and we are interested in using daily mean air
temperature for water temperature forecast generation.

``` r
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

    ## `summarise()` has grouped output by 'datetime', 'site_id', 'parameter'. You can
    ## override using the `.groups` argument.

``` r
noaa_future_daily
```

    ## # A tibble: 7,462 × 4
    ## # Groups:   datetime, site_id, parameter [7,462]
    ##    datetime   site_id air_temperature parameter
    ##    <date>     <chr>             <dbl>     <int>
    ##  1 2023-01-10 BARC               13.9         1
    ##  2 2023-01-10 BARC               13.3         2
    ##  3 2023-01-10 BARC               15.3         3
    ##  4 2023-01-10 BARC               13.6         4
    ##  5 2023-01-10 BARC               15.2         5
    ##  6 2023-01-10 BARC               14.3         6
    ##  7 2023-01-10 BARC               13.5         7
    ##  8 2023-01-10 BARC               13.9         8
    ##  9 2023-01-10 BARC               13.9         9
    ## 10 2023-01-10 BARC               14.7        10
    ## # … with 7,452 more rows

Now we have a timeseries of historic data and a 30 member ensemble
forecast of future temperatures

![Figure: historic and future NOAA air temeprature forecasts at lake
sites](GLEON_forecast_challenge_files/figure-markdown_github/unnamed-chunk-13-1.png)![Figure:
last two months of historic air temperature forecasts and 35 day ahead
forecast](GLEON_forecast_challenge_files/figure-markdown_github/unnamed-chunk-13-2.png)

# 5 Model 1: Linear model with covariates

We will fit a simple linear model between historic air temperature and
the water temperature targets data. Using this model we can then use our
future estimates of air temperature (all 30 ensembles) to estimate water
temperature at each site. The ensemble weather forecast will therefore
propagate uncertainty into the water temperature forecast and give an
estimate of driving data uncertainty.

We will start by joining the historic weather data with the targets to
aid in fitting the linear model.

``` r
targets_lm <- targets |> 
  filter(variable == 'temperature') |>
  pivot_wider(names_from = 'variable', values_from = 'observation') |> 
  left_join(noaa_past_mean, 
            by = c("datetime","site_id"))
targets_lm[1000:1010,]
```

    ## # A tibble: 11 × 4
    ##    datetime   site_id temperature air_temperature
    ##    <date>     <chr>         <dbl>           <dbl>
    ##  1 2021-06-04 BARC           28.6            22.5
    ##  2 2021-06-05 BARC           28.9            22.7
    ##  3 2021-06-06 BARC           29.3            23.1
    ##  4 2021-06-07 BARC           29.5            23.1
    ##  5 2021-06-08 BARC           29.8            23.5
    ##  6 2021-06-09 BARC           30.0            23.7
    ##  7 2021-06-10 BARC           30.3            23.3
    ##  8 2021-06-11 BARC           30.6            23.8
    ##  9 2021-06-12 BARC           30.4            23.6
    ## 10 2021-06-13 BARC           30.2            23.2
    ## 11 2021-06-14 BARC           29.7            21.8

To fit the linear model we use the base R `lm()` but there are also
methods to fit linear (and non-linear) models in the `fable::` package.
You can explore the
[documentation](https://otexts.com/fpp3/regression.html) for more
information on the `fable::TSLM()` function. We can fit a separate
linear model for each site. For example, at Lake Suggs, this would look
like:

``` r
example_site <- 'SUGG'

site_target <- targets_lm |> 
  filter(site_id == example_site)

noaa_future_site <- noaa_future_daily |> 
  filter(site_id == example_site)

#Fit linear model based on past data: water temperature = m * air temperature + b
fit <- lm(site_target$temperature ~ site_target$air_temperature)
    
# use linear regression to forecast water temperature for each ensemble member
forecasted_temperature <- fit$coefficients[1] + fit$coefficients[2] * noaa_future_site$air_temperature
```

We can loop through this for each site to create a site-wise forecast of
water temperature based on a linear model and each forecasted air
temperature. We can run this forecast for each site and then bind them
together to submit as one forecast.

## 5.1 Specify forecast model

``` r
temp_lm_forecast <- NULL

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

We now have 30 possible forecasts of water temperature at each site and
each day. On this plot each line represents one of the possible
forecasts and the range of forecasted water temperature is a simple
quantification of the uncertainty in our forecast.

Looking back at the forecasts we produced:

![](GLEON_forecast_challenge_files/figure-markdown_github/unnamed-chunk-17-1.png)

## 5.2 Convert to EFI standard for submission

For an ensemble forecast the documentation specifies the following
columns:

-   `datetime`: forecast timestamp for each time step
-   `reference_datetime`: The start of the forecast; this should be 0
    times steps in the future. This should only be one value of
    reference_datetime in the file
-   `site_id`: NEON code for site
-   `family`: name of probability distribution that is described by the
    parameter values in the parameter column; only `normal` or
    `ensemble` are currently allowed.
-   `parameter`: integer value for forecast replicate (from the `.rep`
    in fable output);
-   `variable`: standardized variable name from the theme
-   `prediction`: forecasted value (from the `.sim` column in fable
    output)
-   `model_id`: model name (no spaces)

We need to make sure the dataframe is in the correct format and then we
can submit this to the challenge as well! This is an ensemble forecast
(specified in the `family` column).

``` r
# Remember to change the model_id when you make changes to the model structure!
my_model_id <- 'temp_name'

temp_lm_forecast_EFI <- temp_lm_forecast %>%
  mutate(model_id = my_model_id,
         reference_datetime = as_date(min(datetime)) - days(1),
         family = 'ensemble',
         parameter = as.character(parameter)) %>%
  select(model_id, datetime, reference_datetime, site_id, family, parameter, variable, prediction)
```

## 5.3 Submit forecast

Files need to be in the correct format for submission. The forecast
organizers have created tools to help aid in the submission process.
These tools can be downloaded from Github using
`remotes::install_github(eco4cast/neon4cast)`. These include functions
for submitting, scoring and reading forecasts:

-   `submit()` - submit the forecast file to the neon4cast server where
    it will be scored
-   `forecast_output_validator()` - will check the file is in the
    correct format to be submitted
-   `check_submission()` - check that your submission has been uploaded
    to the server

The file name needs to be in the format
theme-reference_datetime-model_id

``` r
# Start by writing the forecast to file
theme <- 'aquatics'
date <- temp_lm_forecast_EFI$reference_datetime[1]
forecast_name_1 <- paste0(temp_lm_forecast_EFI$model_id[1], ".csv")
forecast_file_1 <- paste(theme, date, forecast_name_1, sep = '-')
forecast_file_1
```

    ## [1] "aquatics-2023-01-09-temp_name.csv"

``` r
write_csv(temp_lm_forecast_EFI, forecast_file_1)

neon4cast::forecast_output_validator(forecast_file_1)
```

    ## aquatics-2023-01-09-temp_name.csv

    ## ✔ file name is correct
    ## ✔ forecasted variables found correct variable + prediction column
    ## ✔ file has ensemble distribution in family column
    ## ✔ file has parameter and family column with ensemble generated distribution
    ## ✔ file has site_id column
    ## ✔ file has time column
    ## ✔ file has correct time column
    ## ✔ file has reference_datetime column
    ## Forecast format is valid

    ## [1] TRUE

``` r
# can uses the neon4cast::forecast_output_validator() to check the forecast is in the right format
neon4cast::submit(forecast_file = forecast_file_1,
                  ask = TRUE) # if ask = T (default), it will produce a pop-up box asking if you want to submit
```

Is the linear model a reasonable relationship between air temperature
and water temperature? Would some non-linear relationship be better?
What about using yesterday’s air and water temperatures to predict
tomorrow? Or including additional parameters? There’s a lot of
variability in water temperatures unexplained by air temperature alone.

    ## `geom_smooth()` using formula = 'y ~ x'

![](GLEON_forecast_challenge_files/figure-markdown_github/unnamed-chunk-21-1.png)

## 5.4 TASKS

Possible modifications to Model 1 - simple linear model:

-   Include additional NOAA co-variates in the linear model (remember to
    ‘collect’ and subset the right data from NOAA)
-   Specify a non-linear relationship
-   Try forecasting another variable (oxygen or chlorophyll) - could you
    use your water temperature to estimate dissolved oxygen
    concentration at the surface?
-   Include a lag in the predictors

Remember to change the `model_id` so we can differentiate different
forecasts!

## 5.5 Register your participation

It’s really important that once you start submitting forecasts to the
Challenge that you register your participation. We ask that you complete
this [form](https://nd.qualtrics.com/jfe/form/SV_9MJ29y2xNrBOjqZ) which
asks you some simple questions about your forecast and team. This is
crucial for a couple of reasons:

1.  We can keep track different forecast submissions during the scoring
    process to see which forecast is performing the best. Your
    `model_id` will be used to track the submissions so any new forecast
    model requires a new `model_id`.
2.  The form gives consent for submissions to be included in
    Challenge-wide syntheses being carried out by the Challenge
    organisers. Partipants in the Challenge will be invited to join the
    synthesis projects on an opt-in basis.

Questions about Challenge registration and synthesis participation can
be directed to [Freya Olsson](mailto:freyao@vt.edu).

# 6 Model 2: Persistence

This next forecast will use a method from the `fable` R package which is
installed via `fpp3` package. The `fable` package implements a range of
different forecasting methods including Persistence Models, Moving
Average Models, ARIMA Models and Time Series Models. The package
integrates with `tidyverse` syntax and has good documentation and
examples found [here](https://otexts.com/fpp3/). `fable` and
`fabletools`, are installed as part of the `fpp3` package and produce
and deal with `mable` (model table) and `fable` (forecast table)
objects. We will also use the `tidyverse` to manipulate and visualise
the target data and forecasts.

``` r
# install.packages('fpp3')
# install.packages('tsibble')
# install via remotes::install_github('eco4cast/neon4cast')

library(fpp3)      # package for forecasting
library(tsibble)   # package for dealing with time series data sets

library(neon4cast) 

# suppreses dplyr's summarise message
options(dplyr.summarise.inform = FALSE)
```

`fable` has some simple models that can be fitted to the target data.
`fable` models require data to be in a tidy `tsibble` format. Tools for
dealing with tsibble objects are found in the `tsibble` package.
`tsibble` objects are similar in structure to `tibble` objects but have
a built in timeseries element. This is specified in their creation as
the `index` or time variable. You also need to give the tsibble a `key`,
which in combination with the index will uniquely identify each record.
In our case the key variables will be `site_id` and `variable`. These
models also require explicit gaps to be added for missing values
(`fill_gaps()` will do this!).

For Random Walk (RW) forecasts (i.e., persistence), we simply set the
forecast value be the value of the last observation. Start by reading in
the observations. We will look at water temperature to start with.

The model would be specified and then the forecast generated as follows
(using `fable` and `fabletools` functions).

To specify the model we use `model(RW = RW(observation))` and then the
forecast can be created by piping this model to the `generate()`
function. `h = 30` tells the model how far in the future to forecast,
and `bootstrap = TRUE` tells the function to generate multiple
uncertainty through bootstrapping. Bootstrapping is where we run the
forecast multiple times with a random error term drawn from the
residuals of the fitted model. Doing this repeatedly, we obtain many
possible futures (an ensemble forecast). We decide how many of these
possibilities to simulate with the `times =...` argument.

Note: Running the next chunk will return an error. This is because there
was no observation yesterday.

``` r
targets_subset <- targets %>%
  filter(site_id == 'SUGG') 

RW_model <- targets_subset %>% 
  # fable requires a tsibble object with explicit gaps
  tsibble::as_tsibble(key = c('variable', 'site_id'), index = 'datetime') %>%
  tsibble::fill_gaps() %>%
  model(RW = RW(observation))

RW_daily_forecast <- RW_model %>% 
  generate(h = 30, bootstrap = T, times = 50)
```

The forecast produces an error (‘the first lag window for simulations
must be within the model’s training set’). Why would that be? If you
look at the targets data we can see that yesterday did not have an
observation, so the model cannot produce a persistence forecast.

``` r
targets |> 
  filter(site_id == 'SUGG') |> 
  summarise(last_ob = max(datetime)) |> 
  pull()
```

    ## [1] "2023-01-08"

Specifying the model and forecasts in this way would be fine if we have
data observed to yesterday but this often isn’t the case. For the NEON
data the usual data latency is between 24-72 hours. This is obviously
not ideal, but we need to think of a way to produce forecasts with the
data we have. Instead we can start the forecast at the last observation,
rather than yesterday. The forecast is run from that observation through
today and then for 30 days in the future. In practice this means telling
fable to forecasts 30 days + the number of days since last observation
and then trimming the days that are in the past, before submitting the
forecast.

We calculate the `reference_datetime` (starting data) and total
`horizon` for each `site_id` and `variable` combination (here just
temperature).

``` r
# For the RW model need to start the forecast at the last non-NA day and then run to 30 days in the future
forecast_starts <- targets %>%
  filter(!is.na(observation)) %>%
  group_by(site_id, variable) %>%
  # Start the day after the most recent non-NA value
  summarise(reference_datetime = max(datetime) + 1) %>% # Date 
  mutate(h = (Sys.Date() - reference_datetime) + 30) %>% # Horizon value 
  ungroup() 

forecast_starts
```

    ## # A tibble: 7 × 4
    ##   site_id variable    reference_datetime h       
    ##   <chr>   <chr>       <date>             <drtn>  
    ## 1 BARC    temperature 2023-01-09          31 days
    ## 2 CRAM    temperature 2022-11-15          86 days
    ## 3 LIRO    temperature 2022-11-04          97 days
    ## 4 PRLA    temperature 2022-11-03          98 days
    ## 5 PRPO    temperature 2022-11-05          96 days
    ## 6 SUGG    temperature 2023-01-09          31 days
    ## 7 TOOK    temperature 2022-09-21         141 days

You can see that the sites have different start dates, based on when the
last observation was taken. We want to fit each site (and variable)
model separately depending on its start date and calculated horizon. To
do this I have written a custom function that runs the RW forecast.
Within this function we:

-   Tidy: Takes the targets and fills with NAs, and filters up to the
    last non-NA value. The data must have explicit gaps for the full
    time series and must be in a tsibble format to run `fable`. Every
    time step up to the start of the forecast must exist even if it is
    filled with NAs (except the day before the forecast starts)!
-   Specify: Fits the RW model. We can also specify transformations to
    use within the model. The `fable` package will automatically
    back-transform common transformations in the forecasts whenever one
    is used in the model definition. Common transformations include
    box-cox, logarithmic, and square root. The simplest specification of
    the model is
    `RW_model <- targets_use %>% model(RW = RW(observation))` which
    stores the model table (a `mable`) in the object called `RW_model`.
-   Forecast: Then using this model, we run a forecast! We can specify
    whether bootstrapping is used and the number of bootstraps
    (`bootstrap = T`).

Within this function, there are also if statements to test whether there
are whole datasets missing, as well as messages which can be turned
on/off with the `verbose =` argument.

``` r
# Function carry out a random walk forecast
RW_daily_forecast <- function(site, 
                              var,
                              h,
                              bootstrap = FALSE, boot_number = 200,
                              transformation = 'none', verbose = TRUE,...) {
  
  # message('starting ',site_var_combinations$site[i], ' ', site_var_combinations$var[i], ' forecast')
  
  ### TIDY
  # filter the targets data set to the site_var pair
  targets_use <- targets %>%
    dplyr::filter(site_id == site,
           variable == var) %>%
    tsibble::as_tsibble(key = c('variable', 'site_id'), index = 'datetime') %>%
    
    # add NA values up to today (index)
    tsibble::fill_gaps(.end = Sys.Date()) %>%
    # Remove the NA's put at the end, so that the forecast starts from the last day with an observation,
    dplyr::filter(datetime < forecast_starts$reference_datetime[which(forecast_starts$site_id == site &
                                                                forecast_starts$variable == var)])
  


  # SPECIFY 
  
    # Do you want to apply a transformation? 
    if (transformation == 'log') {
      RW_model <- targets_use %>%
        model(RW = fable::RW(log(observation)))
    }
    
    if (transformation == 'log1p') {
      RW_model <- targets_use %>%
        model(RW = fable::RW(log1p(observation)))
    }
    
    if (transformation == 'sqrt') {
      RW_model <- targets_use %>%
        model(RW = fable::RW(sqrt(observation)))
    }
    
    if (transformation == 'none') {
      RW_model <- targets_use %>%
        model(RW = fable::RW(observation))
    }
    
    #FORECAST
    # Do you want to do a bootstrapped forecast?
    if (bootstrap == T) {
      forecast <- RW_model %>% 
        generate(h = as.numeric(forecast_starts$h[which(forecast_starts$site_id == site &
                                                          forecast_starts$variable == var)]),
                             bootstrap = T,
                             times = boot_number)
    }  else
      forecast <- RW_model %>% 
        forecast(h = as.numeric(forecast_starts$h[which(forecast_starts$site_id == site &
                                                                      forecast_starts$variable == var)]))
    
  if (verbose == T) {
    message(
      site,
      ' ',
      var,
      ' forecast with transformation = ',
      transformation,
      ' and bootstrap = ',
      bootstrap
    )
  }
    return(forecast)
    
  
}
```

This function takes just one site and one variable as arguments. To run
across all site_id-variable combinations we can use a `for` loop. We
need a data frame that we can index from. The number of bootstraps
(`boot_number`) is set to 200. It might also be useful to apply a
transformation to some variables a `log()` transformation on the oxygen
and chlorophyll values.

We can then loop through each variable and site (row) and combine them
into a single data frame (`RW_forecasts`).

``` r
site_var_combinations <- forecast_starts |> 
  select(site_id, variable) |> 
  rename(site = site_id,
         var = variable) |> 
  
  # assign the transformation depending on the variable. 
  # For example chla and oxygen might require a log(x ) transformation
  mutate(transformation = ifelse(var %in% c('chla', 'oxygen'), 
                                 'log', 
                                 'none')) 
head(site_var_combinations)
```

    ## # A tibble: 6 × 3
    ##   site  var         transformation
    ##   <chr> <chr>       <chr>         
    ## 1 BARC  temperature none          
    ## 2 CRAM  temperature none          
    ## 3 LIRO  temperature none          
    ## 4 PRLA  temperature none          
    ## 5 PRPO  temperature none          
    ## 6 SUGG  temperature none

``` r
# An empty data frame to put the forecasts in to
RW_forecast <- NULL

# Loop through each row (variable-site combination)
for (i in 1:nrow(site_var_combinations)) {
  
  forecast <- RW_daily_forecast(site = site_var_combinations$site[i],
                                var = site_var_combinations$var[i],
                                boot_number = 200,
                                bootstrap = T,
                                h = 30, 
                                verbose = F,
                                transformation = site_var_combinations$transformation[i])
  
  
  RW_forecast <- bind_rows(RW_forecast, forecast)
  
}
```

The output from the `forecast()` function is a forecast table or
`fable`, which has columns for `variable`, `site_id`, the `.model`, the
bootstrap value (1 to 200, `.rep`), and the prediction (`.sim`).

``` r
RW_forecast %>%
  filter(site_id == 'SUGG')
```

    ## # A tsibble: 6,200 x 6 [1D]
    ## # Key:       variable, site_id, .model, .rep [200]
    ##    variable    site_id .model datetime   .rep   .sim
    ##    <chr>       <chr>   <chr>  <date>     <chr> <dbl>
    ##  1 temperature SUGG    RW     2023-01-09 1      15.5
    ##  2 temperature SUGG    RW     2023-01-10 1      15.7
    ##  3 temperature SUGG    RW     2023-01-11 1      14.8
    ##  4 temperature SUGG    RW     2023-01-12 1      15.1
    ##  5 temperature SUGG    RW     2023-01-13 1      14.9
    ##  6 temperature SUGG    RW     2023-01-14 1      14.4
    ##  7 temperature SUGG    RW     2023-01-15 1      15.0
    ##  8 temperature SUGG    RW     2023-01-16 1      14.6
    ##  9 temperature SUGG    RW     2023-01-17 1      14.9
    ## 10 temperature SUGG    RW     2023-01-18 1      15.0
    ## # … with 6,190 more rows

How reasonable are these forecasts?? Is there a way to improve the
persistence model? Is a transformation needed?

![Figure: ‘random walk’ persistence forecasts for NEON lake
sites](GLEON_forecast_challenge_files/figure-markdown_github/unnamed-chunk-29-1.png)

Each line on the plot is one of the ensemble members (shown in the fable
as `.rep`). You can also see that not all the “forecasted” days are true
forecasts (some are in the past), but we started the forecast at the
last observation. Therefore, when we write out the forecast and submit
it we need to make sure to only submit the true forecast (of the
future).

## 6.1 Convert to EFI standard for submission

For an ensemble forecast the documentation specifies the following
columns:

-   `datetime`: forecast timestamp for each time step
-   `reference_datetime`: The start of the forecast; this should be 0
    times steps in the future. This should only be one value of
    reference_datetime in the file
-   `site_id`: NEON code for site
-   `family`: name of probability distribution that is described by the
    parameter values in the parameter column; only `normal` or
    `ensemble` are currently allowed.
-   `parameter`: integer value for forecast replicate (from the `.rep`
    in fable output);
-   `variable`: standardized variable name from the theme
-   `prediction`: forecasted value (from the `.sim` column in fable
    output)
-   `model_id`: model name (no spaces)

Looking back at the forecasts we produced:

![annotated
forecasts](GLEON_forecast_challenge_files/figure-markdown_github/unnamed-chunk-30-1.png)

The forecast output from `fable` needs modifying slightly to fit the
Challenge standards.

``` r
model_name <- 'example_RW'
RW_forecasts_EFI <- RW_forecast %>%
  rename(parameter = .rep,
         prediction = .sim) %>%
  # For the EFI challenge we only want the forecast for future
  filter(datetime > Sys.Date()) %>%
  mutate(reference_datetime = min(datetime) - lubridate::days(1),
         family = 'ensemble',
         model_id = model_name) %>%
  select(model_id, datetime, reference_datetime, site_id, family, parameter, variable, prediction) 
```

Now we have a forecast that can be submitted to the EFI challenge.

    ## # A tsibble: 6 x 8 [1D]
    ## # Key:       site_id, parameter, variable [1]
    ##   model_id   datetime   reference_datet…¹ site_id family param…² varia…³ predi…⁴
    ##   <chr>      <date>     <date>            <chr>   <chr>  <chr>   <chr>     <dbl>
    ## 1 example_RW 2023-01-11 2023-01-10        BARC    ensem… 1       temper…    15.9
    ## 2 example_RW 2023-01-12 2023-01-10        BARC    ensem… 1       temper…    15.9
    ## 3 example_RW 2023-01-13 2023-01-10        BARC    ensem… 1       temper…    16.8
    ## 4 example_RW 2023-01-14 2023-01-10        BARC    ensem… 1       temper…    16.5
    ## 5 example_RW 2023-01-15 2023-01-10        BARC    ensem… 1       temper…    16.7
    ## 6 example_RW 2023-01-16 2023-01-10        BARC    ensem… 1       temper…    16.7
    ## # … with abbreviated variable names ¹​reference_datetime, ²​parameter, ³​variable,
    ## #   ⁴​prediction

## 6.2 Write the forecast to file

``` r
# Start by writing the forecast to file
theme <- 'aquatics'
date <- RW_forecasts_EFI$reference_datetime[1]
forecast_name_2 <- paste0(RW_forecasts_EFI$model_id[1], ".csv")
forecast_file_2 <- paste(theme, date, forecast_name_2, sep = '-')

write_csv(RW_forecasts_EFI, forecast_file_2)
```

## 6.3 Submit forecast

Files need to be in the correct format for submission. The forecast
organizers have created tools to help aid in the submission process.
These tools can be downloaded from Github using
`remotes::install_github(eco4cast/neon4cast)`. These include functions
for submitting, scoring and reading forecasts:

-   `submit()` - submit the forecast file to the neon4cast server where
    it will be scored
-   `forecast_output_validator()` - will check the file is in the
    correct format to be submitted
-   `check_submission()` - check that your submission has been uploaded
    to the server

``` r
neon4cast::forecast_output_validator(forecast_file_2)
```

    ## aquatics-2023-01-10-example_RW.csv

    ## ✔ file name is correct
    ## ✔ forecasted variables found correct variable + prediction column
    ## ✔ file has ensemble distribution in family column
    ## ✔ file has parameter and family column with ensemble generated distribution
    ## ✔ file has site_id column
    ## ✔ file has time column
    ## ✔ file has correct time column
    ## ✔ file has reference_datetime column
    ## Forecast format is valid

    ## [1] TRUE

This has checked that the file has a valid name and format that can be
submitted.

``` r
# can uses the neon4cast::forecast_output_validator() to check the forecast is in the right format
neon4cast::submit(forecast_file = forecast_file_2,
                  ask = F) # if ask = T (default), it will produce a pop-up box asking if you want to submit
```

## 6.4 TASKS

Possible modifications to the persistence RW model:

-   How does the number of ensembles change the uncertainty?
-   Are the transformations reasonable? Have a look
    [here](https://otexts.com/fpp3/ftransformations.html) about applying
    other types of transformations in Fable
-   Do you expect there to be a long term trends in that is not
    captured? Try adding a drift() term to the model

# 7 Model 3: Climatology model

An alternative approach is to look at the historic data to make
predictions about the future. The seasonal naive model in `fable` sets
each forecast to be equal to the last observed value, given the
specified lag. When we specify the lag to by 1 year, it will provide a
forecast that is the observations from the same day the previous year,
also known as a climatology model. Again we need to tidy the data to the
correct format for `fable`. We make sure there are explicit gaps (using
`fill_gaps()`) and make it into a tsibble object with `variable` and
`site_id` as the keys and `datetime` as the index. Then the `SNAIVE`
model is fit with a 1 year lag. One useful thing that the fable package
can do is that it fits the specified models to each `key` pairing
(variable, site_id) so you don’t have to specify each model for each
site and variable separately (we did not do this in Model 2 because each
site and variable has a different date of last observation).

``` r
SN_model <- targets %>%
  as_tsibble(key = c('variable', 'site_id'), index = 'datetime') %>%
  # add NA values up to today (index)
  fill_gaps(.end = Sys.Date()) %>%
  
  # Here we fit the model
  model(SN = SNAIVE(observation ~ lag('1 year')))
```

Then we use the model we’ve specified to forecast. `h = 30` specifies
the horizon of the forecast, relative to the index of the data (as 30
days). If the index, in this case `datetime`, had a different value such
as monthly, the `h =` value would be months. We use
`forecast(... , bootstrap = F)` to run a non-bootstrapped forecast. The
forecast will run for each key combination (variable-site_id). When
bootstrap = F, the model assumes a normal distribution. This would be an
example of a distributional forecast that can be submitted to the
Challenge.

``` r
SN_forecast <- SN_model %>% forecast(h = 30, bootstrap = F)
SN_forecast
```

    ## # A fable: 210 x 6 [1D]
    ## # Key:     variable, site_id, .model [7]
    ##    variable    site_id .model datetime   observation .mean
    ##    <chr>       <chr>   <chr>  <date>          <dist> <dbl>
    ##  1 temperature BARC    SN     2023-01-11  N(NA, 4.1)    NA
    ##  2 temperature BARC    SN     2023-01-12  N(NA, 4.1)    NA
    ##  3 temperature BARC    SN     2023-01-13  N(NA, 4.1)    NA
    ##  4 temperature BARC    SN     2023-01-14  N(NA, 4.1)    NA
    ##  5 temperature BARC    SN     2023-01-15  N(NA, 4.1)    NA
    ##  6 temperature BARC    SN     2023-01-16  N(NA, 4.1)    NA
    ##  7 temperature BARC    SN     2023-01-17  N(NA, 4.1)    NA
    ##  8 temperature BARC    SN     2023-01-18  N(NA, 4.1)    NA
    ##  9 temperature BARC    SN     2023-01-19  N(NA, 4.1)    NA
    ## 10 temperature BARC    SN     2023-01-20  N(NA, 4.1)    NA
    ## # … with 200 more rows

The output from this function is a `fable`. The prediction are held in
the `observation` column as a distribution, which gives the mean and
variance of the prediction. `N()` says that the distribution is normal,
and gives the mean and variance.

The challenge requires mean (mu) and standard deviation (sigma). We can
calculate the standard deviation of the predicted values using a
function to extract the variance and mean and create a table in the
right format for EFI. The sigma represents the uncertainty in the
forecast and is calculated from the residuals of the fitted model.

The columns needed for a distributional forecast are:

-   `datetime`: forecast timestamp
-   `reference_datetime`: The start of the forecast; this should be 0
    times steps in the future. This should only be one value of
    reference_datetime in the file
-   `site_id`: NEON code for site
-   `family`: name of probability distribution that is described by the
    parameter values in the parameter column; only normal or ensemble is
    currently allowed
-   `parameter`: required to be the string mu (mean) or sigma (standard
    deviation) or the ensemble number
-   `variable`: standardized variable name from the theme
-   `prediction`: forecasted value for parameter listed in the parameter
    column (sigma or mu)

``` r
convert_to_efi_standard <- function(df, model_id){
  ## determine variable name
  var <- attributes(df)$dist
  ## Normal distribution: use distribution mean and variance
  df %>% 
    dplyr::mutate(sigma = sqrt( distributional::variance( .data[[var]] ) ) ) %>%
    dplyr::rename(mu = .mean) %>%
    dplyr::select(datetime, site_id, .model, mu, sigma) %>%
    tidyr::pivot_longer(c(mu, sigma), names_to = "parameter", values_to = var) %>%
    dplyr::rename('prediction' = var) %>%
    mutate(family = "normal",
           reference_datetime = min(datetime) - lubridate::days(1),
           model_id = model_id, 
           variable = 'temperature') %>%
    select(any_of(c('model_id', 'datetime', 'reference_datetime', 
                    'site_id', 'family', 'parameter', 'variable', 'prediction')))
}
```

``` r
model_name <- 'example_climatology'
SN_forecast_EFI <- convert_to_efi_standard(SN_forecast, 
                                           model_id = model_name)
```

    ## # A tsibble: 420 x 8 [1D]
    ## # Key:       site_id, parameter [14]
    ##    model_id         datetime   referenc…¹ site_id family param…² varia…³ predi…⁴
    ##    <chr>            <date>     <date>     <chr>   <chr>  <chr>   <chr>     <dbl>
    ##  1 example_climato… 2023-01-11 2023-01-10 BARC    normal mu      temper…   NA   
    ##  2 example_climato… 2023-01-11 2023-01-10 BARC    normal sigma   temper…    2.03
    ##  3 example_climato… 2023-01-12 2023-01-10 BARC    normal mu      temper…   NA   
    ##  4 example_climato… 2023-01-12 2023-01-10 BARC    normal sigma   temper…    2.03
    ##  5 example_climato… 2023-01-13 2023-01-10 BARC    normal mu      temper…   NA   
    ##  6 example_climato… 2023-01-13 2023-01-10 BARC    normal sigma   temper…    2.03
    ##  7 example_climato… 2023-01-14 2023-01-10 BARC    normal mu      temper…   NA   
    ##  8 example_climato… 2023-01-14 2023-01-10 BARC    normal sigma   temper…    2.03
    ##  9 example_climato… 2023-01-15 2023-01-10 BARC    normal mu      temper…   NA   
    ## 10 example_climato… 2023-01-15 2023-01-10 BARC    normal sigma   temper…    2.03
    ## # … with 410 more rows, and abbreviated variable names ¹​reference_datetime,
    ## #   ²​parameter, ³​variable, ⁴​prediction

This is now in the correct format to be submitted to the Challenge.

![Figure: ‘seasonal naive’ forecasts for lake sites. Shade area show 95%
confidence
intervals](GLEON_forecast_challenge_files/figure-markdown_github/unnamed-chunk-41-1.png)
You can see that there are gaps in the forecasts. This is where there
was no observation for that day in the previous year. Ways we might fill
these gaps in the forecast include interpolating the values, or taking a
day-of-year mean for all years data.

## 7.1 Write the forecast for NEON EFI challenge

``` r
# Start by writing the forecast to file
# Start by writing the forecast to file
theme <- 'aquatics'
date <- RW_forecasts_EFI$reference_datetime[1]
forecast_name_3 <- paste0(SN_forecast_EFI$model_id[1], ".csv")
forecast_file_3 <- paste(theme, date, forecast_name_3, sep = '-')

write_csv(SN_forecast_EFI, forecast_file_3)
```

## 7.2 Submit forecast

Files need to be in the correct format with metadata for submission. The
forecast organisers have created tools to help aid in the submission
process. These tools can be downloaded from Github using
`remotes::install_github(eco4cast/neon4cast)`. These include functions
for submitting, scoring and reading forecasts:

-   `submit()` - submit the forecast file to the neon4cast server where
    it will be scored
-   `forecast_output_validator()` - will check the file is in the
    correct format to be submitted
-   `check_submission()` - check that your submission has been uploaded
    to the server

``` r
# can uses the neon4cast::forecast_output_validator() to check the forecast is in the right format
neon4cast::submit(forecast_file = forecast_file_3,
                  ask = F) # if ask = T (default), it will produce a pop-up box asking if you want to submit
```

## 7.3 TASKS

Possible modifications to Model 3 - Seasonal Naive Model:

-   Fill gaps in forecasts - how could we modify the targets/forecast to
    get a continuous forecast for all sites
-   Explore Seasonal Naive and other simple models in
    [fable](https://otexts.com/fpp3/simple-methods.html), try adding a
    drift parameter (a long-term warming trend for example)
-   Can we change the lag in the model?
-   Another type of climatology model could include data from all years
    of historic data (easier to implement outside fable)

# 8 Other things that might be useful

## 8.1 How the forecasts are scored?

The Challenge implements methods from the scoringRules R package to
calculate the Continuous Rank Probability Score (CRPS) via the
`score4cast` package. This scores the optimum is the minimum value, so
we are aiming for as small a value as possible. CRPS uses information
about the variance of the forecasts as well as the estimated mean to
calculate the score by comparing it with the observation. There is some
balance between accuracy and precision. The forecasts will also be
compared with ‘null’ models (RW and climatology) More info can be found
in the
[documentation](https://projects.ecoforecast.org/neon4cast-docs/Evaluation.html)
or the `score4cast` package from EFI organizers
[here](https://github.com/eco4cast/score4cast).

You can view past submissions [here:](https://shiny.ecoforecast.org/).
You can also the raw scores from the bucket directly. Have a look at the
get_scores.R file.

## 8.2 Other useful R packages

Check out the NEON4cast R package
([introduction](https://projects.ecoforecast.org/neon4cast-docs/Helpful-Functions.html),
and [github](https://github.com/eco4cast/neon4cast)) for other helpful
functions when developing your workflow for the submitting to the
challenge.

EFI has also produced a package that summarizes the proposed community
standards for the common formatting and archiving of ecological
forecasts. Such open standards are intended to promote interoperability
and facilitate forecast adoption, distribution, validation, and
synthesis
([introduction](https://projects.ecoforecast.org/neon4cast-docs/Helpful-Functions.html#efistandards-package)
and [github](https://github.com/eco4cast/EFIstandards))

## 8.3 Other weather variables

You can look at what other variables are available in the NOAA weather
data. There’s information in the [Challenge
documentation](https://projects.ecoforecast.org/neon4cast-docs/Shared-Forecast-Drivers.html)
too.

``` r
df_past %>%
  filter(site_id == 'ARIK',
         datetime > ymd('2022-01-01')) |> 
  dplyr::collect() |> 
  distinct(variable)
```

    ## # A tibble: 8 × 1
    ##   variable                                 
    ##   <chr>                                    
    ## 1 air_pressure                             
    ## 2 air_temperature                          
    ## 3 eastward_wind                            
    ## 4 northward_wind                           
    ## 5 precipitation_flux                       
    ## 6 relative_humidity                        
    ## 7 surface_downwelling_longwave_flux_in_air 
    ## 8 surface_downwelling_shortwave_flux_in_air

## 8.4 File format

The examples shown here, submit the forecast as a *csv* file but you can
also submit your forecasts in *NetCDF* format. See information
[here](https://projects.ecoforecast.org/neon4cast-docs/Submission-Instructions.html#step-1-forecast-file-format)
about the different file formats.

## 8.5 Automating your forecasting workflow

Automation is a key step to producing forecasts once you have your model
up and running and are happy with your forecasts. By automating your
forecasting workflow, reduces the “work” needed to produce the
forecasts. There are many ways to automate scripts that are written to
download observations and meteorology drivers, generate forecasts, and
submit forecasts. Two tools that many have used are cron jobs (see the R
package cronR) that execute tasks at user specifics times and github
actions. There are examples of how you might go about implementing this
in the [example github
repository](https://github.com/eco4cast/neon4cast-example), using github
actions and binder.

## 8.6 Alternative methods to loop through each variable-site_id combination

Using the `purrr` package we can also loop through each combination of
site_id and variable combination. This is more efficient computationally
than the for loop. You need to create a dataframe with each argument as
a column. Then specify this, along with the RW function as arguments in
`pmap_dfr`. The `dfr` part of the function specifies that the output
should be use row_bind into a dataframe.

``` r
site_var_combinations <- 
  # Gets every combination of site_id and variable
  expand.grid(site = unique(targets$site_id),
              var = unique(targets$variable)) %>%
  # assign the transformation depending on the variable.
  mutate(transformation = 'none') %>%
  mutate(boot_number = 200,
         h = 30,
         bootstrap = T, 
         verbose = T)

# Runs the RW forecast for each combination of variable and site_id
RW_forecasts <- purrr::pmap_dfr(site_var_combinations, RW_daily_forecast) 
```
