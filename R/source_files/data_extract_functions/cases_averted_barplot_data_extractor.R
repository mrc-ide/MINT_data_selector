
cases_averted_barplot_data_extractor <- function(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                                                 switch_nets, switch_irs, NET_type, intervention, population){
  
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
  
  go_bounds_go <- do.call(cbind, sapply(1:3, function(y){
    
    table_impact_data <- data_format_table_graph(malaria_array, all_interventions,
                                                 type, resistance, y, season, endemicity, phi, Q0, nets, sprays,
                                                 switch_nets, switch_irs, NET_type)
    
    table_impact_data$intervention <- factor(table_impact_data$intervention,
                                             levels = c("Do nothing",
                                                        "Standard nets only",
                                                        "PBO nets only",
                                                        "IRS only",
                                                        "Standard nets with IRS",
                                                        "PBO nets with IRS"))
    
    #Work out future cases
    by_year <- table_impact_data[which(table_impact_data$uncertainty == y), paste0("month_", 0:47)]
    future_prev_year_mat <- matrix(rowMeans(do.call(rbind, sapply(1:6, function(y) matrix(unlist(by_year[y, ]), ncol = 12), simplify = FALSE))), ncol = 4, byrow = TRUE)
    
    prevalence_3_years <- rowMeans(future_prev_year_mat[, 1:3])
    cases_3_years <- prevalence_3_years*population
    
    reduction_in_cases <- cases_3_years[1] - cases_3_years
    
    if(y == 1){
      data.frame(intervention = table_impact_data$intervention, low = (reduction_in_cases/population) * 1000)
    } else {
      dfz <- data.frame(red_per_k = (reduction_in_cases/population) * 1000)
      colnames(dfz) <- c("low", "mean", "high")[y]
      dfz
    }
  }, simplify = FALSE))
  
  go_bounds_go
  
}