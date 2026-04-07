# March 25, 2024

# Parameters to source for Water Quality reports
# Moved to here to reduce length of report script


# all water quality variables ---------------------------------------------
# variables that could be included in the report

vars <- c(
  "dissolved_oxygen_percent_saturation",
  "dissolved_oxygen_uncorrected_mg_per_l",
  "ph_ph",
  "salinity_psu",
  "sensor_depth_measured_m",
  "temperature_degree_c"
)


# station coordinates -----------------------------------------------------

# coords_ddm <- c("deployment_latitude_n_ddm", "deployment_longitude_w_ddm",
#                 "retrieval_latitude_n_ddm", "retrieval_longitude_w_ddm")
# 
# gs4_deauth()
# link <- "https://docs.google.com/spreadsheets/d/1KDM8a-PkP30NNJNQMbK3SPt0tAAr3R2MeqHgIBYSVg8/edit?gid=149994636#gid=149994636"
# 
# stations <- read_sheet(link, sheet = "tracker") %>%
#   filter(station != "00_Example") %>%
#   distinct(waterbody, station, .keep_all = TRUE) %>%
#   mutate(across(any_of(coords_ddm),
#                 ~ss_coords_from_ddm_to_dd(.x),
#                 .names = "{str_remove(.col, '_w_ddm|_n_ddm')}"
#   )) %>%
#   mutate(
#     deployment_latitude = if_else(
#       is.na(deployment_latitude), deployment_latitude_dd, deployment_latitude),
#     deployment_longitude = -deployment_longitude,
#     deployment_longitude = if_else(
#       is.na(deployment_longitude), deployment_longitude_dd, deployment_longitude)
#   ) %>%
#   select(waterbody, station, deployment_latitude, deployment_longitude) %>% 
#   st_as_sf( 
#     coords = c("deployment_longitude", "deployment_latitude"), 
#     remove = FALSE,
#     crs = 4326, agr = "constant"
#   )