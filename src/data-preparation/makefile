TEMP = ../gen/temp
DATA = ../data

# Main target
all: $(TEMP)/research_project_filtered.csv

# Step 1: Download data
$(DATA)/yelp_business.csv: load_dataset.R 
	R -e "dir.create('$(DATA)')"
	Rscript load_dataset.R

# Step 2: Clean data
$(TEMP)/research_project_filtered.csv: new_dataset.R clean_data.R $(DATA)/yelp_business.csv 
	R -e "dir.create('$(TEMP)', recursive = T)"
	Rscript new_dataset.R 
	Rscript clean_data.R