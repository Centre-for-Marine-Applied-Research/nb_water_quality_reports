# This script generates county reports for all counties specified in << county >>

# SECTION 1: Read in document history and report files

# SECTION 2: Specify county(ies) for which to generate reports

# SECTION 2: Generate report(s)

# SECTION 1: SET UP ---------------------------------------------

library(dplyr)
library(here)
library(readxl)

doc_history <- read_excel(
  "R:/tracking_sheets/nb_water_quality_report_tracker.xlsx",
  sheet = "Tracking"
)

report <- here("2_nb_water_quality_report.Rmd")


# SECTION 1: SET UP ---------------------------------------------

region <- "South"

# SECTION 2: GENERATE REPORTS --------------------------------------------------------

sapply(region, function(x) {

  rmarkdown::render(
    input = report,
    output_file = paste0(x, "_Water_Quality_Report.docx"),
    params = list(region = x, doc.hist = filter(doc_history, Region == x)))

})




