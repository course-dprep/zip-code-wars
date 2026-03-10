library(ggplot2)
library(dplyr)

# Load data
zip_binned <- read.csv("../gen/temp/zip_binned.csv")

# Mean Yelp rating by business density bin
p <- ggplot(zip_binned, aes(x = density_bin, y = mean_rating, size = n_zips)) +
  geom_point(color = "firebrick") +
  facet_wrap(~ industry_categorized) +
  labs(
    title = "Mean Yelp Rating by Business Density Bin (ZIP level)",
    x = "Same-Industry Businesses per ZIP",
    y = "Mean Yelp Rating",
    size = "Number of ZIP Codes"
  ) +
  theme_minimal(base_size = 13) +
  theme(
    axis.text.x = element_text(angle = 45, hjust = 1),
    panel.grid.minor = element_blank()
  )

# Save plot output
ggsave("../gen/output/mean_rating_by_business_density.pdf", plot = p)

