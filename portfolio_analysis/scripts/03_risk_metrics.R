# Load libraries
library(PerformanceAnalytics)

# Define equal weights for each asset
weights <- rep(1/length(tickers), length(tickers))

# Portfolio returns
portfolio_returns <- Return.portfolio(returns, weights = weights)

# Annualized return metrics
annualized_metrics <- table.AnnualizedReturns(portfolio_returns)
print(annualized_metrics)

# Sharpe Ratio
sharpe_ratio <- SharpeRatio.annualized(portfolio_returns)
print(sharpe_ratio)

# Maximum Drawdown
drawdown <- maxDrawdown(portfolio_returns)
print(drawdown)

# Value at Risk (95% confidence)
value_at_risk <- VaR(portfolio_returns, p = 0.95, method = "historical")
print(value_at_risk)
