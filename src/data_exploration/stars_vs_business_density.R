library(ggplot2)
library(dplyr)

# Load data
research_project_filtered <- read.csv("../gen/temp/research_project_filtered.csv")

# Stars vs business density by ZIP
zip_density <- research_project_filtered %>%
  count(postal_code, name = "zip_business_count")

p <- research_project_filtered %>%
  left_join(zip_density, by = "postal_code") %>%
  ggplot(aes(x = zip_business_count, y = stars)) +
  geom_jitter(alpha = 0.2, width = 0) +
  scale_x_log10() +
  labs(title = "Business Density vs Yelp Ratings",
       x = "Businesses per ZIP (log)", y = "Stars")

# Save plot output
ggsave("../gen/output/stars_vs_business_density.pdf", plot = p)
