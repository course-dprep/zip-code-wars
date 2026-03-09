library(dplyr)

zip_binned <- zip_summary %>%
  filter(industry_zip_count >= 10) %>%   # optional but recommended
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
