library(dplyr)
library(purrr)
library(sensorstrings)

region <- "south"

path <- file.path("R:/data_branches/nb_water_quality/processed_data")

dat <- ss_assemble_region_data(prov = "nb", folder = region) 
  
unique(dat$waterbody)
unique(dat$station)
unique(dat$lease)

# open data portal -------------------------------------------

dat %>%
  select(-c(county, region)) %>%
  ss_export_county_files(
    county = region, 
    output_path = "R:/data_branches/nb_water_quality/open_data/",
    export_rds = FALSE
  )

# cmar county data --------------------------------------------

# remove columns that are all NA
dat %>%
  select_if(~ !all(is.na(.))) %>%
  ss_export_county_files(
    county = region, 
    output_path = "R:/data_branches/nb_water_quality/processed_data/assembled_data/",
    export_csv = FALSE
  )






