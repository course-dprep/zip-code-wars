library(ggplot2)
library(dplyr)

# Load data
research_project_filtered <- read.csv("../gen/temp/research_project_filtered.csv")

# Stars vs review count
ggplot(research_project_filtered, aes(x = review_count, y = stars)) +
  geom_point(alpha = 0.2) +
  scale_x_log10() +
  labs(title = "Stars vs Review Count",
       x = "Review Count (log scale)", y = "Stars")

# Save plot output
ggsave("../gen/output/stars_vs_review_count.pdf", plot = p)
