library(datasets)
library(plotly)
library(lubridate)

Seatbelts_df <- data.frame(Seatbelts)
Seatbelts_df$t <- date_decimal(as.vector(time(Seatbelts[,0])))

introduction <- as.POSIXct('1983-01-31', tz = "UTC")
Seatbelts_df$kms <- Seatbelts_df$kms / 1000

plot <- plot_ly(Seatbelts_df, x = ~t, y = ~(drivers + front + rear)/kms,
                name = 'all', type = 'scatter', mode = 'lines+markers') %>%
  add_trace(y = ~drivers/kms, name = 'drivers', mode = 'lines+markers') %>%
  add_trace(y = ~front/kms, name = 'front-seat passengers', mode = 'lines+markers') %>%
  add_trace(y = ~rear/kms, name = 'rear-seat passengers', mode = 'lines+markers') %>%
  add_trace(y = ~DriversKilled/kms, name = 'onlycar drivers killed', mode = 'lines+markers', line = list(color='black')) %>%
  add_trace(x = introduction, y=c(0,400), name = "1983-01-31: introduction\nof compulsory seat\nbelts wearing", mode = "lines", line = list(color='red')) %>%
  layout(title = "Monthly totals of car drivers in Great Britain killed or seriously injured",
         yaxis = list(title = "per distance driven"))

plot
