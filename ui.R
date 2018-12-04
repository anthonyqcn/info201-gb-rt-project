library("shiny")
    
my_ui <- fluidPage(
  titlePanel("movies"),
  sidebarLayout(
    sidebarPanel(
      selectInput("list", "Select a Movie", choices = datamovies$movies)
      ),
    
     textInput("new", "New movies")
      ),
    
  mainPanel(
    tableOutput("table"),
    textOutput("text")
      )
    )
  

  
  
  
shinyUI(my_ui)
