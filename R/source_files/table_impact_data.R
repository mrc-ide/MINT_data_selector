
table_impact_data <- function(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                              switch_nets, switch_irs, NET_type, intervention, population){
  
  data_here <- data_selector(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                switch_nets, switch_irs, NET_type)
  
  data.frame()
  
  
}


# 
# 
# {"intervention": "none", "net_use": 0, "irs_use": 0, 
#   "cases_averted": 500, "prev_year_1": 0.5208, 
#   "prev_year_2": 0.1697, "prev_year_3": 0.4863}
