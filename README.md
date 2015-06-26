get_names.pl -- scrape OperaBase to get a list of singer names
get_roles.pl -- given those names, scrape OB to get the roles they performed
make_matrix.pl -- make a graph where vertex = role, edge = a singer performed both those roles (with thresholds on co-occurence count)
make_singer_matrix.pl -- make a matrix where rows = singers, cols = roles, 0 or 1 depending on whether role performed
make_singer_vector.pl -- given that matrix and a list of roles performed by a singer, generate a vector of 0/1 that has the same dimensions as the matrix
read_singer_vector.pl -- given a reduced singer vector output from R and the singer matrix, generate a readable sorted list of roles and scores
