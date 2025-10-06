

import_map_params <- function(region, crs = 4326){
  
  if(region == "north"){
    dummy_points <- data.frame(
      longitude = c(-66.22, -63.3), latitude = c(45.9, 48.9)
    ) %>%
      st_as_sf(coords = c("longitude", "latitude"), crs = crs, remove = FALSE)
  }
  
  if(region == "south"){
    dummy_points <- data.frame(
      longitude = c(-67.4, -66.5), latitude = c(44.9, 45.3)
    ) %>%
      st_as_sf(coords = c("longitude", "latitude"), crs = 4326, remove = FALSE)
  }
  
  dummy_points
  
}



