
prevalence_time_plot <- function(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                                 switch_nets, switch_irs, NET_type, intervention){
  
  all_interventions <- data.frame(intervention = c("Do nothing",
                                                   "Standard nets only",
                                                   "PBO nets only",
                                                   "IRS only",
                                                   "Standard nets with IRS",
                                                   "PBO nets with IRS"),
                                  switch_nets = c(0, switch_nets, switch_nets, 0, switch_nets, switch_nets),
                                  NET_type = c(1, 1, 2, 2, 1, 2),
                                  switch_irs = c(0, 0, 0, switch_irs, switch_irs, switch_irs),
                                  stringsAsFactors = FALSE)
  
  
  prev_time <- data_format_table_graph(malaria_array, all_interventions,
                          type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                          switch_nets, switch_irs, NET_type)
  
  prev_time$intervention <- factor(prev_time$intervention,
                                   levels = c("Do nothing",
                                              "Standard nets only",
                                              "PBO nets only",
                                              "IRS only",
                                              "Standard nets with IRS",
                                              "PBO nets with IRS"))
  
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