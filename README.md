[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-22041afd0340ce965d47ae6ef1cefeee28c7c493a6346c4f15d667ab976d596c.svg)](https://classroom.github.com/a/-5U7Jn2O)
> **Important:** This is a template repository to help you set up your team project.  
>  
> You are free to modify it based on your needs. For example, if your data is downloaded using *multiple* scripts instead of a single one (as shown in `\data\`), structure the code accordingly. The same applies to all other starter files—adapt or remove them as needed.  
>  
> Feel free to delete this text.


# Zip Code Wars: Geographic Density and Yelp Ratings analysis across Business Categories


## Motivation

As cities grow and consumer activity becomes increasingly concentrated, understanding the business location landscape becomes more important. Urban economies are shaped by where businesses locate and how densely they cluster as higher density can raise demand and convenience, attracting even more firms and shaping local competitive landscapes (Kopczewska et al., 2024).

In the digital economy, platforms like Yelp play a major role in shaping consumer choices and business visibility, making online ratings an important signal of perceived quality. Business reviews have been found to not only give insights about the quality of a product or service, but have proved to be significant indicators of consumer expectations as well (Chevalier & Mayzlin, 2006). Past studies have shown that online reviews can be shaped by local competition, income levels, and demographics, all of which can vary by geography (Luca, 2011), making the location of the reviewed business highly important. However, the existence of similar businesses in the same location, referred to as “density”, can also intensify competition and raise expectations, which may change how customers evaluate their experiences. 

Furthermore, while it is undeniable that consumer behaviors are impacted by reviews, the magnitude of that impact appears to vary across industries and business types. Past research demonstrates that consumers rely more on reviews for optional services given at beauty salons or restaurants than essential services such as healthcare (Hu, Liu, & Zhang, 2008). It is, therefore, essential to consider the effect the industry of the business plays when reviews are analyzed. Given this tension, this research aims to explore: “Does the density of certain businesses within a postal code associate with higher or lower average Yelp ratings, and how does this relationship vary across business industries?”

For business owners, the findings can inform location strategy and competitive positioning by clarifying when dense clusters are likely to help or hurt evaluations across categories, supporting better benchmarking, service and pricing decisions, and more targeted expansion or franchising choices. 

The findings are also relevant for landlords and urban planners, as density patterns influence foot traffic, commercial attractiveness, and rental values.

Research Question: How does the density of same-category businesses within a ZIP code relate to average Yelp ratings, and does this relationship differ by business industry?

## Data

- What dataset(s) did you use? How was it obtained?
- How many observations are there in the final dataset? 
- Include a table of variable description/operstionalisation. 

## Method

-Data exploration for this study begins with the selection of relevant columns from the yelp_academic_dataset_business.csv file, namely "state", "postal_code", "city", "review_count", "name", "categories", "stars". The columns needed for analysis are extracted from the initial database, and the data were cleaned by removing observations with missing values. The dataset was then explored using ggplot2 visualizations. Having plotted several graphs for distributions of star ratings, stars versus review count and stars versus business density by ZIP (postal code); the data is reformatted into factor variables where categories will be valuable for the research. Business labels are taken into account to determine the 20 most used business labels, and the businesses are categorized into 5 main industries accordingly. 
Once the industry classification procedure was completed, the research focused on the density of businesses within a single postal code. After the density of businesses is determined, several plots are drawn again to see how relationships change according to the industry densities by plotting each industry density against star ratings. When it is seen that the resulting figures were visually crowded, remedies are applied such as using smoothing codes together with ggplots. The study will further explore the data by separating business densities across different industries into 3 levels: low density, medium density and high density to see whether relationships will be more prominent across levels.
The research aims to use Linear Regression with Interaction Terms as the chosen method of analysis after data is explored, so that both the main relationship between the density of businesses within a postal code and Yelp ratings can be examined along with the moderating effect of industry of the business. The predicted model for the study can be seen as such: lm(rating(stars) ~ business_density + business_industry + business_density:business_category)


## Preview of Findings 
- Describe the gist of your findings (save the details for the final paper!)

- How are the findings/end product of the project deployed?
The findings are summarized in a PDF report, which includes key visualizations, regression results, interpretations, and implications. The report translates statistical results into clear insights on location strategy for business owners across categories.

- Explain the relevance of these findings/product. 

## Repository Overview 

**Include a tree diagram that illustrates the repository structure*

## Dependencies 

*Explain any tools or packages that need to be installed to run this workflow.*

## Running Instructions 

*Provide step-by-step instructions that have to be followed to run this workflow.*

## About 

This project is set up as part of the Master's course [Data Preparation & Workflow Management](https://dprep.hannesdatta.com/) at the [Department of Marketing](https://www.tilburguniversity.edu/about/schools/economics-and-management/organization/departments/marketing), [Tilburg University](https://www.tilburguniversity.edu/), the Netherlands.

The project is implemented by team 6 members: Aimee Wu, Duru Kurgun, Işıl Kanyılmaz, Gabriella Wong, Liane Gnuyen, Olha Zinyak
