## Data visualization with ggplot 2 for percentage of businesses by industry
ggplot(research_project_density, aes(industry_categorized)) + 
  geom_bar(aes(y = after_stat(count)/sum(after_stat(count))*100)) + 
  ylab("Percentage of Businesses") + xlab("Industry Distribution") 
