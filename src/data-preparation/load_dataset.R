library(dplyr)
library(ggplot2)
library(data.table)
library(knitr)
library(rmarkdown)
library(tidyverse)
# Full file link
#https://drive.google.com/file/d/13AZqPcwUro0jwsZIv6Q3WXeEn58YD5_x/view?usp=share_link

install.packages("googledrive")

library(googledrive)
file_id <- "13AZqPcwUro0jwsZIv6Q3WXeEn58YD5_x"
url <- paste0("https://drive.google.com/uc?export=download&id=", file_id)

download.file(url,destfile = "yelp_academic_dataset_business.csv",mode = "wb")

yelp_business <- read.csv("yelp_academic_dataset_business.csv")

#table(yelp_business$postal_code)
summary(yelp_business$postal_code) #Already characters don't need to change 