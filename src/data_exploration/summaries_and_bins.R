# =============================================================================
# STEP 5: INDUSTRY DENSITY ANALYSIS AND AGGREGATED ZIP SUMMARIES
# INPUT: ../../gen/temp/research_project_density.csv
# OUTPUT:
#   ../../gen/output/percentage_business_industry.png
#   ../../gen/output/same_industry_density_vs_ratings.png
#   ../../gen/temp/zip_summary.csv
#   ../../gen/temp/zip_binned.csv
# =============================================================================

library(ggplot2)
library(dplyr)

# Load data
research_project_density <- read.csv("../../gen/temp/research_project_density.csv")

# 1. Percentage of businesses by industry
p <- ggplot(research_project_density, aes(industry_categorized)) +
  geom_bar(aes(y = after_stat(count) / sum(after_stat(count)) * 100)) +
  ylab("Percentage of Businesses") +
  xlab("Industry Distribution")

ggsave("../../gen/output/percentage_business_industry.png", plot = p)

# 2. Plotting to see if ratings are affected by business density per industry
p1 <- ggplot(
  research_project_density,
  aes(x = industry_zip_count, y = stars)
) +
  geom_jitter(alpha = 0.15, width = 0) +
  scale_x_log10() +
  facet_wrap(~ industry_categorized) +
  labs(
    title = "Same-Industry Business Density vs Yelp Ratings",
    x = "Same-Industry Businesses per ZIP (log scale)",
    y = "Yelp Star Rating"
  )

ggsave("../../gen/output/same_industry_density_vs_ratings.png", plot = p1)


# 3. Aggregated ratings at ZIP code and category level
zip_summary <- research_project_density %>%
  group_by(postal_code, industry_categorized, industry_zip_count) %>%
  summarise(
    avg_stars = mean(stars, na.rm = TRUE),
    .groups = "drop"
  )

write.csv(zip_summary, "../../gen/temp/zip_summary.csv", row.names = FALSE)

# 3. Density bins
zip_binned <- zip_summary %>%
  filter(industry_zip_count >= 10) %>%
  mutate(
    density_bin = cut(
      industry_zip_count,
      breaks = c(10, 20, 50, 100, 200, Inf),
      include.lowest = TRUE,
      right = FALSE
    )
  ) %>%
  group_by(industry_categorized, density_bin) %>%
  summarise(
    mean_rating = mean(avg_stars, na.rm = TRUE),
    n_zips = n(),
    .groups = "drop"
  )

write.csv(zip_binned, "../../gen/temp/zip_binned.csv", row.names = FALSE)

