library(dplyr)
#library(purrr)
library(sensorstrings)
library(qaqcmar)

region <- "south"

dat <- qc_assemble_county_data(prov = "nb", folder = region)

# drop columns that are all NA
dat <- dat %>%
  select_if(~ !all(is.na(.)))

unique(dat$waterbody)
unique(dat$station)
unique(dat$lease)

# open data portal -------------------------------------------
dat %>%
  select(-region) %>%
  ss_export_county_files(
    county = region, 
    output_path = "R:/data_branches/nb_water_quality/open_data/",
    export_rds = FALSE
  )

# cmar county data --------------------------------------------

# remove columns that are all NA
dat %>%
  ss_export_county_files(
    county = region, 
    output_path = "R:/data_branches/nb_water_quality/processed_data/assembled_data/",
    export_csv = FALSE
  )






