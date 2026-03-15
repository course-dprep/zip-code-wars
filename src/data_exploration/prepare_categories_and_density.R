# =============================================================================
# STEP 4: INDUSTRY CLASSIFICATION AND ZIP-LEVEL INDUSTRY DENSITY
# INPUT: ../../gen/temp/research_project_filtered.csv
# OUTPUT:
#   ../../gen/temp/research_project_filtered.csv
#   ../../gen/temp/zip_industry_density.csv
#   ../../gen/temp/research_project_density.csv
#   ../../gen/temp/research_project_filtered.txt
# =============================================================================

library(data.table)
library(dplyr)

# Load data
research_project_filtered <- read.csv("../../gen/temp/research_project_filtered.csv")
setDT(research_project_filtered)

# Factor versions of location variables
research_project_filtered[, state_categories := as.factor(state)]
research_project_filtered[, postal_code_categories := as.factor(postal_code)]
research_project_filtered[, city_categories := as.factor(city)]

# Inspect top categories
top_categories <- research_project_filtered[
  , .(category = tolower(trimws(unlist(categories))))
][
  , .N, by = category
][
  order(-N)
][1:20]

print(top_categories)

# Clean categories and assign industry groups
research_project_filtered[, categories_text := tolower(as.character(categories))]
research_project_filtered[, industry_categorized := "Other"]

research_project_filtered[
  grepl(
    "restaurants|food|coffee|tea|mexican|italian|burgers|pizza|ice cream|yogurt|chinese",
    categories_text
  ),
  industry_categorized := "Food & Drink"
]

research_project_filtered[
  grepl("beauty|spa|hair|nail", categories_text),
  industry_categorized := "Health & Beauty"
]

research_project_filtered[
  grepl("veterinarians|pets", categories_text),
  industry_categorized := "Veterinarians & Pet Shops"
]

research_project_filtered[
  grepl("auto|automotive|repair", categories_text),
  industry_categorized := "Auto & Transport"
]

research_project_filtered[, industry_categorized := as.factor(industry_categorized)]

summary(research_project_filtered)

# Save updated filtered dataset
write.csv(
  research_project_filtered,
  "../../gen/temp/research_project_filtered.csv",
  row.names = FALSE
)

# ZIP by industry density
zip_industry_density <- research_project_filtered %>%
  group_by(postal_code, industry_categorized) %>%
  summarise(
    industry_zip_count = n(),
    .groups = "drop"
  )

research_project_density <- research_project_filtered %>%
  left_join(
    zip_industry_density,
    by = c("postal_code", "industry_categorized")
  )

# Save outputs
write.csv(
  zip_industry_density,
  "../../gen/temp/zip_industry_density.csv",
  row.names = FALSE
)

write.csv(
  research_project_density,
  "../../gen/temp/research_project_density.csv",
  row.names = FALSE
)

# Sentinel file for Makefile
file.create("../../gen/temp/research_project_filtered.txt")
