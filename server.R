library("shiny")
library('DT')
library('httr')
library('jsonlite')
library('dplyr')

server <- function(input, output){
  imdb_data = read.csv("movie_data.csv", header = FALSE, stringsAsFactors = FALSE)
  imdb_data <- select(imdb_data, 'V2', 'V3', 'V4', 'V5', 'V6')
  colnames(imdb_data) <- as.character(imdb_data[1,])
  imdb_data <- filter(imdb_data, imdb_data$'Movie Title' != 'Movie Title')
  
  o_url <- "http://www.omdbapi.com/"
  u_url <- "https://utelly-tv-shows-and-movies-availability-v1.p.mashape.com/lookup"

  omdb_search <- function(movie) {
    results <- c()
    param <- list(apikey='ca039e', t=movie)
    request <- GET(o_url, query = param)
    data <- content(request, "text")
    ret <- fromJSON(data)
    if (ret$'Response'=='True') {
      results[1] <- ret$'Title'
      if (length(ret$'Ratings') > 0) {
        if (length(ret$'Ratings'[1,2]) > 0) {
          results[2] <- ret$'Ratings'[1,2]
        } else {
          results[2] <- 'N/A'
        }
        if (length(ret$'Ratings'[2,2]) > 0) {
          results[3] <- ret$'Ratings'[2,2]
        } else {
          results[3] <- 'N/A'
        }
        if (length(ret$'Ratings'[2,2]) > 0) {
          results[4] <- ret$'Ratings'[2,2]
        } else {
          results[4] <- 'N/A'
        }
      } else {
        results[1:4] <- 'N/A'
      }
    } else {
      results[1:4] <- 'N/A'
    }
    return(results)
  }

  utelly_search <- function(movie) {
    param <- list(country='us', term=movie)
    request <- GET(u_url, query = param, add_headers("X-Mashape-Key" = "HQmWI1Np7FmshrIu0cWO1GgbBoNlp1QHYMbjsnbezAlS18DkgP","Accept" = "application/json"))
    data <- content(request, "text", encoding = 'UTF-8')
    ret <- fromJSON(data)
    if (ret$status_code == '200') {
      data <- ret[['results']]
      if (length(data) > 0) {
        ref_ret <- data['locations'][1,1][[1]]['display_name']
        readable <- paste(unlist(ref_ret), collapse=', ')
        return(readable)
      } else {
        return('N/A')
      }
    } else {
      return('N/A')
    }
  }

  output$search_results <- renderTable({
    s_omdb <- omdb_search(input$searcher)
    Availability <- utelly_search(input$searcher)
    Movie <- s_omdb[1]
    iMDB <- s_omdb[2]
    Tomatometer <- s_omdb[3]
    MetaCritic <- s_omdb[4]
    search_output <- data.frame(Movie, iMDB, Tomatometer, MetaCritic, Availability)
  })
  
  output$search_ratings <- renderPlot({
    ratings <- omdb_search(input$searcher)[2:4]
    if (ratings[1] != 'N/A' && ratings[2] != 'N/A' && ratings[3] != 'N/A') {
      ratings[1] <- strsplit(ratings[1], '/')[[1]][1]
      ratings[2] <- strsplit(ratings[2], '%')[[1]][1]
      ratings[3] <- strsplit(ratings[3], '%')[[1]][1]
      ratings[1] <- as.numeric(ratings[1])
      print(ratings[1])
      graph_result <- barplot(c(as.numeric(ratings[1]) * 10, as.numeric(ratings[2]), as.numeric(ratings[3])),
                              names.arg = c('iMDB', 'Tomatometer', 'MetaCritic'),
                              xlab = "Rating Source",
                              ylab = "Rating %",
                              main = "Rating of the Given Movie Across iMDB, RT, and MC",
                              col = c('Yellow', 'Red', 'Black'),
                              cex.names=1.5,
                              cex.axis=1.5,
                              cex.lab=1.5,
                              cex.main=1.5)
    }
    
  })
  
  output$streaming_graph <- renderPlot({
    nowhere <- length(grep("N/A", imdb_data$'Available Streams'))
    netflix <- length(grep("Netflix", imdb_data$'Available Streams'))
    itunes <- length(grep("iTunes", imdb_data$'Available Streams'))
    amazon_instant <- length(grep("Amazon Instant", imdb_data$'Available Streams'))
    amazon_prime <- length(grep("Amazon Prime", imdb_data$'Available Streams'))
    services <- c(netflix, itunes, amazon_instant, amazon_prime, nowhere)
    names <- c("Netflix", "iTunes", "Amazon Instant", "Amazon Prime", "Nowhere")
    colors <- c("Red", "White", "Light Blue", "Blue", "Black")
    graph_result <- barplot(services,
                            names.arg = names,
                            xlab = "Streaming Services",
                            ylab = "# of Movies",
                            main = "# of Movies Streamed by Services in Top 100 Movies",
                            col = colors,
                            cex.names=1.5,
                            cex.axis=1.5,
                            cex.lab=1.5,
                            cex.main=1.5)
  })

  output$imdb_table = DT::renderDataTable({
   imdb_data
  })

}

shinyServer(server)


