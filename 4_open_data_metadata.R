# Arpil 1, 2026

# This script looks at all of the data submitted to Open Data Portal and:
## makes a table with the number of observations for each county
## (useful as a check to make sure Open Data uploaded all data);
## extracts unique stations and coordinates

# As the data submitted increases this will take a long time to run

library(dplyr)
library(leaflet)
library(sensorstrings)
library(readr)

# Paths ------------------------------------------------------------

data_path <- "R:/data_branches/nb_water_quality/processed_data/assembled_data"

path_submission <- "R:/data_branches/nb_water_quality/open_data"

# Import county data ------------------------------------------------------

dat <- ss_import_data(input_path = data_path)

# # check if there are any longitudes missing the "-"
dat %>%
  filter(longitude > 0) %>%
  distinct(station)

# count the number of rows for each county (send to Open Data so they can check)
n_obs <- dat %>%
  group_by(region) %>%
  summarize(n_observations= n())

# distinct stations with lat/long to send to Open Data
stations <- dat %>%
  distinct(station, .keep_all = TRUE) %>%
  select(region, waterbody, station, latitude, longitude) %>%
  arrange(region, waterbody) %>%
  mutate(
    latitude = round(latitude, digits = 4),
    longitude = round(longitude, digits = 4)
  )

leaflet(data = stations) %>%
  addProviderTiles(providers$CartoDB.Positron) %>%  # basemap
  addCircleMarkers(~longitude, ~latitude, stroke = FALSE)

# EXPORT ------------------------------------------------------------------

date_today <- Sys.Date()
write_csv(
  stations, paste0(path_submission, "/", date_today, "_station_locations.csv")
)

write_csv(
  n_obs,
  file = paste0(path_submission, "/", date_today, "_number_rows.csv")
)
