## Data Cleaning
yelp_checkin_clean <- yelp_checkin %>%
  separate_rows(date, sep = ",\\s*") %>%
  mutate(
    good_date = as.Date(lubridate::ymd_hms(date)),
    year      = lubridate::year(good_date),
    week      = lubridate::isoweek(good_date)
  )
View(yelp_checkin_clean)