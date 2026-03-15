TEMP = ../../gen/temp
DATA = ../../data

# Main target
all: $(TEMP)/merged_research_project.csv

# Step 1: Download data
$(DATA)/yelp_business.csv: load_dataset.R
	R -e "dir.create('$(DATA)', showWarnings = FALSE, recursive = TRUE)"
	Rscript load_dataset.R


# Step 2: Clean and filter business data
$(TEMP)/research_project_filtered.csv: clean_data.R $(DATA)/yelp_business.csv
	R -e "dir.create('$(TEMP)', showWarnings = FALSE, recursive = TRUE)"
	Rscript clean_data.R

# Step 7: Prepare regression & check-in data
# NOTE: requires $(TEMP)/research_project_density.csv to already exist
# (produced by steps 3–6, not yet automated)
$(TEMP)/merged_research_project.csv \
$(TEMP)/research_project_regression.csv \
$(TEMP)/yelp_checkin_clean.csv \
$(TEMP)/business_checkin_count.csv \
$(DATA)/yelp_checkin.csv: prepare_regression_data.R $(TEMP)/research_project_filtered.csv
	Rscript prepare_regression_data.R
