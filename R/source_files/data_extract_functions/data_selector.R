#This function returns the row of the array that corresponds to the selected inputs

#Malaria array refers to malaria_array_all_data_prev_1_inc_2.Rdata
#The other inputs are those selected in the interface

data_selector <- function(malaria_array, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                          switch_nets, switch_irs, NET_type){
  
  malaria_array[mat_find_quick(match_mat = malaria_array[, 1:11, ifelse(type == "prev", 1, 2)], 
                      match_vec = c(resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                            switch_nets, switch_irs, NET_type)), ,ifelse(type == "prev", 1, 2)]
  
}
