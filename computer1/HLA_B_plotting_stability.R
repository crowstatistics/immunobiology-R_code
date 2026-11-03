# Here we looked at HLA B stable proteins
# 

# needed for some functions
source("~/bachelor_universiteit/Immunobiologie/Computer_1/allotype_calculate_functions.R")

file_B5703<-"C:/Users/rober/Documents/bachelor_universiteit/Immunobiologie/Computer_1/HLA_B5703_NetMHCstabpan.xls"
HLA_B5703_table <- read.table(file=file_B5703,sep="\t",skip=1,header=TRUE,stringsAsFactors = FALSE)

# calculate stable of B*5703
B5703_stable <- calculate_stable_proteins(data=HLA_B5703_table)

file_B1801<-"C:/Users/rober/Documents/bachelor_universiteit/Immunobiologie/Computer_1/HLA_B1801_NetMHCstabpan.xls"
HLA_B1801_table <- read.table(file=file_B1801,sep="\t",skip=1,header=TRUE,stringsAsFactors = FALSE)

# calculate stable of B*1801
B1801_stable <- calculate_stable_proteins(data=HLA_B1801_table)

# we assume number of peptides is same for both allotypes (looked at same proteins)
# of course the stable are different
expected_stable_proteins <- calculate_expected_peptides(data=HLA_B5703_table)

# HLA_B stable combine the matrices of stable of B*5703 and B*1801 in one matrix 
HLA_B_stable <- matrix(ncol=length(unique(HLA_B5703_table$ID)),nrow=3)

HLA_B_stable[1,] <- B5703_stable # stable of B5703
HLA_B_stable[2,] <- B1801_stable # stable of B1801
HLA_B_stable[3,] <- expected_stable_proteins # the expected stable

# here comes the barplot

# assuming B*5703 and B*1801 have the same unique proteins
proteins <-  unique(HLA_B5703_table$ID)

barplot(HLA_B_stable
        ,names.arg=proteins,col=c("red","blue","green")
        ,beside=TRUE,ylim=c(0,12),ylab="number of stable peptides",xlab="proteins")

legend(x=12,y=12,legend=c("found B*5703","found B*1801","expected"),bty="n",fill=c("red","blue","green"))

