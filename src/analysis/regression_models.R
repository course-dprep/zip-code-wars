# =============================================================================
# STEP 8: REGRESSION MODEL ESTIMATION
# INPUT:
#   ../../gen/temp/research_project_regression.csv
# OUTPUT:
#   ../../gen/output/base_regression.txt
#   ../../gen/temp/regression_with_categories.rds
#   ../../gen/temp/regression_with_interaction.rds
#   ../../gen/output/regression_with_categories_summary.txt
# =============================================================================

library(dplyr)

# Load data
research_project_regression <- read.csv("../../gen/temp/research_project_regression.csv")


# 1. Base regression

base_regression <- lm(stars ~ log_density, data = research_project_regression)

sink("../../gen/output/base_regression.txt")
summary(base_regression)
sink()


# 2. Regression with categories

regression_with_categories <- lm(
  stars ~ log_density + industry_categorized,
  data = research_project_regression
)

saveRDS(
  regression_with_categories,
  "../../gen/temp/regression_with_categories.rds"
)


# 3. Regression with interaction term

regression_with_interaction <- lm(
  stars ~ log_density * industry_categorized,
  data = research_project_regression
)

# Calculating slopes for different business categories:
# Health & Beauty = 0.0701 + 0.0618 = 0.1319
# Food & Drink = 0.0701 - 0.0224 = 0.0477
# Other = 0.0701 - 0.0058 = 0.0643
# Veterinarians & Pet Shops = 0.0701 + 0.0375 = 0.1076

saveRDS(
  regression_with_interaction,
  "../../gen/temp/regression_with_interaction.rds"
)

sink("../../gen/output/regression_with_categories_summary.txt")
cat("=== Regression with Categories ===\n")
print(summary(regression_with_categories))
cat("\n=== Regression with Interaction ===\n")
print(summary(regression_with_interaction))
cat("\n=== R-squared (Interaction model) ===\n")
print(summary(regression_with_interaction)$r.squared)
cat("\n=== ANOVA Comparison ===\n")
print(anova(regression_with_categories, regression_with_interaction))
sink()
