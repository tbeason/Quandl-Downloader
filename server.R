##server.R
library(shiny)
library(Quandl)
#library(stringr)

symbolList <- reactiveFileReader(100,NULL,'https://s3.amazonaws.com/quandl-static-content/Ticker+CSV%27s/WIKI_tickers.csv',read.csv,stringsAsFactors=FALSE,header=TRUE)

shinyServer(function(input, output,session) {
#   prettyCodes <- function(aCode){
#     str_sub(aCode,6,-1)
#   }
  
#   searchHelperList <- reactive({
#     
#   })
#   displayList <- reactive({
#     vapply(X=symbolList()[,1], FUN=prettyCodes())
#   })
  
  #observe({updateSelectizeInput(session,'stocks',choices=symbolList()[,1],server=TRUE)})
  
  output$downloadData <- downloadHandler(
    filename = function() { 
      paste(input$filename, '.tar', sep='') 
    },
    content = function(file) {
      write.csv(datasetInput(), file)
    }
  )
})