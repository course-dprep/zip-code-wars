library(dplyr)

# Load data
research_project_density <- read.csv("../gen/temp/research_project_density.csv")

research_project_regression <- research_project_density %>%
  mutate(log_density = log1p(industry_zip_count))

# Save output for next scripts
write.csv(research_project_regression, "../gen/temp/research_project_regression.csv", row.names = FALSE)
