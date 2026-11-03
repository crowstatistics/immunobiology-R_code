# Here we looked at HLA B binders 
# ----------------------------------------------------------------------

# needed for some functions
source("~/bachelor_universiteit/Immunobiologie/Computer_1/allotype_calculate_functions.R")

file_B5703<-"C:/Users/rober/Documents/bachelor_universiteit/Immunobiologie/Computer_1/HLA_B5703_NetMHCpan.xls"
HLA_B5703_table <- read.table(file=file_B5703,sep="\t",skip=1,header=TRUE,stringsAsFactors = FALSE)

# calculate binders of B*5703
B5703_binders <- calculate_binders(data=HLA_B5703_table)

file_B1801<-"C:/Users/rober/Documents/bachelor_universiteit/Immunobiologie/Computer_1/HLA_B1801_NetMHCpan.xls"
HLA_B1801_table <- read.table(file=file_B1801,sep="\t",skip=1,header=TRUE,stringsAsFactors = FALSE)

# calculate binders of B*1801
B1801_binders <- calculate_binders(data=HLA_B1801_table)

# we assume number of peptides is same for both allotypes (looked at same proteins)
# of course the binders are different
expected_binders <- calculate_expected_peptides(data=HLA_B5703_table)

# HLA_B_binders combine the matrices of binders of B*5703 and B*1801 in one matrix 
HLA_B_binders <- matrix(ncol=length(unique(HLA_B5703_table$ID)),nrow=3)

HLA_B_binders[1,] <- B5703_binders # binders of B5703
HLA_B_binders[2,] <- B1801_binders # binders of B1801
HLA_B_binders[3,] <- expected_binders # the expected binders

# here comes the barplot

# assuming B*5703 and B*1801 have the same unique proteins
proteins <-  unique(HLA_B5703_table$ID)

barplot(HLA_B_binders
        ,names.arg=proteins,col=c("red","blue","green")
        ,beside=TRUE,ylim=c(0,30),ylab="number of binders",xlab="proteins"
        ,)

legend(x=13,y=30,legend=c("found B*5703","found B*1801","expected"),bty="n",fill=c("red","blue","green"))
