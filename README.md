[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/-5U7Jn2O)

# Zip Code Wars: Geographic Density and Yelp Ratings Analysis across Business Categories

  **Research Question**: How does the density of same-category businesses within a ZIP code relate to average Yelp ratings, and does this relationship differ by business industry?

## Motivation

  As cities grow and consumer activity becomes increasingly concentrated, understanding the business location landscape becomes more important. Urban economies are shaped by where businesses locate and how densely they cluster as higher density can raise demand and convenience, attracting even more firms and shaping local competitive landscapes (Kopczewska et al., 2024).

  In the digital economy, platforms like Yelp play a major role in shaping consumer choices and business visibility, making online ratings an important signal of perceived quality. Business reviews have been found to not only give insights about the quality of a product or service, but have proved to be significant indicators of consumer expectations as well (Chevalier & Mayzlin, 2006). Past studies have shown that online reviews can be shaped by local competition, income levels, and demographics, all of which can vary by geography (Luca, 2011), making the location of the reviewed business highly important. However, the existence of similar businesses in the same location, referred to as “density”, can also intensify competition and raise expectations, which may change how customers evaluate their experiences. 

  Furthermore, while it is undeniable that consumer behaviors are impacted by reviews, the magnitude of that impact appears to vary across industries and business types. Past research demonstrates that consumers rely more on reviews for optional services given at beauty salons or restaurants than essential services such as healthcare (Hu, Liu, & Zhang, 2008). It is, therefore, essential to consider the effect the industry of the business plays when reviews are analyzed. Given this tension, this research aims to explore: “Does the density of certain businesses within a postal code associate with higher or lower average Yelp ratings, and how does this relationship vary across business industries?”

For business owners, the findings can inform location strategy and competitive positioning by clarifying when dense clusters are likely to help or hurt evaluations across categories, supporting better benchmarking, service and pricing decisions, and more targeted expansion or franchising choices. The findings are also relevant for landlords and urban planners, as density patterns influence foot traffic, commercial attractiveness, and rental values.


