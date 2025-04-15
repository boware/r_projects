# Install and load packages
if (!require("quantmod")) install.packages("quantmod", dependencies=TRUE)
library(quantmod)

# Define tickers and date range
tickers <- c("AAPL", "MSFT", "GOOG", "TSLA", "SPY")
start_date <- as.Date("2023-01-01")
end_date <- Sys.Date()

# Download stock prices
getSymbols(tickers, src = "yahoo", from = start_date, to = end_date)

# Combine adjusted closing prices
prices <- do.call(merge, lapply(tickers, function(ticker) Ad(get(ticker))))

# Rename columns
colnames(prices) <- tickers

# Preview
head(prices)
