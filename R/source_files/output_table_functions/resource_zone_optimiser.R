
resource_zone_optimiser <- function(zone_df, itn_base_cost, itn_pbo_cost, itn_dist_cost){
  

  intervention_coverage <- expand.grid(net_coverage = c(0.0, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 0.9, 1.0), 
                                       irs_coverage = 0, stringsAsFactors = FALSE)
  
  all_zones_optimising <- do.call(rbind, sapply(1:nrow(zone_df), function(x){
    
    all_coverages <- do.call(rbind, sapply(1:nrow(intervention_coverage), function(y){
      
      # print(y)
      
      all_interventions <- data.frame(intervention = c("Do nothing",
                                                       "Standard nets only",
                                                       "PBO nets only",
                                                       "IRS only",
                                                       "Standard nets with IRS",
                                                       "PBO nets with IRS"),
                                      switch_nets = c(0, intervention_coverage$net_coverage[y], intervention_coverage$net_coverage[y], 0, intervention_coverage$net_coverage[y], intervention_coverage$net_coverage[y]),
                                      NET_type = c(1, 1, 2, 2, 1, 2),
                                      switch_irs = c(0, 0, 0, intervention_coverage$irs_coverage[y], intervention_coverage$irs_coverage[y], intervention_coverage$irs_coverage[y]),
                                      stringsAsFactors = FALSE)
      
      all_interventions$population <- zone_df$population[x]
      all_interventions$cost <- all_interventions$switch_nets*zone_df$population[x]*c(itn_base_cost, itn_pbo_cost)[all_interventions$NET_type]*itn_dist_cost + all_interventions$switch_irs*zone_df$population[x]*irs_cost
      
      
      output <- data_format_table_graph(malaria_array, 
                                        all_interventions, 
                                        type = "prev", 
                                        resistance = zone_df$resistance[x], 
                                        bound = 2, 
                                        season = zone_df$season[x], 
                                        endemicity = zone_df$endemicity[x], 
                                        phi = zone_df$phi[x], 
                                        Q0 = zone_df$Q0[x], 
                                        nets = zone_df$nets[x], 
                                        sprays = zone_df$sprays[x])
      
      
      #Work out future cases
      by_year <- output[, paste0("month_", 0:47)]
      future_prev_year_mat <- matrix(rowMeans(do.call(rbind, sapply(1:6, function(y) matrix(unlist(by_year[y, ]), ncol = 12), simplify = FALSE))), ncol = 4, byrow = TRUE)
      
      prevalence_3_years <- rowMeans(future_prev_year_mat[, 1:3])
      cases_3_years <- prevalence_3_years*zone_df$population[x]
      
      reduction_in_cases_per_1000 <- ((cases_3_years[1] - cases_3_years)/zone_df$population[x])*1000
      relative_reduction_cases <- 1 - cases_3_years/cases_3_years[1]
      
      z <- data.frame(efficacy = relative_reduction_cases, averted = reduction_in_cases_per_1000)
      z$cost <- all_interventions$cost 
      
      overall_df <- cbind(output[, -which(grepl("month", colnames(output)))], z)
      overall_df <- overall_df[which(overall_df$efficacy == max(overall_df$efficacy)), ]
      overall_df$zone <- x
      overall_df
      
    }, simplify = FALSE))
    
    all_coverages[which(all_coverages$efficacy == max(all_coverages$efficacy)), ]
    
  }, simplify = FALSE))
  
  
  knapsack(w = all_zones_optimising$cost, 
           p = all_zones_optimising$efficacy,
           cap = 10000)
  
  
}
