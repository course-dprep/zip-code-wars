library(dplyr)

# Load data
research_project_regression <- read.csv("../gen/temp/research_project_regression.csv")

# Regression with categories
regression_with_categories <- lm(stars ~ log_density + industry_categorized, 
                                 data = research_project_regression)

# Regression with interaction term
regression_with_interaction <- lm(stars ~ log_density * industry_categorized, 
                                  data = research_project_regression)

# Calculating slopes for different business categories:
# Health & Beauty = 0.0701 + 0.0618 = 0.1319 (p-value significant)
# Food & Drink = 0.0701 − 0.0224 = 0.0477 (p-value significant)
# Other = 0.0701 - 0.0058 = 0.0121 (p-value not significant)
# Veterinarians & Pet Shops = 0.0701 + 0.0375 = 0.1076 (p-value not significant)

# Save regression models as RDS for use in other scripts
saveRDS(regression_with_categories, "../gen/temp/regression_with_categories.rds")
saveRDS(regression_with_interaction, "../gen/temp/regression_with_interaction.rds")

# Save all outputs to txt
sink("../gen/output/regression_with_categories_summary.txt")
cat("=== Regression with Categories ===\n")
print(summary(regression_with_categories))
cat("\n=== Regression with Interaction ===\n")
print(summary(regression_with_interaction))
cat("\n=== R-squared (Interaction model) ===\n")
print(summary(regression_with_interaction)$r.squared)
cat("\n=== ANOVA Comparison ===\n")
print(anova(regression_with_categories, regression_with_interaction))
sink()
