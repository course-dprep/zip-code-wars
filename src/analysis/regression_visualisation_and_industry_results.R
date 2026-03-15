# =============================================================================
# STEP 9: REGRESSION VISUALISATION AND INDUSTRY SPECIFIC RESULTS
# INPUT:
#   ../../gen/temp/research_project_regression.csv
#   ../../gen/temp/merged_research_project.csv
# OUTPUT:
#   ../../gen/output/final_regression.png
#   ../../gen/output/results_by_industry.txt
# =============================================================================

library(ggplot2)
library(dplyr)
library(broom)


# 1: Final regression visualisation


research_project_regression <- read.csv("../../gen/temp/research_project_regression.csv")

p <- ggplot(
  research_project_regression,
  aes(x = log_density, y = stars, color = industry_categorized)
) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(
    title = "Interaction Between Density and Industry",
    x = "Log Same-Industry Density",
    y = "Yelp Stars"
  )

ggsave("../../gen/output/final_regression.png", plot = p)


# Part 2: Regression for each business category with checkins

merged_research_project <- read.csv("../../gen/temp/merged_research_project.csv")

results_by_industry <- merged_research_project %>%
  group_by(industry_categorized) %>%
  group_modify(~ tidy(
    lm(
      stars ~ industry_zip_count * checkin_count,
      data = .x
    )
  ))

sink("../../gen/output/results_by_industry.txt")
print(results_by_industry)
sink()
