library(dplyr)
library(broom)

# Load data
merged_research_project <- read.csv("../gen/temp/merged_research_project.csv")

# Regression for each business category
results_by_industry <- merged_research_project %>%
  group_by(industry_categorized) %>%
  group_modify(~ tidy(
    lm(
      stars ~ industry_zip_count * checkin_count,
      data = .x
    )
  ))

# Save output
sink("../gen/output/results_by_industry.txt")
print(results_by_industry)
sink()
