OUTPUT = ../../gen/output
TEMP   = ../../gen/temp

# Main target

all: $(OUTPUT)/base_regression.txt \
     $(TEMP)/regression_with_categories.rds \
     $(TEMP)/regression_with_interaction.rds \
     $(OUTPUT)/regression_with_categories_summary.txt \
     $(OUTPUT)/final_regression.png \
     $(OUTPUT)/results_by_industry.txt


# Step 8: Regression models

$(OUTPUT)/base_regression.txt \
$(TEMP)/regression_with_categories.rds \
$(TEMP)/regression_with_interaction.rds \
$(OUTPUT)/regression_with_categories_summary.txt: regression_models.R $(TEMP)/research_project_regression.csv
	R -e "dir.create('$(OUTPUT)', showWarnings = FALSE, recursive = TRUE)"
	Rscript regression_models.R


# Step 9: Regression visualisation & industry results

$(OUTPUT)/final_regression.png \
$(OUTPUT)/results_by_industry.txt: regression_visualisation_and_industry_results.R $(TEMP)/research_project_regression.csv $(TEMP)/merged_research_project.csv | $(OUTPUT)
	Rscript regression_visualisation_and_industry_results.R


$(OUTPUT):
	mkdir -p $(OUTPUT)



