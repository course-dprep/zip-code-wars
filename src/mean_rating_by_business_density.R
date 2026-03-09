library(ggplot2)

ggplot(zip_binned, aes(x = density_bin, y = mean_rating, size = n_zips)) +
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
    panel.grid.minor = element_blank())