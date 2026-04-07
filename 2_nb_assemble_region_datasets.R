library(dplyr)
library(sensorstrings)
library(qaqcmar)

region <- "north"

dat_raw <- qc_assemble_county_data(prov = "nb", folder = region)

# remove problem deployment (could be added later)
dat <- dat_raw %>% 
  filter(
    !(station == "Neguac" & deployment_range == "2025-Jun-09 to 2025-Aug-06")
  )

# drop columns that are all NA
dat <- dat %>%
  select_if(~ !all(is.na(.))) %>% 
  mutate(lease = if_else(lease == "n/a", NA, lease))

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






