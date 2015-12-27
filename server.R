
library(stringr)
library(tm)
library(plyr) 


shinyServer(function(input, output,sessoin) {
  
  h <- reactive({
    return(input$CurrAge)
  })
    
        
  matchSubject <- function (x)
  {

    ####################
    ### AgeSimCalc ###
    ####################
    ageSim <- read.csv("ageSim.txt", header=FALSE)
    colnames(ageSim) <- c("years", "calcs")
    ageSim$calcs <- as.character(ageSim$calcs)
    ageSim$calcs <- as.integer(ageSim$calc)
    head(ageSim$calcs,3)
    
    numberItemsSims <- length(ageSim$calcs)
    
    ##################################
    ### Creating Ngrams from input ###
    ##################################
    
    CurrAge <- Corpus(VectorSource(input$CurrAge))
    #To determine calc for relative age limits
    CurrAge <- tm_map(CurrAge, content_transformer(relAge))
    CurrAge <- tm_map(CurrAge, removePunctuation)
    CurrAge <- tm_map(CurrAge , stripWhitespace)
    CurrAge <- tm_map(CurrAge, removeWords, stopwords("abc#")) 
    CurrAge <- tm_map(CurrAge, stemDocument, language = "#xyz") 
    
    # Ngrams
    BigramTokenizer <- function(x) NGramTokenizer(x, Weka_control(min = 2, max = 2))
    inputNgrams <- BigramTokenizer(CurrAge)
    
    #####################################
    ### Match Ngrams in relAge ###
    #####################################
    aux = 0
    for (i in 1:length(inputNgrams))
    {
      if (is.na(as.vector(table(relAge$stats == inputNgrams[i])[2])))
      {
        aux = 0
        relAge <- Stats + aux
      } else {
        aux = as.vector(table(relAge$stats == inputNgrams[i])[2])
        relAge <- stats + aux
      }
    }  
    relAge <- stats/numberItemsAge
   
    
    
    ##################################
    ### Setting the age classifier ###
    ##################################
    if ((ratingAge > ratingRel) & (ratingAge > ratingStat))
    {
      return('about RelAge')
    }else if ((ratingStat > ratingAge) & (ratingRel > ratingStat)){
      return('about Relative Age' )
    }else{
      return('about Relative Stat'  )
    }
  }
  
  
  output$CurrAge <- renderText({hi <- h()})
  output$categorization <- renderText({
    matchSubject(input$CurrAge)
    })
  
  
})
