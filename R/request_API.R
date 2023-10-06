#' Fetch data from Thenmaps
#' 
#' This function can be used to fetch data from the Thenmaps-API. 
#'
#' @param dataset The dataset is a area-level. For the area, the ISO 3166 codes where available was used, and for level, the ten levels of administrative borders from Open Streetmap was used. 
#' 
#' @param date Can be on the form YYYY-MM-DD, YYYY-MM, or YYYY. The output will include only areas that existed at that very date. Dates in the database are local time and inclusive, meaning that 1947-03-01 will include a nation that gained independence on April 1 1947, according to the local timezone. 2011-05 will be interpreted as 2001-05-01, and 2011 will be interpreted as 2001-01-01. 
#' 
#' @return The function returns the requested dataset.
#' 
#' @import sf, httr, rjson
#' 
#' @export
#' 
#' @examples
#' library(Lab5)
#' requested_data <- request_API("world-2", "2016-01-01")
#' 
#' @seealso \url{https://www.thenmap.net/}


# library(sf)
# library(httr)
# library(rjson)

request_API <- function(dataset,date) {
  
  stopifnot(dataset %in% c("ch-8", "no-7", "no-4", "dk-7", "se-7", "se-4", "us-4", "gl-7", "world-2"))
  
  api_url <- paste0(paste0("http://api.thenmap.net/v1/", dataset, "/geo/", date, 
                           "?gep_props=name&language=en"))
  
  response <- GET(api_url)
  
  # check if the request was successful (status code 200)
  if (status_code(response) == 200) {
    
    geojson_content <- content(response, "text")
    sf_object <- st_read(geojson_content)
    return(sf_object)
    
  } else {
    stop("Error fetching data with status code: ", status_code(response))
  }
}

# dataset <- "world-2" # ch-8 no-7 no-4 dk-7 se-7 se-4 us-4 gl-7 world-2
# date <- "2016-01-01" # YYYY-MM-DD, YYYY-MM, or YYYY
# 
# requested_data <- request_API(dataset,date)
# 
# library(ggplot2)
# 
# ggplot() +
#   geom_sf(data = requested_data) +
#   ggtitle("Map") +
#   theme_minimal()
