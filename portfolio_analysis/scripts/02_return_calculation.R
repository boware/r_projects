# Load required libraries
if (!require("PerformanceAnalytics")) install.packages("PerformanceAnalytics", dependencies=TRUE)
library(PerformanceAnalytics)

# Calculate daily log returns
returns <- na.omit(Return.calculate(prices, method = "log"))

# Preview returns
head(returns)
