library(ggplot2)
library(dplyr)

# Load data
research_project_density <- read.csv("../gen/temp/research_project_density.csv")

# Plotting to see if ratings are affected by business density per industry
p <- ggplot(
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

# Save plot output
ggsave("../gen/output/business_density_effect_on_ratings_per_industry.pdf", plot = p)
