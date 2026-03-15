# =============================================================================
# STEP 7: PREPARE REGRESSION AND CHECKIN DATA
# INPUT:
#   ../../gen/temp/research_project_density.csv
# OUTPUT:
#   ../../gen/temp/research_project_regression.csv
#   ../../data/yelp_checkin.csv
#   ../../gen/temp/yelp_checkin_clean.csv
#   ../../gen/temp/business_checkin_count.csv
#   ../../gen/temp/merged_research_project.csv
# =============================================================================

options(repos = c(CRAN = "https://cloud.r-project.org"))

library(dplyr)
library(tidyr)
library(lubridate)

if (!requireNamespace("googledrive", quietly = TRUE)) {
  install.packages("googledrive")
}
library(googledrive)

# Load data
research_project_density <- read.csv("../../gen/temp/research_project_density.csv")


# Part 1: Prepare regression dataset

research_project_regression <- research_project_density %>%
  mutate(log_density = log1p(industry_zip_count))

write.csv(
  research_project_regression,
  "../../gen/temp/research_project_regression.csv",
  row.names = FALSE
)

# Part 2: Download and prepare checkin dataset

# Download checkin dataset from Google Drive only if not already present
if (!file.exists("../../data/yelp_checkin.csv")) {
  drive_deauth()
  drive_download(
    as_id("1TqZIvA5GuiRD5x3w4LFh5E3A-g-5TeXG"),
    path = "../../data/yelp_checkin.csv",
    overwrite = TRUE
  )
}

yelp_checkin <- read.csv("../../data/yelp_checkin.csv", stringsAsFactors = FALSE)

# Definition of check-in: way to keep track of local businesses visited
# Rationale: control for customer traffic which may influence ratings independently of density

yelp_checkin_clean <- yelp_checkin %>%
  separate_rows(date, sep = ",\\s*") %>%
  mutate(
    good_date = as.Date(lubridate::ymd_hms(date)),
    year = lubridate::year(good_date),
    week = lubridate::isoweek(good_date)
  )

# Count checkin frequency for each business_id
business_checkin_count <- yelp_checkin_clean %>%
  group_by(business_id) %>%
  summarize(checkin_count = n(), .groups = "drop")

write.csv(
  yelp_checkin_clean,
  "../../gen/temp/yelp_checkin_clean.csv",
  row.names = FALSE
)

write.csv(
  business_checkin_count,
  "../../gen/temp/business_checkin_count.csv",
  row.names = FALSE
)

# Merge datasets
merged_research_project <- research_project_density %>%
  left_join(business_checkin_count, by = "business_id")

# Save final output for next scripts
write.csv(
  merged_research_project,
  "../../gen/temp/merged_research_project.csv",
  row.names = FALSE
)
