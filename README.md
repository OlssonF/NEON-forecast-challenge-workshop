# NEON-forecast-challenge workshop for GLEON2022
Repo for the workshop materials used in the Forecast Challenge part of the GLEON2022 workshop.

```{r gh-installation, eval = FALSE}
The following packages will need to be installed
install.packages('remotes')
install.packages('fpp3') # package for applying simple forecasting methods
install.packages('tsibble') # package for dealing with time series data sets and tsibble objects
install.packages('tidyverse') # collection of R packages for data manipulation, analysis, and visualisation
install.packages('lubridate') # working with dates and times
remotes::install_github('eco4cast/neon4cast') # package from NEON4cast challenge organisers to assist with forecast building and submission
```
R version 4.2 is required to run the neon4cast package. It's also worth checking your Rtools is up to date. 

For the workshop you can follow along via the rmarkdown document (GLEON_forecast_challenge.Rmd) or the html (GLEON_forecast_challenge.html), both of which can be downloaded here or you can fork the whole repository.
