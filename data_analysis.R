library('httr')
library('jsonlite')
library('dplyr')

movies <- c("The Shawshank Redemption", "The Godfather",
            "The Godfather: Part II", "The Dark Knight", "12 Angry Men",
            "Schindler's List", "The Lord of the Rings: The Return of the King",
            "Pulp Fiction", "The Good, the Bad and the Ugly", "Fight Club",
            "The Lord of the Rings: The Fellowship of the Ring", "Forrest Gump",
            "Star Wars: Episode V - The Empire Strikes Back", "Inception",
            "The Lord of the Rings: The Two Towers", "One Flew Over the Cuckoo's Nest",
            "Goodfellas", "The Matrix", "Seven Samurai", "City of God", "Se7en",
            "Star Wars: Episode IV - A New Hope", "The Silence of the Lambs",
            "It's a Wonderful Life", "Life Is Beautiful", "The Usual Suspects",
            "Spirited Away", "Saving Private Ryan", "Leon: The Professional",
            "The Green Mile", "Interstellar", "Psycho", "American History X",
            "City Lights", "Once Upon a Time in the West", "Casablanca", "Modern Times",
            "The Pianist", "The Intouchables", "The Departed",
            "Terminator 2: Judgment Day", "Back to the Future", "Whiplash", "Rear Window",
            "Raiders of the Lost Ark", "The Lion King", "Gladiator", "The Prestige",
            "Apocalypse Now", "Memento", "Alien", "Avengers: Infinity War",
            "The Great Dictator", "Cinema Paradiso", "Grave of the Fireflies",
            "Sunset Boulevard", "The Lives of Others",
            "Dr. Strangelove or: How I Learned to Stop Worrying and Love the Bomb",
            "Paths of Glory", "The Shining", "Django Unchained", "WALL-E",
            "Princess Mononoke", "Witness for the Prosecution", "American Beauty",
            "The Dark Knight Rises", "Oldboy", "Aliens", "Once Upon a Time in America",
            "Coco", "Das Boot", "Citizen Kane", "Braveheart", "Vertigo",
            "North by Northwest", "Reservoir Dogs",
            "Star Wars: Episode VI - Return of the Jedi", "M", "Your Name", "Amadeus",
            "Dangal", "Requiem for a Dream", "Like Stars on Earth", "Lawrence of Arabia",
            "Eternal Sunshine of the Spotless Mind", "A Clockwork Orange",
            "2001: A Space Odyssey", "Amelie", "3 Idiots", "Double Indemnity", "Toy Story",
            "Taxi Driver", "Singin' in the Rain", "Inglourious Basterds",
            "Full Metal Jacket", "To Kill a Mockingbird", "Bicycle Thieves", "The Kid",
            "The Sting", "Toy Story 3")

imdb <- c()
rt <- c()
mc <- c()
stream <- c()
u_url <- "https://utelly-tv-shows-and-movies-availability-v1.p.mashape.com/lookup"
o_url <- "http://www.omdbapi.com/"

create_imdb <- function(movie) {
  param <- list(apikey='ca039e', t=movie)
  request <- GET(o_url, query = param)
  data <- content(request, "text")
  ret <- fromJSON(data)
  if (length(ret$'Ratings') > 0 && length(ret$'Ratings'[1,2]) > 0) {
    imdb <- append(imdb, ret$'Ratings'[1,2])
  } else {
    imdb <- append(imdb, NA)
  }
}

create_rt <- function(movie) {
  param <- list(apikey='ca039e', t=movie)
  request <- GET(o_url, query = param)
  data <- content(request, "text")
  ret <- fromJSON(data)
  if (length(ret$'Ratings') > 0 && length(ret$'Ratings'[2,2]) > 0) {
    rt <- append(rt, ret$'Ratings'[2,2])
  } else {
    rt <- append(rt, NA)
  }
}

create_mc <- function(movie) {
  param <- list(apikey='ca039e', t=movie)
  request <- GET(o_url, query = param)
  data <- content(request, "text")
  ret <- fromJSON(data)
  if (length(ret$'Ratings') > 0 && length(ret$'Ratings'[3,2]) > 0) {
    mc <- append(mc, ret$'Ratings'[3,2])
  } else {
    mc <- append(mc, NA)
  }
}

create_stream <- function(movie) {
  param <- list(country='us', term=movie)
  request <- GET(u_url, query = param, add_headers("X-Mashape-Key" = "HQmWI1Np7FmshrIu0cWO1GgbBoNlp1QHYMbjsnbezAlS18DkgP","Accept" = "application/json"))
  data <- content(request, "text", encoding = 'UTF-8')
  ret <- fromJSON(data)
  data <- ret[['results']]
  if (length(data) > 0) {
    ref_ret <- data['locations'][1,1][[1]]['display_name']
    readable <- paste(unlist(ref_ret), collapse=', ')
    stream <- append(stream, readable)
  } else {
    stream <- append(stream, 'N/A')
  }
}

imdb <- sapply(movies, create_imdb)
rt <- sapply(movies, create_rt)
mc <- sapply(movies, create_mc)
stream <- sapply(movies, create_stream)


movie_data <- data.frame(movies, imdb, rt, mc, stream, stringsAsFactors = FALSE)
row.names(movie_data) <- NULL
colnames(movie_data) <- c('Movie Title', 'iMDB Score', 'Rotten Tomatoes Score', 'MetaCritic Score', 'Available Streams')
write.csv(movie_data,'movie_data.csv')