## Data

  This study includes data from a subset of Yelp data designed for educational purposes called the [Yelp Open Dataset](https://business.yelp.com/data/resources/open-dataset/). It offers actual information on businesses, such as reviews, images, check-ins, and features like parking availability, hours, and atmosphere. This study, as it particularly focuses on business zip codes and business categories, utilizes data from the **business.json** which contains business information such as classifications, attributes, and geographical data.
***Use of the Yelp Dataset is governed by the terms and conditions outlined in the document added to the prepository along side the yelp_academic_dataset_business.csv in the respository.***

  The original data set contains 150346 observations with 14 variables such as States, Postcal Codes (also referred to in this study as ***zip codes***), Review Counts, Categories..etc. You can view the fully rendered HTML table here:

[Click to open the Table for Raw Data Variables](data/Table-for-Raw-Data-Vairables.html)
  
## Variable Definitions

| Variable Name | Role in Model | Conceptual Definition | Operational Definition | Measurement Level |
|---------------|--------------|----------------------|-----------------------|-------------------|
| stars | Dependent variable | Star rating represents the aggregated consumer evaluation of a business’s quality and overall service performance based on user generated online reviews. Online ratings function as electronic word of mouth and influence consumer expectations and purchasing decisions by summarizing collective experiences into an interpretable quality signal (Chevalier & Mayzlin, 2003). | Average Yelp star rating assigned to a business | Continuous variable bounded between 1 and 5 |
| industry_zip_count | Main independent variable | Industry ZIP density reflects the intensity of local same industry business clustering within a defined geographic unit. According to agglomeration theory, spatial concentration of firms can increase demand and consumer convenience (Alcacer & Chung, 2010). However, higher density can intensify competition and elevate consumer expectations, potentially affecting performance evaluations. | Number of businesses within the same postal code and same industry category | Count variable |
| industry_categorized | Moderator | Industry categorization captures structural differences in service type and consumer involvement. Consumer reliance on online reviews varies across industries. Reviews tend to exert stronger influence in discretionary and experiential industries such as restaurants and beauty services compared to necessity based services (Hu et al., 2008). Industry type is therefore expected to moderate the relationship between competitive density and consumer evaluations. | Categorical variable with five levels: Food and Drink, Health and Beauty, Auto and Transport, Veterinarians and Pet Shops, Other | Nominal factor variable |
| review_count | Control variable | Review count represents the volume of consumer generated feedback received by a business. A higher review volume strengthens the credibility and informational value of average ratings, thereby influencing consumer decision making (Duan et al., 2008). | Total number of reviews received by a business | Count variable |

## Method

  Data exploration for this study begins with the selection of relevant columns from the yelp_academic_dataset_business.csv file, namely "state", "postal_code", "city", "review_count", "name", "categories", "stars". For data cleaning, observations with missing postal codes were removed prior to analysis since postal code serves as the fundamental spatial unit to calculate business density. Businesses without a valid postal code cannot be assigned to geographic clusters, making density grouping infeasible. The missing values appear to stem from administrative or issues from platform rather than systematic rating behaviour. There is no to little theoretical literature suggesting that industry classification or Yelp ratings are correlated with the absence of postal code information. Therefore, the missing values are unlikely to be systematic and does not bias the estimation. Given that, removing these observations ensures greater accuracy in density calculation.  
  The dataset is then explored using ggplot2 visualizations. Having plotted several graphs for distributions of star ratings, stars versus review count and stars versus business density by ZIP (postal code); the data is reformatted into factor variables where categories will be valuable for the research. Business labels are taken into account to determine the 20 most used business labels, and the businesses are categorized into 5 main industries accordingly.

  Once the industry classification procedure is completed, the research focuses on the density of businesses within a single postal code. After the density of businesses is determined, several plots are drawn again to see how relationships change according to the industry densities by plotting each industry density against star ratings. When it is seen that the resulting figures were visually crowded, remedies are applied such as using smoothing codes together with ggplots. The study further explores the data by separating business densities across different industries into 3 levels: low density, medium density and high density to see whether relationships will be more prominent across levels.
  
  The study aims to use Linear Regression with Interaction Terms as the chosen method of analysis after data is explored, so that both the main relationship between the density of businesses within a postal code and Yelp ratings can be examined along with the moderating effect of industry of the business. 
  
  The predicted model for the study can be seen as such: lm(rating(stars) ~ business_density + business_industry + business_density:business_category)
ss_category)

## Preview of Findings 

The regression analyses reveal a statistically significant relationship between business density within ZIP codes and average Yelp ratings. Businesses located in areas with higher concentrations of similar establishments tend to experience modest changes in ratings, suggesting that local competitive environments may influence customer evaluations.

Further modeling shows that business industry plays an important moderating role in this relationship. The impact of density is not uniform across sectors; some industries appear to benefit more from clustering than others, while in certain categories the effect is minimal or statistically uncertain.

An additional model comparison confirms that including industry-based interaction effects significantly improves the explanatory power of the model. Overall, the findings indicate that competitive clustering can influence online ratings, but the magnitude and direction of this effect vary by business category. However, the relatively low explained variance suggests that many other factors beyond local density also contribute to Yelp ratings.

The findings of this study can assist business owners in improving their location strategy and competitive positioning by defining when dense clusters are likely to benefit or damage assessments across categories, allowing for better benchmarking, service and pricing decisions, and more targeted expansion or franchising options.

The findings are summarized in a two RMarkdown files and a PDF report, which includes details regarding data exploration, relevant plots, regression results, interpretations, and implications.


## Repository Overview 

This repository contains all data required for the project. The tree diagram below illustrates the repository structure so that the project workflow can be run successully:

