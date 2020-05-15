
table_impact_data <- function(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                                    switch_nets, switch_irs, NET_type, population, ...){
  
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
  
  table_impact_data <- data_format_table_graph(malaria_array, all_interventions,
                          type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                          switch_nets, switch_irs, NET_type)
  
  
  #Work out cases 
  past_prev <- rowMeans(table_impact_data[, paste0("month_", -12:-1)])
  past_case <- past_prev*population
  
  #Work out future cases
  by_year <- table_impact_data[, paste0("month_", 0:47)]
  future_prev_year_mat <- matrix(rowMeans(do.call(rbind, sapply(1:6, function(y) matrix(unlist(by_year[y, ]), ncol = 12), simplify = FALSE))), ncol = 4, byrow = TRUE)
  
  
  prevalence_3_years <- rowMeans(future_prev_year_mat[, 1:3])
  cases_3_years <- prevalence_3_years*population
  
  reduction_in_cases <- cases_3_years[1] - cases_3_years
  relative_reduction_cases <- 1 - cases_3_years/cases_3_years[1]
  
  prevalence_reduction <- 1 - prevalence_3_years/prevalence_3_years[1] 
  
  data.frame(interventions = all_interventions$intervention,
             net_use = all_interventions$switch_nets,
             IRS_cover = all_interventions$switch_irs,
             prev_under_5_year_1 = future_prev_year_mat[, 1],
             prev_under_5_year_2 = future_prev_year_mat[, 1],
             prev_under_5_year_3 = future_prev_year_mat[, 1],
             relative_reduction_in_prevalence_under_5 = prevalence_reduction,
             cases_averted_across_3_years = reduction_in_cases,
             mean_case_averted_per_1000 = (reduction_in_cases/population) * 1000,
             relative_reduction_in_cases = relative_reduction_cases,
             mean_case_per_person_per_year_across_3_years = reduction_in_cases/population,
             stringsAsFactors = FALSE)
  
  
}
