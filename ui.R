
library(shiny)

langs <- c("english")

shinyUI(fluidPage(
  headerPanel("Relative Age Based On Activity"),
  sidebarPanel(
    wellPanel(
      helpText(   a("Click Here to read the documentation",
                    href="https://github.com/mxp161/DevDatProd/master/README.md")
      )
    ),
    
    textInput("Current Age", "Enter Your Current Age", 
              value = "34"),
    
    selectInput("gender", "Select Your Gender:", choices = m/f/u,
                selected = "female"),

    selectInput("activity level", "How Many Weekly Minutes of Activity:", choices = 0-30,35-75,80+,0,
                selected = "30"),
    
    submitButton("Submit")
  ),
  
  mainPanel(
    
    h3("Age Categorization"),
    h4("The current age is:"),
    verbatimTextOutput("x"),
    h4("Your relative age is: "),
    verbatimTextOutput("y")

  )
  
))
