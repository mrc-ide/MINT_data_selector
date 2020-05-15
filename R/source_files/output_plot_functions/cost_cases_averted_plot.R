
cost_efficacy_plot <- function(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                               switch_nets, switch_irs, NET_type, intervention, population, itn_base_cost, itn_pbo_cost,
                               itn_dist_cost, irs_cost){
  
  cost_cases_df <- cost_effectiveness_data_extractor(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                                                     switch_nets, switch_irs, NET_type, intervention, population, itn_base_cost, itn_pbo_cost,
                                                     itn_dist_cost, irs_cost)
  
  ggplot() + geom_point(data = cost_cases_df, aes(x = bound_2_averted,
                                                  y = total_cost,
                                                  color = intervention), size = 4,
                        alpha = 0.5) +
    theme_minimal() + labs(x = "Cases averted", y = "Total cost ($10,000 USD)", color = "") +
    theme(legend.position = "bottom") +
    geom_errorbar(data = cost_cases_df, aes(y = total_cost,
                                            xmin = bound_1_averted,
                                            xmax = bound_3_averted,
                                            color = intervention), width = 0, size = 2,
                  alpha = 0.5)
  
  
}