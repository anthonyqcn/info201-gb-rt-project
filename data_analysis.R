library('httr')
library('jsonlite')
library('dplyr')

source('./infor.R')


u_url <- "https://utelly-tv-shows-and-movies-availability-v1.p.mashape.com/lookup"
u_param <- list(country='us', term='La La Land')
u_request <- GET(u_url, query = u_param, add_headers("X-Mashape-Key" = "HQmWI1Np7FmshrIu0cWO1GgbBoNlp1QHYMbjsnbezAlS18DkgP","Accept" = "application/json"))
u_data <- content(u_request, "text")
u_ret <- fromJSON(u_data)

u_data <- u_ret[['results']]

u_new_test <- u_data['locations'][1,1][[1]]['display_name']
u_readable <- paste( unlist(u_new_test), collapse=', ')


o_url <- "http://www.omdbapi.com/"
o_param <- list(apikey='ca039e', t='La La Land')
o_request <- GET(o_url, query = o_param)
o_data <- content(o_request, "text")
o_ret<- fromJSON(o_data)
o_ratings <- o_ret$'Ratings'

df_names <- c('Movie Name', 'iMDB Rating', 'Rotten Tomatoes Score', 'MetaCritic Score', 'Streaming Location')
