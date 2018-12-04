source("data_analysis.R")

nowhere <- length(grep("Nowhere!", movie_data$stream))
netflix <- length(grep("Netflix", movie_data$stream))
itunes <- length(grep("iTunes", movie_data$stream))
amazon_instant <- length(grep("Amazon Instant", movie_data$stream))
amazon_prime <- length(grep("Amazon Prime", movie_data$stream))
colnames(movie_data) <- c('Movie Title', 'iMDB Score', 'Rotten Tomatoes Score', 'MetaCritic Score', 'Available Streams')

services <- c(netflix, itunes, amazon_instant, amazon_prime, nowhere)
names <- c("Netflix", "iTunes", "Amazon Instant", "Amazon Prime", "Nowhere")
colors <- c("Red", "White", "Light Blue", "Blue", "Black")
barplot(services,
        names.arg = names,
        xlab = "Streaming Services",
        ylab = "# of Movies",
        main = "# of Movies Streamed by Services in Top 100 Movies",
        col = colors)
