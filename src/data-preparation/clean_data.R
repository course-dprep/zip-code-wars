# =============================================================================
# STEP 2 — Inspect postal codes and extract only the columns needed
# INPUT:   ../../data/yelp_business.csv
# OUTPUT:  ../../gen/temp/research_project_filtered.csv
# =============================================================================

library(dplyr)
library(ggplot2)
library(data.table)
library(knitr)
library(rmarkdown)
library(tidyverse)

# Input
yelp_business <- read.csv("../../data/yelp_business.csv")

# Inspect postal code column — confirming it is already stored as character
summary(yelp_business$postal_code)

# Select only the columns relevant to the analysis
# business_id is kept so this dataset can be joined with checkin data later
columns <- c("business_id", "state", "postal_code", "city",
             "review_count", "name", "categories", "stars")

research_project <- yelp_business %>% select(all_of(columns))

# Remove rows with missing postal codes

research_project_filtered <- research_project %>% filter(postal_code != "")

# Save filtered dataset
write.csv(research_project_filtered, "../../gen/temp/research_project_filtered.csv", row.names = FALSE)





