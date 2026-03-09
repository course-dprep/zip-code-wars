research_project_regression <- research_project_density %>%
  mutate(log_density = log1p(industry_zip_count))
