regression_with_categories <- lm( stars ~ log_density + industry_categorized, data = research_project_regression)

summary(regression_with_categories)

#Regression model with business categories added as an interaction term:
regression_with_interaction <- lm(stars ~ log_density * industry_categorized,data = research_project_regression)

summary(regression_with_interaction)
summary(regression_with_interaction)$r.squared

#Calculating slopes for different business categories:
#Health & Beauty = 0.0701 + 0.0618 = 0.1319 (p-value significant)
#Food & Drink = 0.0701 − 0.0224 = 0.0477 (p-value significant)
#Other =  0.0701-0.0058 = 0.0121 (p-value not significant)
#Veterinarians & Pet Shops = 0.0701 + 0.0375 = 0.1076 (p-value not significant)

#Comparing results of two regression models with Anova to confirm best model fit:

anova(regression_with_categories, regression_with_interaction)
