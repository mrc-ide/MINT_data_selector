
invisible(sapply(list.files("R/source_files", full.names = TRUE), function(x) source(x)))

load("data/malaria_array_all_data_prev_1_inc_2.Rdata")

dimnames(malaria_array_all_data_prev_1_inc_2)
