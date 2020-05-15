
cases_averted_barplot <- function(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                                  switch_nets, switch_irs, NET_type, population, ...){
  
  
  barplot_data <- cases_averted_barplot_data_extractor(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                                                       switch_nets, switch_irs, NET_type, population)
  
  ggplot() + geom_bar(data = barplot_data, aes(x = intervention, 
                                               y = mean, 
                                               fill = intervention),
                      stat = "identity") + theme_minimal() + 
    labs(x = "Intervention", y = "Cases", fill = "Intervention",
         title = "Clinical cases averted per 1,000 people per year") +
    geom_errorbar(data = barplot_data,
                  aes(x = intervention, 
                      y = mean,
                      ymin = low, ymax = high))
  
}