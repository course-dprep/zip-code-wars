library(data.table)

setDT(research_project_filtered)
research_project_filtered[, state_categories := as.factor(state)]
research_project_filtered[,  postal_code_categories := as.factor( postal_code)]
research_project_filtered[,  city_categories := as.factor( city)]

#seeing wich category is used how many times to decide on the industry labels, checking for top 20 most used
research_project_filtered[
  , .(category = tolower(trimws(unlist(categories))))
][
  , .N, by = category
][
  order(-N)
][1:20]

#determining the top categories and turning them into 5 main categories

#cleaning categories entries and turning all lowercase
research_project_filtered[, categories_text := tolower(as.character(categories))]
research_project_filtered[, industry_categorized := "Other"]

research_project_filtered[grepl("restaurants|food|coffee|tea|mexican|italian|burgers|pizza|ice cream|yogurt|chinese",
                                categories_text),
                          industry_categorized := "Food & Drink"]

research_project_filtered[grepl("beauty|spa|hair|nail",
                                categories_text),
                          industry_categorized := "Health & Beauty"]

research_project_filtered[grepl("veterinarians|pets",
                                categories_text),
                          industry_categorized := "Veterinarians & Pet Shops"]

research_project_filtered[grepl("auto|automotive|repair",
                                categories_text),
                          industry_categorized := "Auto & Transport"]

summary(research_project_filtered)
research_project_filtered[,  industry_categorized := as.factor( industry_categorized)]
