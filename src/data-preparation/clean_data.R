library(dplyr)
library(ggplot2)
library(data.table)
library(knitr)
library(rmarkdown)
library(tidyverse)

research_project <- read.csv("../gen/temp/research_project.csv")
research_project_filtered <- research_project %>% filter(postal_code != "")

# Save filtered dataset
write.csv(research_project_filtered, "../gen/temp/research_project_filtered.csv", row.names = FALSE)
