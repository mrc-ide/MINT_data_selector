#match_mat refers to the matrix subset to the specific columns you want to match
#match_vec refers to the vector of inputs that match a row in the matrix

mat_find_quick <- function(match_mat, match_vec, ...){
  l <- unlist(apply(match_mat, 2, list), recursive = F)
  logic <- mapply(function(x, y) x == y, l, match_vec)
  which(.rowSums(logic, m = nrow(logic), n = ncol(logic)) == ncol(logic))
}