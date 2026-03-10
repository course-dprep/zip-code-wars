library(dplyr)

# Load data
zip_summary <- read.csv("../gen/temp/zip_summary.csv")

zip_binned <- zip_summary %>%
  filter(industry_zip_count >= 10) %>%
  mutate(
    density_bin = cut(
      industry_zip_count,
      breaks = c(10, 20, 50, 100, 200, Inf),
      include.lowest = TRUE,
      right = FALSE
    )
  ) %>%
  group_by(industry_categorized, density_bin) %>%
  summarise(
    mean_rating = mean(avg_stars, na.rm = TRUE),
    n_zips      = n(),
    .groups = "drop"
  )

# Save output for next scripts
write.csv(zip_binned, "../gen/temp/zip_binned.csv", row.names = FALSE)

