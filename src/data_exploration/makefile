OUTPUT = ../../gen/output
TEMP   = ../../gen/temp


# Main target

all: $(OUTPUT)/distribution_star_ratings.png \
     $(OUTPUT)/stars_vs_review_count.png \
     $(OUTPUT)/stars_vs_business_density.png \
     $(TEMP)/zip_industry_density.csv \
     $(TEMP)/research_project_density.csv \
     $(OUTPUT)/percentage_business_industry.png \
     $(OUTPUT)/same_industry_density_vs_ratings.png \
     $(TEMP)/zip_summary.csv \
     $(TEMP)/zip_binned.csv \
     $(OUTPUT)/avg_rating_vs_industry_business_density.png \
     $(OUTPUT)/mean_rating_by_business_density.png


# Step 3: Basic exploratory visualisations

$(OUTPUT)/distribution_star_ratings.png \
$(OUTPUT)/stars_vs_review_count.png \
$(OUTPUT)/stars_vs_business_density.png: basic_plots.R $(TEMP)/research_project_filtered.csv
	R -e "dir.create('$(OUTPUT)', showWarnings = FALSE, recursive = TRUE)"
	Rscript basic_plots.R


# Step 4: Industry classification & ZIP density

$(TEMP)/research_project_filtered.txt \
$(TEMP)/zip_industry_density.csv \
$(TEMP)/research_project_density.csv: prepare_categories_and_density.R $(TEMP)/research_project_filtered.csv
	Rscript prepare_categories_and_density.R


# Step 5: Industry density plots & ZIP summaries

$(OUTPUT)/percentage_business_industry.png \
$(OUTPUT)/same_industry_density_vs_ratings.png \
$(TEMP)/zip_summary.csv \
$(TEMP)/zip_binned.csv: summaries_and_bins.R $(TEMP)/research_project_density.csv | $(OUTPUT)
	Rscript summaries_and_bins.R


# Step 6: Final ZIP-level density visualisations

$(OUTPUT)/avg_rating_vs_industry_business_density.png \
$(OUTPUT)/mean_rating_by_business_density.png: final_density_plots.R $(TEMP)/zip_summary.csv $(TEMP)/zip_binned.csv | $(OUTPUT)
	Rscript final_density_plots.R


$(OUTPUT):
	mkdir -p $(OUTPUT)
