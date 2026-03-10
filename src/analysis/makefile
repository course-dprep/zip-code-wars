OUTPUT = ../gen/output
TEMP = ../gen/temp
DATA = ../data

# Main target
all: $(TEMP)/research_project_regression.csv \
     $(OUTPUT)/base_regression.txt \
     $(OUTPUT)/regression_with_categories.txt \
     $(OUTPUT)/final_regression.pdf \
     $(TEMP)/merged_research_project.csv \
     $(OUTPUT)/results_by_industry.txt \

# Create output directory
$(OUTPUT):
	R -e "dir.create('$(OUTPUT)', recursive = T)"

# Data for research project regression
$(TEMP)/research_project_regression.csv: log_scaled_density_var.R $(TEMP)/research_project_density.csv
	Rscript log_scaled_density_var.R

# Base regression
$(OUTPUT)/base_regression.txt: base_regression.R $(TEMP)/research_project_regression.csv | $(OUTPUT)
	Rscript base_regression.R

# Regression with categories and interaction term
$(OUTPUT)/regression_with_categories.txt $(TEMP)/regression_with_categories.rds $(TEMP)/regression_with_interaction.rds: regression_with_categories.R $(TEMP)/research_project_regression.csv | $(OUTPUT)
	Rscript regression_with_categories.R

# Plot final regression
$(OUTPUT)/final_regression.pdf: final_regression.R $(TEMP)/research_project_regression.csv | $(OUTPUT)
	Rscript final_regression.R

# Merge checkin dataset
$(TEMP)/merged_research_project.csv $(TEMP)/yelp_checkin_clean.csv $(TEMP)/business_checkin_count.csv: checkin_data_engineering.R $(TEMP)/research_project_density.csv
	Rscript checkin_data_engineering.R

# Regression for each business category with merged dataset
$(OUTPUT)/results_by_industry.txt: regression_business_category_merge.R $(TEMP)/merged_research_project.csv | $(OUTPUT)
	Rscript regression_business_category_merge.R


