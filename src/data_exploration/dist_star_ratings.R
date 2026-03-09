library(ggplot2)
library(dplyr)

# Distribution of star ratings
ggplot(research_project_filtered, aes(x = stars)) +
  geom_histogram(binwidth = 0.25) +
  labs(title = "Distribution of Yelp Star Ratings",
       x = "Stars", y = "Count")
