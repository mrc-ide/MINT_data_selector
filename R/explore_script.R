library(ggplot2)

invisible(sapply(list.files("R/source_files", full.names = TRUE), function(x) source(x)))

load("data/malaria_array_all_data_prev_1_inc_2.Rdata")

#Test function
system.time(data_selector(malaria_array_all_data_prev_1_inc_2,
                          type = "prev",
                          resistance = 20,
                          bound = 2,
                          season = 2,
                          endemicity = 0.6,
                          phi = 0.97,
                          Q0 = 0.92,
                          nets = 0.8,
                          sprays = 0,
                          switch_nets = 0.4,
                          switch_irs = 0,
                          NET_type = 1))


#Test on random things
unique_data <- sapply(1:11, function(x){
  unique(malaria_array_all_data_prev_1_inc_2[, x, 1])
}, simplify = FALSE)

#Run through a 1000 options
set.seed(1)

#Create dummy data
type <- sample(c("prev", "inc"), 1000, replace = TRUE)
resistance <- sample(unique_data[[1]], 1000, replace = TRUE)
bound <- sample(unique_data[[2]], 1000, replace = TRUE)
season <- sample(unique_data[[3]], 1000, replace = TRUE)
endemicity <- sample(unique_data[[4]], 1000, replace = TRUE)
phi <- sample(unique_data[[5]], 1000, replace = TRUE)
Q0 <- sample(unique_data[[6]], 1000, replace = TRUE)
nets <- sample(unique_data[[7]], 1000, replace = TRUE)
sprays <- sample(unique_data[[8]], 1000, replace = TRUE)
switch_nets <- sample(unique_data[[9]], 1000, replace = TRUE)
switch_irs <- sample(unique_data[[10]], 1000, replace = TRUE)
NET_type <- sample(unique_data[[11]], 1000, replace = TRUE)


all_times_go <- sapply(1:1000, function(y){
  print(y)
  
  system.time(data_selector(
    malaria_array_all_data_prev_1_inc_2,
    type[y], 
    resistance[y],
    bound[y],
    season[y],
    endemicity[y],
    phi[y],
    Q0[y],
    nets[y],
    sprays[y],
    switch_nets[y],
    switch_irs[y],
    NET_type[y]))
  
})



malaria_array = malaria_array_all_data_prev_1_inc_2
type <- sample(c("prev", "inc"), 1, replace = TRUE)
resistance <- sample(unique_data[[1]], 1, replace = TRUE)
bound <- 2#sample(unique_data[[2]], 1, replace = TRUE)
season <- sample(unique_data[[3]], 1, replace = TRUE)
endemicity <- sample(unique_data[[4]], 1, replace = TRUE)
phi <- sample(unique_data[[5]], 1, replace = TRUE)
Q0 <- sample(unique_data[[6]], 1, replace = TRUE)
nets <- sample(unique_data[[7]], 1, replace = TRUE)
sprays <- sample(unique_data[[8]], 1, replace = TRUE)
switch_nets <- sample(unique_data[[9]], 1, replace = TRUE)
switch_irs <- sample(unique_data[[10]], 1, replace = TRUE)
NET_type <- sample(unique_data[[11]], 1, replace = TRUE)



y = 1
system.time(table_impact_data(malaria_array_all_data_prev_1_inc_2,
                  type[y], 
                  resistance[y],
                  bound[y],
                  season[y],
                  endemicity[y],
                  phi[y],
                  Q0[y],
                  nets[y],
                  sprays[y],
                  switch_nets[y],
                  switch_irs[y],
                  NET_type[y],
                  population = 1000))



# NET_TYPE
# Intervention 1: switch_nets = 0 & switch_irs = 0
# Intervention 2: switch_nets = user & NET_type = 1 & switch_irs = 0
# Intervention 3: switch_nets = user & NET_type = 2 & switch_irs = 0
# Intervention 4: switch_nets = 0 & NET_type = 2 & switch_irs = user
# Intervention 5: switch_nets = user & NET_type = 1 & switch_irs = user
# Intervention 6: switch_nets = user & NET_type = 2 & switch_irs = user

# Names
# Intervention 1 = Do nothing
# Intervention 2 = Standard nets only
# Intervention 3 = PBO nets only
# Intervention 4 = IRS only
# Intervention 5 = Standard nets with IRS
# Intervention 6 = PBO nets with IRS


