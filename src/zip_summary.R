## Plotting Aggregated Ratings in zip code and category level
# make new data with average starts per zip code
zip_summary <- research_project_density %>%
  group_by(postal_code, industry_categorized, industry_zip_count) %>%
  summarise(avg_stars = mean(stars, na.rm = TRUE),
            .groups = "drop")