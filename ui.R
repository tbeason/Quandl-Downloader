## ui.R
library(shiny)

shinyUI(fluidPage(
  title = "Stock Data Downloader",
  
  includeMarkdown('welcome.md'),
  
  hr(),
  
  fluidRow(
    column(4,
           h4("Stock Selection"),
           selectizeInput(
             'stocks', 'Max of 25', choices = NULL,
             multiple = TRUE, options = list(maxItems = 25)
           ),
           helpText("Type to search. Use Backspace or Delete to remove selected items.")
    ),
    column(4,
           h4("Date Selection"),
           dateRangeInput('dateRange',
                          label = 'Date range input: yyyy-mm-dd',
                          start = Sys.Date() - 30, end = Sys.Date()
           ),
           br(),
           radioButtons('frequency', 'Data Frequency',
              choices=list("Daily"="daily","Weekly"="weekly","Monthly"="monthly","Annual"="annual"),selected = "daily"
                )
    ),
    column(4,
           h4("Download Options"),
           textInput("filename", "File Name:", "stockdata"),
           helpText("Do not put a file extension in the name."),
           br(),
           downloadButton('downloadData', 'Download'),
           helpText("Download times depend on the number of data points being fetched.")
    )
  ),
  br(),
  hr(),
  fluidRow(
    column(12,
           includeMarkdown("footer.md")
    )
  )
))