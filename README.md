# NEON-forecast-challenge-workshop materials
This is a repository for for the workshop materials initally used in the Forecast Challenge part of the GLEON2022 workshop.

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

For the workshop you can follow along via the rmarkdown document (NEON_forecast_challenge_workshop.Rmd) or the md (NEON_forecast_challenge_workshop.md), both of which can be downloaded here or you can fork the whole repository.
