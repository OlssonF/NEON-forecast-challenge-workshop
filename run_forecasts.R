
# Script to run forecasts
source('./models/ARIMA_model.R')
message('ARIMA model submitted')
source('./models/TSLM_lags.R')
message('TSLM_lagged model submitted')