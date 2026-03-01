# # library(googledrive)
# 
# download_gdrive_file <- function(file_id, output_path) {
#   url <- paste0("https://drive.google.com/uc?export=download&id=", file_id)
#   download.file(url, destfile = output_path, mode = "wb")
# }
# 
# # business
# download_gdrive_file("BUSINESS_ID_HERE", "data/raw/business.csv")
# 
# # review
# download_gdrive_file("REVIEW_ID_HERE", "data/raw/review.csv")
# 
# # checkin
# download_gdrive_file("CHECKIN_ID_HERE", "data/raw/checkin.csv")

#----------------
#Setup
library(tidyverse)
library(lubridate)
library(vroom)

business <- read_csv("yelp_academic_dataset_business.csv")
glimpse(business)
summary(business)
tip <- read_csv("yelp_academic_dataset_tip.csv")
glimpse(tip)
summary(tip)



review <- vroom("yelp_academic_dataset_review.csv")
glimpse(review)
head(review)
summary(review)

# NA checks
# OUTPUT: No missing values
colSums(is.na(review))
colSums(is.na(tip))

# explore review data
# OUTPUT: same number of business ids as business dataset
#         date spans 17 years from 2005-2022
review %>%
  summarise(
    n_reviews = n(),
    n_business = n_distinct(business_id),
    n_users = n_distinct(user_id),
    min_date = min(date),
    max_date = max(date))

# Reviews over time
# OUTPUT: steady rise till 2018 followed by a steep fall
reviews_by_year <- review %>%
  mutate(year = lubridate::year(date)) %>%
  count(year)

  ggplot(reviews_by_year, aes(x = year, y = n)) +
  geom_line() +
  scale_x_continuous(breaks = seq(min(reviews_by_year$year), max(reviews_by_year$year), by = 2)) +
  labs(
    title = "Number of Reviews per Year",
    x = "Year",
    y = "Number of Reviews") 

# frequency table: number of businesses per review counts 
# OUTPUT: 56% of businesses have between 6-25 reviews
  review %>%
    count(business_id, name = "n_reviews") %>%
    mutate(
      bucket = cut(
        n_reviews,
        breaks = c(0, 5, 10, 25, 50, 100, 250, 500, 1000, Inf),
        labels = c("1-5","6-10","11-25","26-50","51-100",
                   "101-250","251-500","501-1000","1000+")
      )
    ) %>%
    count(bucket) %>%
    mutate(pct = n / sum(n)) %>%
    ggplot(aes(x = bucket, y = pct)) +
    geom_col() +
    scale_y_continuous(labels = scales::percent) +
    geom_text(
      aes(label = scales::percent(pct, accuracy = 0.1)),
      vjust = -0.3,
      size = 3
    ) +
    labs(
      title = "Businesses by Review Count Bucket",
      x = "Review count bucket",
      y = "Percentage of businesses"
    )
  
# star distribution
# OUTPUT: mostly 5 stars, 21% by 4 or 15% 1 stars
#   use standard deviation later to capture polarization
  review %>%
    count(stars) %>%
    arrange(stars)
  
  ggplot(review, aes(x = stars)) +
    geom_bar() +
    scale_y_continuous(labels = scales::comma) +
    labs(
      title = "Distribution of Review Star Ratings",
      x = "Star Rating",
      y = "Number of Reviews"
    )

# review length
# OUTPUT: lower stars, longer reviews
review <- review %>%
  mutate(review_length = nchar(text))

review %>%
  summarise(
    mean_length = mean(review_length),
    median_length = median(review_length),
    p25 = quantile(review_length, 0.25),
    p75 = quantile(review_length, 0.75),
    p90 = quantile(review_length, 0.9),
    p99 = quantile(review_length, 0.99)
  )

ggplot(review, aes(x = review_length)) +
  geom_histogram(bins = 80) +
  coord_cartesian(xlim = c(0, 2000)) +
  labs(
    title = "Review Length (0–2000 characters)",
    x = "Characters",
    y = "Number of Reviews"
  ) +
  scale_y_continuous(labels = scales::comma)

review %>%
  group_by(stars) %>%
  summarise(
    median_length = median(review_length),
    mean_length = mean(review_length),
    p75 = quantile(review_length, 0.75),
    p90 = quantile(review_length, 0.9),
    .groups = "drop"
  )

# engagement intensity
# A negligible number of negative vote values were observed (<0.0001%) and retained, as they do not materially affect results.
# OUTPUT: lower star reviews get more useful votes
# OUTPUT: higher star reviews get more cool votes
review %>%
  summarise(
    funny_neg = sum(funny < 0),
    cool_neg = sum(cool < 0),
    useful_neg = sum(useful < 0)
      )

review %>%
  group_by(stars) %>%
  summarise(
    mean_funny = mean(funny),
    median_funny = median(funny),
    mean_useful = mean(useful),
    median_useful = median(useful),
    mean_cool = mean(cool),
    median_cool = median(cool),
    .groups = "drop"
  )



# aggregate review to business level
review_business <- review %>%
  mutate(engagement = funny + cool + useful) %>%
  group_by(business_id) %>%
  summarise(
    n_reviews_actual = n(),
    avg_review_stars = mean(stars),
    sd_review_stars = sd(stars),
    avg_review_length = mean(review_length),
    avg_engagement = mean(engagement),
    .groups = "drop"
  )

# correlation between engagement vs review counts
review_business %>%
  summarise(
    cor_engagement_reviews = cor(avg_engagement, n_reviews_actual, use = "complete.obs"),
    cor_engagement_rating = cor(avg_engagement, avg_review_stars, use = "complete.obs")
  )


# tip
# OUTPUT: date 2009-2022, cover 70% of the business dataset
tip <- tip %>% mutate(tip_length = nchar(text))

tip %>%
  summarise(
    n_tips = n(),
    n_business = n_distinct(business_id),
    n_users = n_distinct(user_id),
    min_date = min(date),
    max_date = max(date)
  )
# tip length
tip %>%
  summarise(
    mean_length = mean(tip_length),
    median_length = median(tip_length),
    p75 = quantile(tip_length, 0.75),
    p90 = quantile(tip_length, 0.9),
    max_length = max(tip_length)
  )

#tip compliment
# OUTPUT: negligible, 98.8% of tips have no compliments
tip %>%
  count(compliment_count) %>%
  mutate(pct = n / sum(n))

# date distribution
# mostly in 2012-2017, steep drop after
tip %>%
  mutate(year = year(date)) %>%
  count(year) %>%
  ggplot(aes(x = year, y = n)) +
  geom_line() +
  labs(
    title = "Number of Tips per Year",
    x = "Year",
    y = "Number of Tips"
  )

tip_business <- tip %>%
  group_by(business_id) %>%
  summarise(
    n_tips = n(),
    avg_tip_length = mean(tip_length),
    .groups = "drop"
  )


# do not treat tips (0.9m) and reviews (7m) the same way
# check tips vs review correlation
# OUTPUT: high correlation, 
# suggest to keep review and drop tips from regression, tips dont add extra info and overlap with review
review_business %>%
  left_join(tip_business, by = "business_id") %>%
  summarise(cor_reviews_tips = cor(n_reviews_actual, n_tips, use = "complete.obs"))

# merge review with business
business_enriched <- business %>%
  left_join(review_business, by = "business_id")
