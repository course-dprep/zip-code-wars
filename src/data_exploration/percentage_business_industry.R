library(ggplot2)
library(dplyr)

# Load data
research_project_density <- read.csv("../gen/temp/research_project_density.csv")

# Percentage of businesses by industry
p <- ggplot(research_project_density, aes(industry_categorized)) + 
  geom_bar(aes(y = after_stat(count)/sum(after_stat(count))*100)) + 
  ylab("Percentage of Businesses") + xlab("Industry Distribution")

# Save plot output
ggsave("../gen/output/percentage_business_industry.pdf", plot = p)
