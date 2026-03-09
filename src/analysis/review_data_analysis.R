#this code also gives errors

# Load packages needed for JSON streaming and aggregation
library(jsonlite)
library(data.table)
library(readr)
library(dplyr)

# Create folders for raw and generated data
dir.create("data", showWarnings = FALSE)
dir.create("data/raw", recursive = TRUE, showWarnings = FALSE)
dir.create("data/raw/yelp_json", recursive = TRUE, showWarnings = FALSE)
dir.create("data/raw/yelp_tar", recursive = TRUE, showWarnings = FALSE)
dir.create("data/gen", recursive = TRUE, showWarnings = FALSE)

# Path where the final business-level review summary will be stored
review_summary_path <- "data/gen/review_business_summary.csv"

# Only rebuild the review summary if it does not already exist
if (!file.exists(review_summary_path)) {
  
  # Yelp ZIP file URL and local paths
  zip_url  <- "https://business.yelp.com/external-assets/files/Yelp-JSON.zip"
  zip_path <- "data/raw/Yelp-JSON.zip"
  json_dir <- "data/raw/yelp_json"
  untar_dir <- "data/raw/yelp_tar"
  
  # Download the ZIP file only if it is not already present
  if (!file.exists(zip_path)) {
    options(timeout = 60 * 60 * 2)  # allow long download time
    download.file(
      url = zip_url,
      destfile = zip_path,
      mode = "wb",
      method = "libcurl"
    )
  }
  
  # Unzip the downloaded archive
  unzip(zip_path, exdir = json_dir)
  
  # Find the TAR file inside the unzipped contents
  tar_files <- list.files(
    json_dir,
    pattern = "\\.tar$",
    recursive = TRUE,
    full.names = TRUE
  )
  
  # Stop if the TAR file cannot be uniquely identified
  if (length(tar_files) != 1) {
    stop("Could not uniquely identify the TAR file inside the ZIP archive.")
  }
  
  tar_path <- tar_files[1]
  
  # Extract the TAR archive
  untar(tar_path, exdir = untar_dir)
  
  # Find all JSON files inside the extracted TAR contents
  json_files <- list.files(
    untar_dir,
    pattern = "\\.json$",
    recursive = TRUE,
    full.names = TRUE
  )
  
  # Keep only the review.json file
  review_json <- json_files[grepl("review.*\\.json$", basename(json_files), ignore.case = TRUE)]
  
  # Stop if review.json cannot be uniquely identified
  if (length(review_json) != 1) {
    stop("Could not uniquely identify review.json inside the extracted TAR contents.")
  }
  
  review_json <- review_json[1]
  
  # Create an environment to store the running business-level accumulator
  agg_env <- new.env()
  agg_env$acc <- data.table(
    business_id = character(),
    n_reviews_actual = integer(),
    sum_stars = double(),
    sum_stars_sq = double(),
    sum_engagement = double()
  )
  
  # Define a handler function that processes one chunk of reviews at a time
  review_handler <- function(df) {
    dt <- as.data.table(df)
    
    # Keep only the fields needed for the business-level summary
    dt <- dt[, .(
      business_id,
      stars,
      funny,
      cool,
      useful
    )]
    
    # Aggregate the current chunk to business level
    chunk_summary <- dt[, .(
      n_reviews_actual = .N,
      sum_stars = sum(stars, na.rm = TRUE),
      sum_stars_sq = sum(stars^2, na.rm = TRUE),
      sum_engagement = sum(funny + cool + useful, na.rm = TRUE)
    ), by = business_id]
    
    # Append the chunk summary to the accumulator and collapse to one row per business
    agg_env$acc <- rbindlist(
      list(agg_env$acc, chunk_summary),
      use.names = TRUE,
      fill = TRUE
    )[
      , .(
        n_reviews_actual = sum(n_reviews_actual),
        sum_stars = sum(sum_stars),
        sum_stars_sq = sum(sum_stars_sq),
        sum_engagement = sum(sum_engagement)
      ),
      by = business_id
    ]
    
    NULL
  }
  
  # Stream the large review.json file in chunks so the full file is not loaded into memory
  con <- file(review_json, open = "rb")
  jsonlite::stream_in(
    con,
    handler = review_handler,
    pagesize = 50000,
    verbose = FALSE
  )
  close(con)
  
  # Compute the final business-level review variables
  review_business <- agg_env$acc[
    , `:=`(
      # Average review stars per business
      avg_review_stars = sum_stars / n_reviews_actual,
      
      # Average engagement per review
      avg_engagement = sum_engagement / n_reviews_actual,
      
      # Standard deviation of review stars per business
      sd_review_stars = ifelse(
        n_reviews_actual > 1,
        sqrt((sum_stars_sq - (sum_stars^2 / n_reviews_actual)) / (n_reviews_actual - 1)),
        NA_real_
      )
    )
  ][
    , .(
      business_id,
      n_reviews_actual,
      avg_review_stars,
      sd_review_stars,
      avg_engagement
    )
  ]
  
  # Save the summary so it can be reused without rebuilding
  write_csv(as_tibble(review_business), review_summary_path)
  
}

# Load the ready-made business-level review summary
review_business <- read_csv(review_summary_path, show_col_types = FALSE)

research_project_regression <- research_project_density %>%
  
  # Add check-in counts by business
  left_join(business_checkin_count, by = "business_id") %>%
  
  # Add review-derived business summary variables
  left_join(review_business, by = "business_id") %>%
  
  # Create transformed variables for regression
  mutate(
    # Replace missing counts with 0 where no matching record exists
    checkin_count = replace_na(checkin_count, 0),
    n_reviews_actual = replace_na(n_reviews_actual, 0),
    avg_engagement = replace_na(avg_engagement, 0),
    
    # Log-transform skewed count variables
    log_density = log1p(industry_zip_count),
    log_checkin_count = log1p(checkin_count),
    log_n_reviews = log1p(n_reviews_actual),
    log_avg_engagement = log1p(avg_engagement)
  )


# Extended regression model with yelp_review controls


# Add review-derived variables and check-in activity as controls
regression_with_review_controls <- lm(
  stars ~ log_density * industry_categorized +
    log_checkin_count +
    log_n_reviews +
    sd_review_stars +
    log_avg_engagement,
  data = research_project_regression
)

# Show model results
summary(regression_with_review_controls)

# Show R-squared for the extended model
summary(regression_with_review_controls)$r.squared

