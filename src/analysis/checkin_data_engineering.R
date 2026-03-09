#this file is problematic when it is runned 

## Merging datasets (yelp_checkin) to uncover more useful IVs for a more robust regression model
## Full file link: 
## https://drive.google.com/file/d/1TqZIvA5GuiRD5x3w4LFh5E3A-g-5TeXG/view?usp=drive_link

library(googledrive)

file_id <- "1TqZIvA5GuiRD5x3w4LFh5E3A-g-5TeXG"

## Download the CSV
drive_download(as_id(file_id),
               path = "yelp_academic_dataset_checkin.csv",
               overwrite = TRUE)

yelp_checkin <- read.csv("yelp_academic_dataset_checkin.csv", stringsAsFactors = FALSE)

## Definition of check-in: Check-Ins are a way to keep track of the local businesses you visit and keep your friends updated with your latest comings and goings.

## Rationale for merging checkin data: To control for differences in customer traffic across businesses, which may influence average Yelp ratings independently of local competitive density.

yelp_checkin_clean <- yelp_checkin %>%
  separate_rows(date, sep = ",\\s*") %>%
  mutate(
    good_date = as.Date(lubridate::ymd_hms(date)),
    year      = lubridate::year(good_date),
    week      = lubridate::isoweek(good_date)
  )
View(yelp_checkin_clean)

# Count the checkin frequency for each business_id
business_checkin_count <- yelp_checkin_clean %>% 
  group_by(business_id) %>% 
  summarize(checkin_count = n()) 

# Merge the data 
merged_research_project <- research_project_density %>% left_join(business_checkin_count, by = c("business_id" = "business_id"))
View(merged_research_project)