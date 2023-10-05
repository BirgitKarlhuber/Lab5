#' Plot geo-data
#' 
#' This function can be used plot geo-data
#'
#' @param sf_data geo-dataset in sf format
#' 
#' @return The function returns a geo-plot
#' 
#' @import sf, ggplot2
#' 
#' @export
#' 
#' @examples
#' library(Lab5)
#' requested_data <- request_API("v1","world-2","geo","2016-01-01","fi")
#' plot_sf_data(requested_data)
#' 
#' @seealso \url{https://www.thenmap.net/}


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
