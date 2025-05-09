# This script generates county reports for all counties specified in << county >>

# SECTION 1: Read in document history and report files

# SECTION 2: Specify county(ies) for which to generate reports

# SECTION 2: Generate report(s)

# SECTION 1: SET UP ---------------------------------------------

library(dplyr)
library(here)
library(readxl)

# SECTION 1: SET UP ---------------------------------------------

region <- "South"

hist <- read_excel(
  "R:/tracking_sheets/nb_water_quality_report_tracker.xlsx",
  sheet = "Tracking"
) %>% 
  filter(Region == region)

# SECTION 2: GENERATE REPORTS --------------------------------------------------------

report <- here("3_nb_water_quality_report.qmd")

quarto::quarto_render(
  input = report,
  output_file = paste0(region, "_Water_Quality_Report.pdf"),
  execute_params = list(
    region = region, 
    doc_version = hist$Version, 
    doc_date = as.character(hist$Date), 
    doc_notes = hist$Amendments
  )
)





