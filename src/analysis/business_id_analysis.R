# Rebuild a mergeable business-level dataset WITH business_id
research_project_plus <- yelp_business %>%
  select(business_id, state, postal_code, city, review_count, name, categories, stars) %>%
  filter(postal_code != "")

setDT(research_project_plus)

research_project_plus[, categories_text := tolower(as.character(categories))]
research_project_plus[, industry_categorized := "Other"]

research_project_plus[grepl("restaurants|food|coffee|tea|mexican|italian|burgers|pizza|ice cream|yogurt|chinese",
                            categories_text),
                      industry_categorized := "Food & Drink"]

research_project_plus[grepl("beauty|spa|hair|nail",
                            categories_text),
                      industry_categorized := "Health & Beauty"]

research_project_plus[grepl("veterinarians|pets",
                            categories_text),
                      industry_categorized := "Veterinarians & Pet Shops"]

research_project_plus[grepl("auto|automotive|repair",
                            categories_text),
                      industry_categorized := "Auto & Transport"]

research_project_plus[, industry_categorized := as.factor(industry_categorized)]

zip_industry_density_plus <- research_project_plus %>%
  group_by(postal_code, industry_categorized) %>%
  summarise(
    industry_zip_count = n(),
    .groups = "drop"
  )

research_project_density_plus <- research_project_plus %>%
  left_join(
    zip_industry_density_plus,
    by = c("postal_code", "industry_categorized")
  )
# Merge check-ins and review summary
research_project_regression_plus <- research_project_density_plus %>%
  left_join(business_checkin_count, by = "business_id") %>%
  left_join(review_business, by = "business_id") %>%
  mutate(
    checkin_count = replace_na(checkin_count, 0),
    n_reviews_actual = replace_na(n_reviews_actual, 0),
    avg_engagement = replace_na(avg_engagement, 0),
    log_density = log1p(industry_zip_count),
    log_checkin_count = log1p(checkin_count),
    log_n_reviews = log1p(n_reviews_actual),
    log_avg_engagement = log1p(avg_engagement)
  )

# Extended model with review-derived controls
regression_with_review_controls <- lm(
  stars ~ log_density * industry_categorized +
    log_checkin_count +
    log_n_reviews +
    sd_review_stars +
    log_avg_engagement,
  data = research_project_regression_plus
)

summary(regression_with_review_controls)
summary(regression_with_review_controls)$r.squared

# Refit the interaction-only model on the SAME dataset for valid comparison
regression_with_interaction_plus <- lm(
  stars ~ log_density * industry_categorized,
  data = research_project_regression_plus
)

anova(regression_with_interaction_plus, regression_with_review_controls)