```
project-root/
│
├── data/                             # raw downloaded datasets
│   ├── yelp_business.csv
│   └── yelp_checkin.csv
│
├── gen/
│   ├── temp/                         # intermediate generated data
│   │   ├── research_project_filtered.csv
│   │   ├── research_project_filtered.txt
│   │   ├── zip_industry_density.csv
│   │   ├── research_project_density.csv
│   │   ├── zip_summary.csv
│   │   ├── zip_binned.csv
│   │   ├── research_project_regression.csv
│   │   ├── yelp_checkin_clean.csv
│   │   ├── business_checkin_count.csv
│   │   ├── merged_research_project.csv
│   │   ├── regression_with_categories.rds
│   │   └── regression_with_interaction.rds
│   │
│   └── output/                       # final figures and model outputs
│       ├── distribution_star_ratings.png
│       ├── stars_vs_review_count.png
│       ├── stars_vs_business_density.png
│       ├── percentage_business_industry.png
│       ├── same_industry_density_vs_ratings.png
│       ├── avg_rating_vs_industry_business_density.png
│       ├── mean_rating_by_business_density.png
│       ├── base_regression.txt
│       ├── regression_with_categories_summary.txt
│       ├── final_regression.png
│       └── results_by_industry.txt
│
├── reporting/                        # final report
│   ├── Makefile
│   └── Team_5_Report.Rmd
│
├── src/                              # analysis pipeline scripts
│   ├── data-preparation/
│   │   ├── Makefile
│   │   ├── load_dataset.R
│   │   ├── clean_data.R
│   │   └── prepare_regression_data.R
│   │
│   ├── data_exploration/
│   │   ├── Makefile
│   │   ├── basic_plots.R
│   │   ├── prepare_categories_and_density.R
│   │   ├── summaries_and_bins.R
│   │   └── final_density_plots.R
│   │
│   └── analysis/
│       ├── Makefile
│       ├── regression_models.R
│       └── regression_visualisation_and_industry_results.R
│
├── .gitignore
├── README.md
└── Makefile                          # master pipeline controller
```

## Dependencies 

In order to run the workflow used in this study, the tools and packages listed below should be installed:

- **R (≥ 4.2.0)** — packages used: `dplyr`, `ggplot2`, `data.table`, `knitr`, `rmarkdown`, `tidyverse`, `googledrive`
- **RStudio**
- **LaTeX distribution** — TinyTeX or TeX Live (required for PDF rendering)

## Running Instructions 

To reproduce the analyses performed in this study:

1. Clone the Repository:
First, clone the repository to your local machine and navigate into the project folder.

On Terminal:
  git clone <[repository-url](https://github.com/course-dprep/zip-code-wars.git)>
  cd project
  
2. Install Required R Packages:
Open R and install the required packages.

In R:
 install.packages(c("tidyverse", "data.table", "ggplot2", "readr", "dplyr", "broom"))
   
3. Run the Full Pipeline:
This repository uses Makefiles to automate the workflow. From the root project directory, run:

On Terminal:
  make

 This command will automatically execute the following steps in order:
 
	1.	Data Preparation (data-preparation/)
 
	•	Loading the Yelp dataset
	•	Filtering and restructuring the data
	•	Producing cleaned datasets saved in gen/temp/
 
	2.	Data Exploration (data_exploration/)
 
	•	Generating exploratory visualizations of ratings, density, and industries
	•	Saving plots in gen/output/
 
	3.	Analysis (analysis/)
 
	•	Creating the log-transformed density variable
	•	Running regression models
	•	Saving regression outputs and model summaries

4. Locate Outputs:
After running the pipeline, results will be generated.
	•	Temporary processed data:gen/temp/
	•	Final figures and regression outputs:gen/output/ 

This project adheres to the following best practices to ensure reproducibility:

-	Code executes in a top-to-bottom linear fashion.
-	Outputs are automatically regenerated.
-	The repository tracks only source code, not generated files.

The expected outputs from the code files include:

- Cleaned datasets
- Exploratory visualizations
- Regression model outputs
- A reproducible PDF report

## About 

This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by Team 5, members including: [Aimee Wu](https://github.com/AimeeMeiWu), [Duru Kurgun](https://github.com/durukurgun03), [Işıl Kanyılmaz](https://github.com/isilkanyilmaz), [Gabriella Wong](https://github.com/gl-wong), [Liane Gnuyen](https://github.com/pblnguyen-create), [Olha Zinyak](https://github.com/OlhaZin23)
