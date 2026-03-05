library(tidyverse)
library(readr)
library(data.table)
setwd("C:/Users/duru2/Desktop/Data Prep. and Programming Skills/Group Project")
review <- read_csv('yelp_academic_dataset_review.csv')
setDT(review)
library(vroom)
review <- vroom("yelp_academic_dataset_review.csv")
#the codes above just crashed my computer

#I analyzed:Tip frequency per business, Compliments per business, Whether tips are related to ratings (if merged with business file)

library(data.table)
getwd()
setwd("C:/Users/duru2/Desktop/Data Prep. and Programming Skills/Group Project")
tips <- fread(
  "yelp_academic_dataset_tip.csv",
  select = c("business_id", "compliment_count")
)

#Aggregate Tips Per Business
tips_agg <- tips[, .(
  total_tips = .N,
  total_compliments = sum(compliment_count)
), by = business_id]

business <- fread(
  "yelp_academic_dataset_business.csv",
  select = c("business_id", "postal_code", "categories", "stars")
)

business <- business[
  !is.na(postal_code) & 
    !is.na(categories)
]

#Extract main industry
business[, industry := trimws(tstrsplit(categories, ",")[[1]])]
business[, categories := NULL]

#Calculate Density
business[, density := .N, by = .(postal_code, industry)]

#Merge Tips With Business Data
data <- merge(business, tips_agg, by = "business_id", all.x = TRUE)

data[is.na(total_tips), total_tips := 0]
data[is.na(total_compliments), total_compliments := 0]

#Aggregate to ZIP + Industry Level
zip_industry <- data[, .(
  avg_rating = mean(stars),
  avg_density = mean(density),
  avg_tips = mean(total_tips)
), by = .(postal_code, industry)]

model1 <- lm(avg_rating ~ avg_density, data = zip_industry)
summary(model1)
model2 <- lm(avg_rating ~ avg_density * industry, data = zip_industry)
summary(model2)

top_industries <- zip_industry[, .N, by = industry][order(-N)][1:5]$industry
zip_small <- zip_industry[industry %in% top_industries]

#Basic Scatter Plot (Main Relationship)
library(ggplot2)

ggplot(zip_industry, aes(x = avg_density, y = avg_rating)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = TRUE) +
  labs(
    title = "Density vs Average Yelp Rating",
    x = "Average Density of Same-Category Businesses",
    y = "Average Yelp Rating"
  ) +
  theme_minimal()

#Visualize Industry Differences. Show Only Top 5 Industries
#Answers: Does the relationship differ by industry?
library(dplyr)

top_industries <- zip_industry %>%
  count(industry, sort = TRUE) %>%
  slice(1:5) %>%
  pull(industry)

zip_small <- zip_industry %>%
  filter(industry %in% top_industries)

ggplot(zip_small, aes(x = avg_density, y = avg_rating)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = FALSE, color = "blue") +
  facet_wrap(~ industry) +
  labs(
    title = "Density vs Rating by Industry",
    x = "Average Density",
    y = "Average Rating"
  ) +
  theme_minimal()

ggplot(zip_small, aes(x = log(avg_density + 1), y = avg_rating)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm", se = FALSE) +
  facet_wrap(~ industry) +
  theme_minimal()

#this code also crashes my computer
library(tidyverse)
library(readr)
library(data.table)
review <- read_csv('yelp_academic_dataset_review.csv')
colnames(review)

