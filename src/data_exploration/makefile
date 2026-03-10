OUTPUT = ../gen/output
TEMP = ../gen/temp

# Main target
all: $(OUTPUT)/dist_star_rating.pdf $(OUTPUT)/stars_vs_review_count.pdf $(OUTPUT)/stars_vs_business_density.pdf $(TEMP)/research_project_filtered.csv $(TEMP)/zip_industry_density.csv $(TEMP)/research_project_density.csv $(OUTPUT)/percentage_business_industry.pdf $(OUTPUT)/business_density_effect_on_ratings_per_industry.pdf $(TEMP)/zip_summary.csv $(OUTPUT)/avg_rating_vs_industry_business_density.pdf $(TEMP)/zip_binned.csv $(OUTPUT)/mean_rating_by_business_density.pdf 

# Distribution of star ratings
$(OUTPUT)/dist_star_rating.pdf: dist_star_ratings.R $(TEMP)/research_project_filtered.csv
	R -e "dir.create('$(OUTPUT)', recursive = T)"
	Rscript dist_star_ratings.R

# Stars vs review count
$(OUTPUT)/stars_vs_review_count.pdf: stars_vs_review_count.R $(TEMP)/research_project_filtered.csv
	R -e "dir.create('$(OUTPUT)', recursive = T)"
	Rscript stars_vs_review_count.R

# Stars vs business density by ZIP
$(OUTPUT)/stars_vs_business_density.pdf: stars_vs_business_density.R $(TEMP)/research_project_filtered.csv
	R -e "dir.create('$(OUTPUT)', recursive = T)"
	Rscript stars_vs_business_density.R

# Dive Deeper into separate business categories 
$(TEMP)/research_project_filtered.txt: business_categories.R $(TEMP)/research_project_filtered.csv 
	Rscript business_categories.R 
	touch $(TEMP)/research_project_filtered.txt

# Density of businesses by industry
$(TEMP)/zip_industry_density.csv $(TEMP)/research_project_density.csv: business_density_by_industry.R $(TEMP)/research_project_filtered.txt
	Rscript business_density_by_industry.R

# Data visualization with ggplot 2 for percentage of businesses by industry
$(OUTPUT)/percentage_business_industry.pdf: percentage_business_industry.R $(TEMP)/research_project_density.csv | $(OUTPUT)
	Rscript percentage_business_industry.R

# Plotting to see if ratings are affected by business density per industry
$(OUTPUT)/business_density_effect_on_ratings_per_industry.pdf: business_density_effect_on_ratings_per_industry.R $(TEMP)/research_project_density.csv | $(OUTPUT)
	Rscript business_density_effect_on_ratings_per_industry.R

# Plotting Aggregated Ratings in zip code and category level
$(TEMP)/zip_summary.csv: zip_summary.R $(TEMP)/research_project_density.csv
	Rscript zip_summary.R

# Smoothed Plotting
$(OUTPUT)/avg_rating_vs_industry_business_density.pdf: avg_rating_vs_industry_business_density.R $(TEMP)/zip_summary.csv | $(OUTPUT)
	 Rscript avg_rating_vs_industry_business_density.R

# Create zipbinned
$(TEMP)/zip_binned.csv: zip_binned.R $(TEMP)/zip_summary.csv
	Rscript zip_binned.R

# Mean rating by business density
$(OUTPUT)/mean_rating_by_business_density.pdf: mean_rating_by_business_density.R $(TEMP)/zip_binned.csv | $(OUTPUT)
	Rscript mean_rating_by_business_density.R