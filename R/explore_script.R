#####################################################################
####                                                             ####
#### This is messy and mainly just me playing around with things ####
####                                                             ####  
#####################################################################


library(ggplot2)

invisible(sapply(list.files("R/source_files", full.names = TRUE, recursive = TRUE), function(x) source(x)))

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



#Get the unique values of each column to generate dummy data
unique_data <- sapply(1:11, function(x){
  unique(malaria_array_all_data_prev_1_inc_2[[1]][, x, 1])
}, simplify = FALSE)

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


zone_df <- data.frame(zone_id = 1:3,
                      resistance = sample(unique_data[[1]], 3, replace = TRUE),
                      season = sample(unique_data[[3]], 3, replace = TRUE),
                      endemicity = sample(unique_data[[4]], 3, replace = TRUE),
                      phi = sample(unique_data[[5]], 3, replace = TRUE),
                      Q0 = sample(unique_data[[6]], 3, replace = TRUE),
                      nets = sample(unique_data[[7]], 3, replace = TRUE),
                      sprays = sample(unique_data[[8]], 3, replace = TRUE),
                      stringsAsFactors = FALSE)


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

system.time(prevalence_time_plot(malaria_array_all_data_prev_1_inc_2,
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

system.time(cases_averted_barplot(malaria_array_all_data_prev_1_inc_2,
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
                                 population = 100))




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

table_impact_data(
  malaria_array = malaria_array_all_data_prev_1_inc_2,
  type = "prev",
  resistance = 60,
  bound = 2,
  season = 1,
  endemicity = .6,
  phi = .97,
  Q0 = .74,
  nets = .6,
  sprays = 0,
  switch_nets = 0.5,
  switch_irs = 0,
  NET_type = 2,
  population = 1000
)




itn_base_cost = 1.5
itn_pbo_cost = 2.5
itn_dist_cost = 2.75
irs_cost = 2.5



