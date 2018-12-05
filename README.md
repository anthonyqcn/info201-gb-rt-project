# INFO 201 Project Proposal: Movie Quality Control
## Joon Kim, Brandon Lee, Anthony Nguyen
## GitHub Repository: https://github.com/anthonyqcn/info201-gb-rt-project
## Shiny App Link: https://anthonyqcn.shinyapps.io/info201-gb-rt-project/

### Basic Information

Our project will combine the uTelly API and Fandango’s Rotten Tomatoes API (requires sign up/in) in determining various metrics by which users can compare and contrast movie quality on multiple streaming services. The specific streaming services data we are pulling from the uTelly API are Amazon Instant Videos, Amazon Prime, Netflix, and iTunes. We will be pulling the audience and critic rating data from the Rotten Tomatoes API. Both APIs contain movie titles that can be used as a merge key to compare and contrast the movie ratings and the streaming services they can be found on.  

#### Target Audience: 
Avid movie watchers, primarily 18 - 25 year olds, who care about the quality of their content.

#### Questions to Answer:

1. Which movies have the highest ratings and which streaming service(s) can they be viewed through? Which are unique to a single service?
2. Which streaming service has the highest average critic and audience rating for each movie?
3. Which service has the highest average number of ratings per movie?
4. How many ratings does each movie have for each streaming service?


### Technical Details

#### Output File Type: 
An HTML File that is knitted from a .rmd file containing the markdown and scripts.

#### Data to Analyze: 
uTelly API and Rotten Tomatoes API

#### Data Processing: 
Converting JSON into data.frames, merging uTelly data.frame and Rotten Tomatoes data.frame, making new data.frames based on various filters, reformatting any mismatched movie titles (to be used for data merge key)

#### New Libraries: N/A 

#### Statistics Questions to Answer: 
All of the above questions require extracting specific columns/rows and then applying algorithms and formulas to get single value answers. 

#### Foreseeable Challenges:
 
1. Obtaining the top one hundred movies on Rotten Tomatoes
2. Making a data.frame of a hundred API calls to uTelly and the resulting streaming service availability.
3. Obtaining the correct information from the APIs as JSON data
4. Reformatting mismatched movie title names
5. Merging data.frames from the different API’s provided.
6. Filtering data by number of reviews and ratings
7. Creating visual data that is organized and informative


