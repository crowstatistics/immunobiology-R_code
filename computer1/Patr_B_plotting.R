# Here we looked at Patr B binders (Patr are MHC from chimpansees) 
# ----------------------------------------------------------------------

# needed for some functions
source("~/bachelor_universiteit/Immunobiologie/Computer_1/allotype_calculate_functions.R")

file_B0201<-"C:/Users/rober/Documents/bachelor_universiteit/Immunobiologie/Computer_1/Patr_B0201_NetMHCpan.xls"
Patr_B0201_table <- read.table(file=file_B0201,sep="\t",skip=1,header=TRUE,stringsAsFactors = FALSE)

# calculate binders of B*0201
B0201_binders <- calculate_binders(data=Patr_B0201_table)

file_B0301<-"C:/Users/rober/Documents/bachelor_universiteit/Immunobiologie/Computer_1/Patr_B0301_NetMHCpan.xls"
Patr_B0301_table <- read.table(file=file_B0301,sep="\t",skip=1,header=TRUE,stringsAsFactors = FALSE)

# calculate binders of B*0301
B0301_binders <- calculate_binders(data=Patr_B0301_table)

# we assume number of peptides is same for both allotypes (looked at same proteins)
# of course the binders are different
expected_binders <- calculate_expected_peptides(data=Patr_B0201_table)

# Patr_B_binders combine the matrices of binders of B*0201 and B*0301 in one matrix 
Patr_B_binders <- matrix(ncol=length(unique(Patr_B0201_table$ID)),nrow=3)

Patr_B_binders[1,] <- B0201_binders # binders of B0201
Patr_B_binders[2,] <- B0301_binders # binders of B0301
Patr_B_binders[3,] <- expected_binders # the expected binders

# here comes the barplot

# assuming B*0201 and B*0301 have the same unique proteins
proteins <-  unique(Patr_B0201_table$ID)

barplot(Patr_B_binders
        ,names.arg=proteins,col=c("red","blue","green")
        ,beside=TRUE,ylim=c(0,40),ylab="number of binders",xlab="proteins")

legend(x=8,y=39,legend=c("found B*5703","found B*1801","expected"),bty="n",fill=c("red","blue","green"))

