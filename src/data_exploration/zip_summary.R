library(dplyr)

# Load data
research_project_density <- read.csv("../gen/temp/research_project_density.csv")

# Make new data with average stars per zip code
zip_summary <- research_project_density %>%
  group_by(postal_code, industry_categorized, industry_zip_count) %>%
  summarise(avg_stars = mean(stars, na.rm = TRUE),
            .groups = "drop")

# Save output for next scripts
write.csv(zip_summary, "../gen/temp/zip_summary.csv", row.names = FALSE)
