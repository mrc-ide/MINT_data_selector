
speed_checker_auto <- function(function_to_test, runs, malaria_array, unique_data){

  sapply(1:runs, function(n){
    
    #Randomly select data for all possible arguments
    type <- sample(c("prev", "inc"), 1, replace = TRUE)
    resistance <- sample(unique_data[[1]], 1, replace = TRUE)
    bound <- sample(unique_data[[2]], 1, replace = TRUE)
    season <- sample(unique_data[[3]], 1, replace = TRUE)
    endemicity <- sample(unique_data[[4]], 1, replace = TRUE)
    phi <- sample(unique_data[[5]], 1, replace = TRUE)
    Q0 <- sample(unique_data[[6]], 1, replace = TRUE)
    nets <- sample(unique_data[[7]], 1, replace = TRUE)
    sprays <- sample(unique_data[[8]], 1, replace = TRUE)
    switch_nets <- sample(unique_data[[9]], 1, replace = TRUE)
    switch_irs <- sample(unique_data[[10]], 1, replace = TRUE)
    NET_type <- sample(unique_data[[11]], 1, replace = TRUE)
    population <- sample(1:10000000, 1, replace = TRUE)
    itn_base_cost <- sample(1:50, 1, replace = TRUE)
    itn_pbo_cost <- sample(1:50, 1, replace = TRUE)
    itn_dist_cost <- sample(1:50, 1, replace = TRUE)
    irs_cost <- sample(1:50, 1, replace = TRUE)
    
    system.time(function_to_test(malaria_array, type, resistance, bound, season, endemicity, 
                                 phi, Q0, nets, sprays,
                                 switch_nets, switch_irs, NET_type, population, 
                                 itn_base_cost, itn_pbo_cost,
                                 itn_dist_cost, irs_cost))
    
  })
  
}
