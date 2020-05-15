
data_format_table_graph <- function(malaria_array, all_interventions_df, 
                                    type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                                    switch_nets, switch_irs, NET_type, ...){
  
  do.call(rbind, sapply(1:nrow(all_interventions_df), function(x){
    
    cbind(data.frame(intervention = all_interventions_df[x, ]$intervention, stringsAsFactors = FALSE),
          as.data.frame(t(data_selector(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                                        switch_nets = all_interventions_df[x, ]$switch_nets, 
                                        switch_irs = all_interventions_df[x, ]$switch_irs, 
                                        NET_type = all_interventions_df[x, ]$NET_type))))
    
  }, simplify = FALSE))
  
  
}
