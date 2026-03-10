library(dplyr)

# Load data
research_project_regression <- read.csv("../gen/temp/research_project_regression.csv")

# Base regression
base_regression <- lm(stars ~ log_density, data = research_project_regression)

# Save output
sink("../gen/output/base_regression.txt")
summary(base_regression)
sink()
