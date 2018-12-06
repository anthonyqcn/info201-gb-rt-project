# INFO 201 Project Proposal: Movie Quality Control
## Joon Kim, Brandon Lee, Anthony Nguyen
### GitHub Repository: https://github.com/anthonyqcn/info201-gb-rt-project
### Shiny App Link: https://anthonyqcn.shinyapps.io/info201-gb-rt-project/

### About the App

#### The Basic Idea

Our project combines the uTelly API and Open Movie Database (OMDB) API in determining various metrics by which users can compare and contrast movie quality on multiple streaming services. The specific streaming services data we are pulling from the uTelly API are Amazon Instant Videos, Amazon Prime, Netflix, and iTunes. We will be pulling the audience and critic rating data from the OMDB.

#### Details of Functionality

Specifically, the project is a Shiny App that uses a list of the 100 movies on the iMDB with the highest score and creates a dataframe with each movie's iMDB, Rotten Tomatoes, and MetaCritic scores (all of which are available on the OMDB), along with the uTelly's data on where each movie can be streamed from. With that dataframe, the app then creates a static barplot comparing the number of top-100 movies each of the four streaming services has available.

The Shiny App also features a custom search functionality, in which a user can type in the name of any movie of their choice, and there will be a live call to both APIs to create a one-row dataframe similar to a row of the graph above. After creating that row, the app also creates a barplot comparing the iMDB, Rotten Tomatoes, and MetaCritic scores of that movie so that the user can see if the movie they are interested in has consistent ratings across the three main scoring systems.
