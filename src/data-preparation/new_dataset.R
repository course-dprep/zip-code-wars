library(dplyr)
library(ggplot2)
library(data.table)
library(knitr)
library(rmarkdown)
library(tidyverse)

# Load data
yelp_business <- read.csv("../data/yelp_business.csv")

# Extract columns needed for analysis
columns <- c("business_id", "state", "postal_code", "city", "review_count", "name", "categories", "stars")
research_project <- yelp_business %>% select(all_of(columns))

# Save so clean_data.R can access it
write.csv(research_project, "../gen/temp/research_project.csv", row.names = FALSE)
