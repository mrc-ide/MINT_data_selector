# type = "prev"
# resistance = "20"
# bound = ""
# season = "2"
# endemicity = "0.60"
# phi = "0.97"
# Q0 = "0.92"
# nets = "0.8"
# sprays = "0.0"
# switch_nets = "0.4"
# switch_irs = "0"
# NET_type = "1"


data_selector <- function(data, type, resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                          switch_nets, switch_irs, NET_type){
  
    data[mat_find_quick(data[, 1:length(find_vec), ifelse(type == "prev", 1, 2)], 
                   c(resistance, bound, season, endemicity, phi, Q0, nets, sprays,
                     switch_nets, switch_irs, NET_type)), ,ifelse(type == "prev", 1, 2)]
  
}


