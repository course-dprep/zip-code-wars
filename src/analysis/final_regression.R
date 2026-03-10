library(ggplot2)
library(dplyr)

# Load data
research_project_regression <- read.csv("../gen/temp/research_project_regression.csv")

# Interaction between density and industry
p <- ggplot(research_project_regression, aes(x = log_density, y = stars,
                                             color = industry_categorized)) +
  geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Interaction Between Density and Industry",
       x = "Log Same-Industry Density", y = "Yelp Stars")

# Save plot output
ggsave("../gen/output/final_regression.pdf", plot = p)
