# April 16, 2026

# Assemble region datasets

## For CMAR use:
### rds file exported to R:\data_branches\nb_water_quality\processed_data\assembled_data
### includes all flag columns

## For Open Data Portal:
### csv file exported to R:\data_branches\nb_water_quality\open_data
### only includes summary qc flags

library(data.table)
library(dplyr)
library(sensorstrings)
library(qaqcmar)

# SECTION 1: Update region ------------------------------------------------------

region <- "south"

# SECTION 2: Import and Check Data ----------------------------------------

dat_raw <- qc_assemble_county_data(prov = "nb", folder = region)

dat <- dat_raw %>%
  select(-contains("mg_per_l")) %>% 
  mutate(lease = if_else(lease == "n/a", NA, lease))

unique(dat$waterbody)
unique(dat$station)
unique(dat$lease)

# check for duplicate rows
dat_dups <- dat %>%
  data.table() %>%
  duplicated()
if(any(dat_dups == TRUE)) warning("duplicated rows detected in dat")

# SECTION 3: Open Data Portal -------------------------------------------

to_keep <- c(
  "waterbody", "station", "lease", "latitude", "longitude",                                               
  "deployment_range", "string_configuration", "sensor_type", 
  "sensor_serial_number", "timestamp_utc", "sensor_depth_at_low_tide_m",                              
  "depth_crosscheck_flag",
  "dissolved_oxygen_percent_saturation", "ph_ph", "salinity_psu", 
  "sensor_depth_measured_m", "temperature_degree_c"
)

# open data portal -------------------------------------------
dat %>%
  select(any_of(to_keep), contains("qc_flag")) %>%
  qc_assign_flag_labels() %>%
  ss_export_county_files(
    county = region, 
    output_path = "R:/data_branches/nb_water_quality/open_data/",
    export_rds = FALSE
  )

# cmar county data --------------------------------------------
# remove columns that are all NA
dat %>%
  select_if(~ !all(is.na(.))) %>% 
  select(
    region,
    any_of(to_keep), contains("grossrange"), contains("human"), contains("qc_"),
    contains("hil")
  ) %>%
  ss_export_county_files(
    county = region, 
    output_path = "R:/data_branches/nb_water_quality/processed_data/assembled_data/",
    export_csv = FALSE
  )







