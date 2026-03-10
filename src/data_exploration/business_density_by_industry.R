library(dplyr)

# Load data
research_project_filtered <- read.csv("../gen/temp/research_project_filtered.csv")

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

# Save output for next scripts
write.csv(zip_industry_density, "../gen/temp/zip_industry_density.csv", row.names = FALSE)
write.csv(research_project_density, "../gen/temp/research_project_density.csv", row.names = FALSE)
