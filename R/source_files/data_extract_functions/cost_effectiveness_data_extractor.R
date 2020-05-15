
cost_effectiveness_data_extractor <- function(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                                              switch_nets, switch_irs, NET_type, population, 
                                              itn_base_cost, itn_pbo_cost,
                                              itn_dist_cost, irs_cost, ...){
  
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
  
  #Work out costs
  all_interventions$population <- population
  all_interventions$cost <- all_interventions$switch_nets*all_interventions$population*c(itn_base_cost, itn_pbo_cost)[all_interventions$NET_type]*itn_dist_cost + all_interventions$switch_irs*all_interventions$population*irs_cost
  
  #Make table for malaria part
  #Gotta do all bounds
  all_bounds_impact <- do.call(cbind, sapply(c(2, 1, 3), function(t){
    
    table_impact_data <- data_format_table_graph(malaria_array, all_interventions,
                                                 type, resistance, t, season, endemicity, phi, Q0, nets, sprays,
                                                 switch_nets, switch_irs, NET_type)
    
    #Work out future cases
    by_year <- table_impact_data[, paste0("month_", 0:47)]
    future_prev_year_mat <- matrix(rowMeans(do.call(rbind, sapply(1:6, function(y) matrix(unlist(by_year[y, ]), ncol = 12), simplify = FALSE))), ncol = 4, byrow = TRUE)
    
    prevalence_3_years <- rowMeans(future_prev_year_mat[, 1:3])
    cases_3_years <- prevalence_3_years*population
    
    reduction_in_cases_per_1000 <- ((cases_3_years[1] - cases_3_years)/population)*1000
    relative_reduction_cases <- 1 - cases_3_years/cases_3_years[1]
    
    z <- data.frame(efficacy = relative_reduction_cases, averted = reduction_in_cases_per_1000)
    colnames(z) <- paste0("bound_", t, "_", colnames(z))
    z 
    
  }, simplify = FALSE))
  
  #Costing
  averted_df_go <- data.frame(intervention = all_interventions$intervention,
                              total_cost = all_interventions$cost,
                              all_bounds_impact,
                              stringsAsFactors = FALSE)
  
  averted_df_go$intervention <- factor(averted_df_go$intervention,
                                       levels = c("Do nothing",
                                                  "Standard nets only",
                                                  "PBO nets only",
                                                  "IRS only",
                                                  "Standard nets with IRS",
                                                  "PBO nets with IRS"))
  averted_df_go
  
}