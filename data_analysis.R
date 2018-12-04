library('httr')
library('jsonlite')
library('dplyr')

source('infor.R')

stream <- c()
imdb <- c()
rt <- c()
mc <- c()
u_url <- "https://utelly-tv-shows-and-movies-availability-v1.p.mashape.com/lookup"
o_url <- "http://www.omdbapi.com/"

create_imdb <- function(movie) {
  o_param <- list(apikey='ca039e', t=movie)
  o_request <- GET(o_url, query = o_param)
  o_data <- content(o_request, "text")
  o_ret<- fromJSON(o_data)
  if (length(o_ret$'Ratings'[1,2]) > 0) {
    imdb <- append(imdb, o_ret$'Ratings'[1,2])
  } else {
    imdb <- append(imdb, 'N/A')
  }
}

create_rt <- function(movie) {
  o_param <- list(apikey='ca039e', t=movie)
  o_request <- GET(o_url, query = o_param)
  o_data <- content(o_request, "text")
  o_ret<- fromJSON(o_data)
  if (length(o_ret$'Ratings'[2,2]) > 0) {
    rt <- append(rt, o_ret$'Ratings'[1,2])
  } else {
    rt <- append(rt, 'N/A')
  }
}

create_mc <- function(movie) {
  o_param <- list(apikey='ca039e', t=movie)
  o_request <- GET(o_url, query = o_param)
  o_data <- content(o_request, "text")
  o_ret<- fromJSON(o_data)
  if (length(o_ret$'Ratings'[3,2]) > 0) {
    mc <- append(mc, o_ret$'Ratings'[1,2])
  } else {
    mc <- append(mc, 'N/A')
  }
}

stream_finder <- function(movie) {
  u_param <- list(country='us', term=movie)
  u_request <- GET(u_url, query = u_param, add_headers("X-Mashape-Key" = "HQmWI1Np7FmshrIu0cWO1GgbBoNlp1QHYMbjsnbezAlS18DkgP","Accept" = "application/json"))
  u_data <- content(u_request, "text", encoding = 'UTF-8')
  u_ret <- fromJSON(u_data)
  u_data <- u_ret[['results']]
  if (length(u_data) > 0) {
    u_new_test <- u_data['locations'][1,1][[1]]['display_name']
    u_readable <- paste(unlist(u_new_test), collapse=', ')
    stream <- append(stream, u_readable)
  } else {
    stream <- append(stream, 'Nowhere!')
  }
}

imdb <- sapply(movies, create_imdb)
rt <- sapply(movies, create_rt)
mc <- sapply(movies, create_mc)
stream <- sapply(movies, stream_finder)



movie_data <- data.frame(movies, imdb, rt, mc, stream, stringsAsFactors = FALSE)
row.names(movie_data) <- NULL

