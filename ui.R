ui <- fluidPage(
  titlePanel("Movie Quality and Quantity App"),
  textInput("searcher", "Search Movies"),
  tableOutput("search_results"),
  plotOutput('search_ratings', width='50%', height='300px'),
  plotOutput("streaming_graph", height="700px"),
  h2("Top 100 iMDB Movies and Where to Find Them"),
  DT::dataTableOutput("imdb_table")
)

shinyUI(ui)
