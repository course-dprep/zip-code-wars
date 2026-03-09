zip_industry_density <- research_project_filtered %>%
  group_by(postal_code, industry_categorized) %>%
  summarise(
    industry_zip_count = n(),
    .groups = "drop"
  )

research_project_density <- research_project_filtered %>%
  left_join(
    zip_industry_density,
    by = c("postal_code", "industry_categorized")
  )
