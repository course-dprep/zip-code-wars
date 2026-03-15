# =============================================================================
# STEP 3: BASIC EXPLORATORY VISUALISATIONS
# INPUT: ../../gen/temp/research_project_filtered.csv
# OUTPUT:
#   ../../gen/output/distribution_star_ratings.png
#   ../../gen/output/stars_vs_review_count.png
#   ../../gen/output/stars_vs_business_density.png
# =============================================================================

library(ggplot2)
library(dplyr)

# Load data
research_project_filtered <- read.csv("../../gen/temp/research_project_filtered.csv")

# 1. Distribution of star ratings
p <- ggplot(research_project_filtered, aes(x = stars)) +
  geom_histogram(binwidth = 0.25) +
  labs(
    title = "Distribution of Yelp Star Ratings",
    x = "Stars",
    y = "Count"
  )

ggsave("../../gen/output/distribution_star_ratings.png", plot = p)

# 2. Stars vs review count
p2 <- ggplot(research_project_filtered, aes(x = review_count, y = stars)) +
  geom_point(alpha = 0.2) +
  scale_x_log10() +
  labs(
    title = "Stars vs Review Count",
    x = "Review Count (log scale)",
    y = "Stars"
  )

ggsave("../../gen/output/stars_vs_review_count.png", plot = p2)

# 3. Stars vs business density by ZIP
zip_density <- research_project_filtered %>%
  count(postal_code, name = "zip_business_count")

p3 <- research_project_filtered %>%
  left_join(zip_density, by = "postal_code") %>%
  ggplot(aes(x = zip_business_count, y = stars)) +
  geom_jitter(alpha = 0.2, width = 0) +
  scale_x_log10() +
  labs(
    title = "Business Density vs Yelp Ratings",
    x = "Businesses per ZIP (log)",
    y = "Stars"
  )

ggsave("../../gen/output/stars_vs_business_density.png", plot = p3)

