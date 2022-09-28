installed_packages <- installed.packages()
if (is.element('feasts', installed_packages) == F) {
  install.packages('feasts')
}

# Script to run forecasts
source('./Models/ARIMA_model.R')
message('ARIMA model submitted')
source('./Models/TSLM_lags.R')
message('TSLM_lagged model submitted')
