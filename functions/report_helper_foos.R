# March 25, 2024

# functions for Water Quality Reports
# moved to here to decrease length of report script


# figure height -----------------------------------------------------------
# calculate the height of figure based on the number of measured variables

calc_fig_height <- function(dat, h1, var_cols, h_max = 10.9) {
  
  dat <- select(dat, where(~ !all(is.na(.x))))
  
  n_vars <- sum(colnames(dat) %in% var_cols)
  
  if (n_vars == 0) stop("No variables to plot.", call. = FALSE)
  min(n_vars * h1, h_max)
}


# region map extent -------------------------------------------------------

get_region_extent <- function(params, crs = 4326) {
  if (nrow(params) != 1) {
    stop("Expected one row of region_params, found ", nrow(params), call. = FALSE)
  }
  sf::st_bbox(
    unlist(params[, c("xmin", "ymin", "xmax", "ymax")]),
    crs = sf::st_crs(crs)
  )
}