library(quantmod)
library(dplyr)
library(tidyverse)
# Getting the stock data for three companies
getSymbols(c("NFLX","T","DIS", "AMZN"))

# Merging the stock data into one data frame
stocks <- data.frame("Netflix" = NFLX$NFLX.Close, "HBO" = T$T.Close, "Disney"=DIS$DIS.Close, "Amazon" = AMZN$AMZN.Close, "Date" = as.Date(row.names(as.data.frame(NFLX))))

# Reshaping the data frame so one column contains the type of stock
graphable <- stocks %>% gather(key = "stock", value = "value", -Date)

# Graphing the stock prices
graphable %>% ggplot() + geom_line(aes(x = Date, y= value, color = stock)) +
  scale_color_discrete(name = "Company", labels = c("Amazon", "Disney", "Netflix", "AT&T (HBO)")) + 
  labs(title = "Stock Prices of Streaming Services", y = "Stock Price")
