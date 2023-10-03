#' Plot geo-data
#' 
#' This function can be used plot geo-data
#'
#' @param sf_data 
#' 
#' @return The function returns a geo-plot
#' 
#' @import sf, ggplot2
#' 
#' @export
#' 
#' @examples
#' library(Lab5)
#' request_API("v1","world-2","geo","2016-01-01","fi")
#' 
#' @seealso \url{https://www.thenmap.net/}

# install.packages(c("sf", "ggplot2", "httr", "rjson"))

# library(sf)
# library(ggplot2)

plot_sf_data <- function(sf_data){
  stopifnot(class(sf_data)[1] == "sf")
  
  # plot the spatial data
  ggplot() +
    geom_sf(data = sf_data) +
    ggtitle("Map Plot") +
    theme_minimal()
}
