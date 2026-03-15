# =============================================================================
# STEP 6: FINAL ZIP LEVEL DENSITY VISUALISATIONS
# INPUT:
#   ../../gen/temp/zip_summary.csv
#   ../../gen/temp/zip_binned.csv
# OUTPUT:
#   ../../gen/output/avg_rating_vs_industry_business_density.png
#   ../../gen/output/mean_rating_by_business_density.png
#   ../../gen/output/mean_rating_by_business_density_trend.png
# =============================================================================


library(ggplot2)
library(dplyr)

zip_summary <- read.csv("../../gen/temp/zip_summary.csv")

# Smoothed plotting
p <- ggplot(
  zip_summary,
  aes(x = industry_zip_count, y = avg_stars)
) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "loess", se = TRUE) +
  scale_x_log10() +
  facet_wrap(~ industry_categorized) +
  labs(
    title = "Average Yelp Rating vs Same-Industry Business Density",
    x = "Same-Industry Businesses per ZIP (log scale)",
    y = "Average Yelp Star Rating"
  ) +
  theme_minimal()

ggsave("../../gen/output/avg_rating_vs_industry_business_density.png", plot = p)

zip_binned <- read.csv("../../gen/temp/zip_binned.csv")

# Mean rating by density bin
p1 <- ggplot(zip_binned, aes(x = density_bin, y = mean_rating, size = n_zips)) +
  geom_point(color = "firebrick") +
  facet_wrap(~ industry_categorized) +
  labs(
    title = "Mean Yelp Rating by Business Density Bin (ZIP level)",
    x = "Same-Industry Businesses per ZIP",
    y = "Mean Yelp Rating",
    size = "Number of ZIP Codes"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.minor = element_blank()
  )

ggsave("../../gen/output/mean_rating_by_business_density.png", plot = p1)

# Density bin trend (line + point version)
p2 <- ggplot(
  zip_binned,
  aes(x = density_bin, y = mean_rating, group = industry_categorized)
) +
  geom_line(color = "firebrick") +
  geom_point(color = "firebrick", size = 3) +
  facet_wrap(~ industry_categorized) +
  labs(
    title = "Mean Yelp Rating by Business Density Bin (ZIP level)",
    x = "Same-Industry Businesses per ZIP (Density Bin)",
    y = "Mean Yelp Rating"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.minor = element_blank()
  )

ggsave("../../gen/output/mean_rating_by_business_density.png", plot = p2)
