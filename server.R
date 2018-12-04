myserver <- function(input, output){
  u_url <- "https://utelly-tv-shows-and-movies-availability-v1.p.mashape.com/lookup"
  o_url <- "http://www.omdbapi.com/"
  
  search_imdb <- function(movie) {
    o_param <- list(apikey='ca039e', t=movie)
    o_request <- GET(o_url, query = o_param)
    o_data <- content(o_request, "text")
    o_ret<- fromJSON(o_data)
    if (length(o_ret$'Ratings'[1,2]) > 0) {
      return(o_ret$'Ratings'[1,2])
    } else {
      return('N/A')
    }
  }
  
   search_rt <- function(movie) {
    o_param <- list(apikey='ca039e', t=movie)
    o_request <- GET(o_url, query = o_param)
    o_data <- content(o_request, "text")
    o_ret<- fromJSON(o_data)
    if (length(o_ret$'Ratings'[2,2]) > 0) {
      return(o_ret$'Ratings'[2,2])
    } else {
      return('N/A')
    }
  }
  
  search_mc <- function(movie) {
    o_param <- list(apikey='ca039e', t=movie)
    o_request <- GET(o_url, query = o_param)
    o_data <- content(o_request, "text")
    o_ret<- fromJSON(o_data)
    if (length(o_ret$'Ratings'[3,2]) > 0) {
      return(o_ret$'Ratings'[3,2])
    } else {
      return('N/A')
    }
  }
  
  search_stream <- function(movie) {
    u_param <- list(country='us', term=movie)
    u_request <- GET(u_url, query = u_param, add_headers("X-Mashape-Key" = "HQmWI1Np7FmshrIu0cWO1GgbBoNlp1QHYMbjsnbezAlS18DkgP","Accept" = "application/json"))
    u_data <- content(u_request, "text", encoding = 'UTF-8')
    u_ret <- fromJSON(u_data)
    u_data <- u_ret[['results']]
    if (length(u_data) > 0) {
      u_new_test <- u_data['locations'][1,1][[1]]['display_name']
      u_readable <- paste(unlist(u_new_test), collapse=', ')
      return(u_readable)
    } else {
      return('Nowhere!')
    }
  }
  
  #output$table <- renderTable({
  
    
  #})
  #output$text <- renderText({
    
  #})
  output$search_results = DT::renderDataTable({
    s_imdb <- search_imdb(input$searcher)
    s_rt <- search_rt(input$searcher)
    s_mc <- search_mc(input$searcher)
    s_stream <- search_stream(input$searcher)
    search_output <- data.frame(input$searcher, s_imdb, s_rt, s_mc, s_stream)
    colnames(search_output) <- c('Movie Title', 'iMDB Score', 'Rotten Tomatoes Score', 'MetaCritic Score', 'Available Streams')
  })
}

shinyServer(myserver)


