ggplot(research_project_regression,aes(x = log_density,y = stars,
           color = industry_categorized)) + geom_smooth(method = "lm", se = FALSE) +
  labs(title = "Interaction Between Density and Industry",
    x = "Log Same-Industry Density",y = "Yelp Stars" )