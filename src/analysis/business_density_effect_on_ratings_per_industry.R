## Plotting to see if ratings are affected by business density per industry
ggplot(
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
