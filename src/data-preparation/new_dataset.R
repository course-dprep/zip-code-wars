#Extract columns needed for analysis (create a new dataset)
library(tidyverse)
columns = c("state","postal_code","city","review_count","name","categories","stars")
research_project <- yelp_business %>% select(all_of(columns))