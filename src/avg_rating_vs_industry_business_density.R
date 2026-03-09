## Smoothed Plotting: 
ggplot(
  zip_summary,
  aes(x = industry_zip_count, y = avg_stars)
) +
  geom_point(alpha = 0.5) +
  geom_smooth(method = "loess", se = TRUE) +
  scale_x_log10() +
  facet_wrap(~ industry_categorized) +
  labs(
    title = "Average Yelp Rating vs Same-Industry Business Density (Ascending order)",
    x = "Same-Industry Businesses per ZIP (log scale)",
    y = "Average Yelp Star Rating"
  ) +
  theme_minimal()