library(ggplot2)
library(dplyr)

# Load data
research_project_filtered <- read.csv("../gen/temp/research_project_filtered.csv")

# Distribution of star ratings
p <- ggplot(research_project_filtered, aes(x = stars)) +
  geom_histogram(binwidth = 0.25) +
  labs(title = "Distribution of Yelp Star Ratings",
       x = "Stars", y = "Count")

# Save plot output
ggsave("../gen/output/stars_vs_review_count.pdf", plot = p)


