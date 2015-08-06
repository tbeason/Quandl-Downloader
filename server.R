##server.R
library(shiny)
library(Quandl)
library(stringr)

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
  
  observe({updateSelectizeInput(session,'stocks',choices=symbolList()[,2],server=TRUE)})
  
  output$downloadData <- downloadHandler(
    filename = function() { 
      paste(input$filename, '.tgz', sep='') 
    },
    content = function(file) {
      selected <- input$stocks
      sList <- symbolList()
      rowIndex <- unlist(sapply(selected,function(x){which(sList[,2]==x)}))
      pullList <- sList[rowIndex,1]
      pullFun <- function(pList){
        startDate <- input$dateRange[[1]]
        endDate <- input$dateRange[[2]]
        freq <- input$frequency
        
        pullOne <- function(pCode){
          fName <- str_replace(pCode,"/","-")
          write.zoo(Quandl(pCode,type="xts",start_date = startDate,end_date = endDate,collapse = freq),file=paste("temp/",fName,".csv",sep=""),index.name = "Date",sep=",")
        }
        
        sapply(pullList, pullOne)
      }
      
      pullFun(pullList)
      
      tar(paste(input$filename,'.tgz',sep=""),list.files(), compression = 'gzip')
      if (file.exists(paste0(input$filename, ".tgz")))
        file.rename(paste0(input$filename, ".tgz"), file)
    }

  )
})