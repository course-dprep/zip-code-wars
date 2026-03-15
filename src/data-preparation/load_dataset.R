# =============================================================================
# STEP 1 — Load libraries and download the Yelp Business dataset
# INPUT:   Google Drive (public link)
# OUTPUT:  ../../data/yelp_business.csv
# =============================================================================

options(repos = c(CRAN = "https://cloud.r-project.org"))
library(dplyr)
library(ggplot2)
library(data.table)
library(knitr)
library(rmarkdown)
library(tidyverse)
library(googledrive)

# Full link: https://drive.google.com/file/d/13AZqPcwUro0jwsZIv6Q3WXeEn58YD5_x/view?usp=share_link

if (!requireNamespace("googledrive", quietly = TRUE)) {
  install.packages("googledrive")
}
library(googledrive)

file_id <- "13AZqPcwUro0jwsZIv6Q3WXeEn58YD5_x"
url <- paste0("https://drive.google.com/uc?export=download&id=", file_id)

download.file(url,destfile = "yelp_academic_dataset_business.csv",mode = "wb")

# Load into R
yelp_business <- read.csv("yelp_academic_dataset_business.csv")

# Check data
table(yelp_business$postal_code)
summary(yelp_business$postal_code) #Already characters don't need to change 

# Save output
download.file(url, destfile = "../../data/yelp_business.csv", mode = "wb")
yelp_business <- read.csv("../../data/yelp_business.csv")
