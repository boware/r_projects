
---

### `app.R`
```r
# Load packages
library(shiny)
library(quantmod)
library(PerformanceAnalytics)

# Define UI
ui <- fluidPage(
  titlePanel("📊 Live Portfolio Performance Dashboard"),
  
  sidebarLayout(
    sidebarPanel(
      dateRangeInput("dates", "Select Date Range:",
                     start = "2023-01-01", 
                     end = Sys.Date()),
      
      checkboxGroupInput("assets", "Choose Assets:",
                         choices = c("AAPL", "MSFT", "GOOG", "TSLA", "SPY"),
                         selected = c("AAPL", "MSFT", "GOOG", "TSLA", "SPY"))
    ),
    
    mainPanel(
      tabsetPanel(
        tabPanel("Cumulative Returns", plotOutput("cumReturnsPlot")),
        tabPanel("Risk Metrics", verbatimTextOutput("riskMetrics"))
      )
    )
  )
)

# Define server
server <- function(input, output) {
  
  dataInput <- reactive({
    getSymbols(input$assets, src = "yahoo", 
               from = input$dates[1], to = input$dates[2], 
               auto.assign = TRUE)
    
    prices <- do.call(merge, lapply(input$assets, function(ticker) Ad(get(ticker))))
    colnames(prices) <- input$assets
    
    returns <- na.omit(Return.calculate(prices, method = "log"))
    return(returns)
  })
  
  output$cumReturnsPlot <- renderPlot({
    returns <- dataInput()
    chart.CumReturns(returns, legend.loc = "topleft", main = "Cumulative Returns")
  })
  
  output$riskMetrics <- renderPrint({
    returns <- dataInput()
    weights <- rep(1 / ncol(returns), ncol(returns))
    port_returns <- Return.portfolio(returns, weights = weights)
    
    metrics <- list(
      Annualized_Return = round(table.AnnualizedReturns(port_returns)[1,1], 4),
      Sharpe_Ratio = round(SharpeRatio.annualized(port_returns), 4),
      Max_Drawdown = round(maxDrawdown(port_returns), 4),
      VaR_95 = round(VaR(port_returns, p = 0.95, method = "historical"), 4)
    )
    
    print(metrics)
  })
}

# Run app
shinyApp(ui = ui, server = server)
