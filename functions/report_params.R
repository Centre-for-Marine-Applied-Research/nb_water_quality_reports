# November 2, 2026
# March 25, 2024

# Parameters to source for Water Quality reports
# Moved to here to reduce length of report script


# all water quality variables ---------------------------------------------
# variables that could be included in the report

vars <- c(
  "dissolved_oxygen_percent_saturation",
  "ph_ph",
  "salinity_psu",
  "sensor_depth_measured_m",
  "temperature_degree_c"
)

# region map parameters ---------------------------------------------------
# xmin to ymax: extent of the region map (and the red box on the
# New Brunswick map). region is lower case.

region_params <- tibble::tribble(
  ~region, ~xmin,  ~xmax, ~ymin, ~ymax, ~point_size, ~text_size,
  "North", -66.22, -63.3, 45.9,  48.9,  2,           3.5,
  "South", -67.4,  -66.5, 44.9,  45.3,  3,           4
)

# y-limits ----------------------------------------------------------------
# moved from the report loop. Named lists passed to the ylims
# argument of ss_plot_variables(); replace the sensorstrings standard
# limits for the named variables only.

region_ylims <- list(
  North = list(ph_ph = c(7.4, 8.5), salinity_psu = c(20, 34)),
  South = list(ph_ph = c(7.75, 8.5), salinity_psu = c(20, 34))
)

# stations where the region limits are replaced
station_ylims <- list(
  "Burnt Church Point" = list(salinity_psu = c(16, 34))
)
