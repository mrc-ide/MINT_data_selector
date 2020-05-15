
prevalence_time_plot <- function(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                                 switch_nets, switch_irs, NET_type, ...){
  
  prev_time <- prevalence_plot_data_extractor(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                                              switch_nets, switch_irs, NET_type)
  
    #Transform to ggplot format
  gg_prev <- data.frame(intervention = rep(prev_time$intervention, 
                                sum(grepl("month_", names(prev_time)))),
             prevalence = unlist(prev_time[, names(prev_time)[grepl("month_", names(prev_time))]]),
             month = rep(as.numeric(gsub("month_", "", names(prev_time)[grepl("month_", names(prev_time))])),
                         each = length(unique(prev_time$intervention))),
             stringsAsFactors = FALSE)
  
  
  ggplot() + geom_line(data = gg_prev, aes(x = month, y = prevalence*100, 
                                           group = intervention, color = intervention),
                       size = 1.5) + theme_minimal() + labs(y = "Prevalence (%)", x = "")
  
  
}