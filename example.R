fachme_g <- read.csv("c:\\cygwin64\\home\\katia\\play\\opera_clusters\\fachme_data\\matrix_names.txt", sep="\t", header=TRUE)
fachme_s <- svd(as.matrix(fachme_g))
km <- read.csv("c:\\cygwin64\\home\\katia\\play\\opera_clusters\\katia_fachme_with_header.txt", sep="\t", header=T)
write.table(fachme_s$v, file="c:\\cygwin64\\home\\katia\\play\\opera_clusters\\fachme_data\\names_v_matrix.txt", sep="\t", col.names=FALSE)
# in shell add a header line to names_v_matrix.txt. the header line is the 1st line of matrix_names.txt
try <- read.csv("c:\\cygwin64\\home\\katia\\play\\opera_clusters\\fachme_data\\names_v_matrix_with_header.txt", sep="\t", header=TRUE)
tryk <- t(try[,1:25])
trykT <- t(tryk)
katia_res <- as.matrix(km) %*% trykT %*% tryk
