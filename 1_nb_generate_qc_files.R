library(here)
library(quarto)

path <- file.path("R:/data_branches/nb_water_quality/processed_data/deployment_data")

region <- "south"

depls <- list.files(
  paste(path, region, sep = "/"),
 # paste(path, region, "new", sep = "/"),
  pattern = ".rds",
  full.names = TRUE
)
depls <- depls[1]

# export html file for each county showing the flagged observations
sapply(depls, function(x) {

  quarto_render(
    input = here("1_nb_apply_qc_tests.qmd"),
    output_file = paste0(
      sub(".rds", "", sub(".*/", "", x, perl = TRUE)),
      ".html"
    ),
    execute_params = list(region_param = region, depl_file = x))

})



x <- depls[2]
depl_file <- x
quarto_render(
  input = here("1_apply_qc_tests.qmd"),
  output_file = paste0(
    sub(".rds", "", sub(".*/", "", x, perl = TRUE)),
    ".html"
  ),
  execute_params = list(county = county, depl_file = x))



