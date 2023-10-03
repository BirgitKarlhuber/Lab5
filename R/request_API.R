#' Title
#' 
#' Description
#'
#' @param xx description
#' 
#' @return description
#' 
#' @export
#' 
#' @examples
#' library(Lab5)
#' request_API(x)

request_API <- function(){
  
  
  
}

# install.packages(c("httr", "jsonlite"))

library(httr)
library(jsonlite)

res <- GET("http://api.thenmap.net/v2/fi-8/geo/2016-01-01?geo_props=name&language=fi")
res

rawToChar(res$content)

data <- fromJSON(rawToChar(res$content))
names(data)

data$features


ncol(data$features)

plot(data$features$geometry[2])


install.packages("broom")

library(broom)
spdf_fortified <- tidy(data$features)

# Plot it
library(ggplot2)
ggplot() +
  geom_polygon(data = spdf_fortified, aes( x = long, y = lat, group = group), fill="#69b3a2", color="white") +
  theme_void() +
  coord_map()

# xxxx



  
library(httr)
library(jsonlite)

res <- GET("https://spraakbanken.gu.se/resurser/corpus")
res

rawToChar(res$content)

data <- fromJSON(rawToChar(res$content))
names(data)

