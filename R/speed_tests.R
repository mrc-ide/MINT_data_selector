library(ggplot2)

load_functions <- list.files("R/source_files", full.names = TRUE, recursive = TRUE)
invisible(sapply(load_functions, function(x) source(x)))

load("data/malaria_array_all_data_prev_1_inc_2.Rdata")

clean_functions <- gsub("R/source_files/|data_extract_functions/|output_plot_functions/|.R|output_table_functions/", 
                        "", load_functions)

#Remove the most baseline functions
clean_functions <- clean_functions[-which(clean_functions %in% c("data_format_table_graph",
                                                                 "mat_find_quick",
                                                                 "speed_checker_auto"))]

#Generate dummy data
unique_data <- sapply(1:11, function(x){
  unique(malaria_array_all_data_prev_1_inc_2[, x, 1])
}, simplify = FALSE)

#Run through all functions
time1 <- Sys.time()
all_function_speeds <- sapply(clean_functions, function(x){
  print(x)
  rowMeans(speed_checker_auto(get(x), 50, malaria_array_all_data_prev_1_inc_2, unique_data), na.rm = TRUE)
})
time2 <- Sys.time()
time2-time1




data_format_table_graph



#Run through a 1000 options
set.seed(1)

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
















