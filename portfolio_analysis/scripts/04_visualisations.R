# Load libraries
library(PerformanceAnalytics)

# Cumulative portfolio growth
chart.CumReturns(portfolio_returns, main = "Cumulative Portfolio Returns", legend.loc = "topleft")

# Cumulative returns for individual assets
chart.CumReturns(returns, legend.loc = "topleft", main = "Cumulative Returns of Individual Assets")
