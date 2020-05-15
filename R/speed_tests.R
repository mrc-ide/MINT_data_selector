#####################################################################
####                                                             ####
####   This is just to check the speed of different functions    ####
####                                                             ####  
#####################################################################


library(ggplot2)

#Load in all the functions and the data
load_functions <- list.files("R/source_files", full.names = TRUE, recursive = TRUE)
invisible(sapply(load_functions, function(x) source(x)))
load("data/malaria_array_all_data_prev_1_inc_2.Rdata")

#Clean the function names so they can be called with get
clean_functions <- gsub("R/source_files/|data_extract_functions/|output_plot_functions/|.R|output_table_functions/", 
                        "", load_functions)

#Remove the most baseline functions
clean_functions <- clean_functions[-which(clean_functions %in% c("data_format_table_graph",
                                                                 "mat_find_quick",
                                                                 "speed_checker_auto"))]

#Get the unique values of each column to generate dummy data
unique_data <- sapply(1:11, function(x){
  unique(malaria_array_all_data_prev_1_inc_2[[1]][, x, 2])
}, simplify = FALSE)

#Run through all functions
time1 <- Sys.time()
all_function_speeds <- sapply(clean_functions, function(x){
  
  print(x)
  speed_checker_auto(get(x), 50, malaria_array_all_data_prev_1_inc_2, unique_data)[3, ]
  
})
time2 <- Sys.time()
time2-time1

#Plot
ggplot_speed_df <- data.frame(function_name = rep(colnames(all_function_speeds), each = nrow(all_function_speeds)),
                              time = c(all_function_speeds))

ggplot() + geom_boxplot(data = ggplot_speed_df, 
                        aes(x = function_name, y = time, fill = function_name)) +
  theme_minimal() + labs(x = "", y = "Time (seconds)") + 
  theme(legend.position = "none",
        axis.text.x = element_text(angle = 45, vjust = 0.5))








