# March 25, 2024

# functions for Water Quality Reports
# moved to here to decrease length of report script


# apply salinity correction factor to DO data -----------------------------

correct_do_data <- function(dat, sal = 30.6) {

  dat_other <- dat %>%
    filter(is.na(dissolved_oxygen_uncorrected_mg_per_l))

  dat_do <- dat %>%
    filter(!is.na(dissolved_oxygen_uncorrected_mg_per_l))

  if("salinity_psu" %in% colnames(dat_do)) {

    if(is.na(unique((dat_do$salinity_psu)))) {
      dat_do <- dat_do %>% select(-salinity_psu)
    } else message("use salinity column in dat for Fs")
  }

  dat_do %>%
    do_salinity_correction(sal = sal) %>%
    mutate(
      dissolved_oxygen_mg_per_l = dissolved_oxygen_uncorrected_mg_per_l * F_s
    ) %>%
    select(-c(dissolved_oxygen_uncorrected_mg_per_l, salinity_psu, F_s)) %>%
    bind_rows(dat_other)
}



# filter Tickle Island 1 --------------------------------------------------
# filter out all DO values flagged 3 at 5 m
# filter out DO values flagged 3 for rolling sd at 60 m
# keep DO values flagged 3 for climatology at 60 m
# filter out measured sensor depth rolling sd at 5 m

filter_tickle_island_1 <- function(dat) {
  dat %>%
    qc_pivot_longer(qc_tests = c("qc", "rolling_sd")) %>%
    filter(
      !(variable == "sensor_depth_measured_m" &
          sensor_depth_at_low_tide_m == 5 &
          rolling_sd_flag_value == 3),

      !(variable == "dissolved_oxygen_percent_saturation" &
          sensor_depth_at_low_tide_m == 5 &
          qc_flag_value == 3),

      !(variable == "dissolved_oxygen_percent_saturation" &
          sensor_depth_at_low_tide_m == 60 &
          rolling_sd_flag_value == 3)
    ) %>%
    qc_pivot_wider()
}


# figure height -----------------------------------------------------------
# calculate the height of figure based on the number of measured variables

calc_fig_height <- function(dat, h1) {

  n_vars <- dat %>%
    ss_pivot_longer() %>%
    distinct(variable) %>%
    nrow()

  if(n_vars == 1) h = h1
  if(n_vars == 2) h = 2 * h1
  if(n_vars == 3) h = 3 * h1
  if(n_vars == 4) h = 4 * h1
  if(n_vars > 4) h = 5 * h1

  h
}


# figure caption ----------------------------------------------------------

glue_do_fig_caption <- function(fig_cap, station) {

  if(station == "Tickle Island 1") {
    fig_cap <- glue("{fig_cap} Dissolved oxygen observations recorded at 60 m that were flagged \"Suspect/Of Interest\" were considered \"Of Interest\" for this deployment and included in the figure. Measured depth observations were considered \"Suspect\" and are not included.")
  }  else{
    fig_cap <- glue("{fig_cap} Dissolved oxygen observations flagged \"Suspect/Of Interest\" were considered \"Of Interest\" for this deployment and included in the figure.")
  }

  fig_cap
}


# figure caption ----------------------------------------------------------

glue_sal_fig_caption <- function(fig_cap) {

  glue("{fig_cap} Salinity observations flagged \"Suspect/Of Interest\" were considered \"Of Interest\" for this deployment and included in the figure.")
}


