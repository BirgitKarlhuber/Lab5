#' Fetch data from Thenmaps
#' 
#' This function can be used to fetch data from the Thenmaps-API. 
#'
#' @param version There are two version of the data available "v1" and "v2". 
#' 
#' @param dataset The dataset is a area-level. For the area, the ISO 3166 codes where available was used, and for level, the ten levels of administrative borders from Open Streetmap was used. 
#' 
#' @param modules There are 4 different modules available: data, info, geo, svg
#' 
#' @param date Can be on the form YYYY-MM-DD, YYYY-MM, or YYYY. The output will include only areas that existed at that very date. Dates in the database are local time and inclusive, meaning that 1947-03-01 will include a nation that gained independence on April 1 1947, according to the local timezone. 2011-05 will be interpreted as 2001-05-01, and 2011 will be interpreted as 2001-01-01. 
#' 
#' @param language Some parts of the data are available in different languages, such as names of political entities. 
#' 
#' @return The function returns the requested data.
#' 
#' @import sf, ggplot2, httr, rjson
#' 
#' @export
#' 
#' @examples
#' library(Lab5)
#' request_API("v1","world-2","geo","2016-01-01","fi")
#' 
#' @seealso \url{https://www.thenmap.net/}

# install.packages(c("sf", "ggplot2", "httr", "rjson"))

library(sf)
library(ggplot2)
library(httr)
library(rjson)

request_API <- function(version,dataset,modules,date,language) {
  # stopifnot()
  
  api_url <- paste0(paste0("http://api.thenmap.net/", version, "/", dataset, "/", modules, "/", date, 
                           "?gep_props=name&language=", language))
  
  response <- GET(api_url)
  
  # check if the request was successful (status code 200)
  if (status_code(response) == 200) {
    
    if(modules == "data"){
      
      myData <- fromJSON(file="http://api.thenmap.net/v2/se-7/data/1974?data_props=area|name&language=se")
      data_frame_json <- as.data.frame(myData)
      # str(data_frame_json) # still needs to be formated a little bit
      
      return(data_frame_json)
      
    } else if(modules == "geo") {
      geojson_content <- content(response, "text")
      sf_object <- st_read(geojson_content)
      return(sf_object)
    }
  } else {
    stop("Error fetching data with status code: ", status_code(response))
  }
}

version <- "v1" # v1, v2
dataset <- "world-2" # ch-8 no-7 no-4 dk-7 se-7 se-4 us-4 gl-7 world-2
modules <- "data" # data (info) geo (svg)
date <- "2016-01-01" # YYYY-MM-DD, YYYY-MM, or YYYY
language <- "fi"

requested_data <- request_API(version,dataset,modules,date,language)



###########################################

# plot the spatial data
ggplot() +
  geom_sf(data = requested_data) +
  ggtitle("Historical Map Plot") +
  theme_minimal()


# for svg - give a picture
svg_data <- GET("http://api.thenmap.net/v2/world-2/svg/2015")

