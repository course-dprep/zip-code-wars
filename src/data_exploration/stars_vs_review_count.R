# Stars vs review count
ggplot(research_project_filtered, aes(x = review_count, y = stars)) +
  geom_point(alpha = 0.2) +
  scale_x_log10() +
  labs(title = "Stars vs Review Count",
       x = "Review Count (log scale)", y = "Stars")
