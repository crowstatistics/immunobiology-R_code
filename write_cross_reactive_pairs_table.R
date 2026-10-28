# Robert de Haas (0954160)
#
# -- Arguments:
# input_file: location of the netMHCpan file
# output_file: location of the output csv file
# sep: seperator to use for the output file
# threshold: this number determines if a peptide pair is a binder, if EL rank is lower
#            than this threshold, then only it is a binder
#
# -- Input:
# a xls file from NetMHCpan where the peptides of cross reactive pairs
# are above each other.
#
# example: if TPSGTWLTY and TLSGTWLTY is a potential cross reactive pair, and
# KIADYNYKL VIADYNYKL is an other pair,
# then you must write in the peptide input of netMHC as follows:
#
# TPSGTWLTY
# TLSGTWLTY
# KIADYNYKL
# VIADYNYKL
#
# -- Output:
# a csv file with for each allotype the peptide pairs that both bind good (EL rank lower than threshold)


# function which write a table of cross reactive pairs from a netMHC file
write_cross_reactive_pairs_table <- function(input_file,
                                             output_file="cross_reactive_pairs.csv",
                                             sep=";",
                                             threshold=1) {
  
  # read netMHC output
  data_netMHC <- read.table(file=input_file,
                            sep="\t",
                            skip=0,
                            header=FALSE,
                            stringsAsFactors = FALSE)
  
  # adjust netMHC output
  data_netMHC_adjusted <- cross_reactive_pair_data_adjustment(data_netMHC)
  
  # final table
  cross_reactive_pairs <- finding_cross_reactive_pairs(data_netMHC_adjusted)
  
  write.table(cross_reactive_pairs,file=output_file,
              sep=sep,row.names=FALSE)
  
  # give a sign that it have written the table
  print(sprintf("Cross reactive pairs table is written in %s",output_file))

}

cross_reactive_pair_data_adjustment <- function(data_netMHC) {

  # take the peptides of pair number 1 and 2
  index1 <- seq.int(from=3,to=nrow(data_netMHC)-1,by=2)
  index2 <- seq.int(from=4,to=nrow(data_netMHC),by=2)
  # take all peptides
  peptides1 <- data_netMHC[index1,2]
  peptides2 <- data_netMHC[index2,2]
  
  # this becomes the allotypes and EL ranks
  unique_allotypes <- c()
  EL_ranks1 <- c()
  EL_ranks2 <- c()
  
  # loop on the allotype
  for (i in 1:ncol(data_netMHC)) {
    
    # take possibly an allotype, because there are also wite spaces
    element_first_row <- data_netMHC[1,i]
    
    # look if the element have HLA- in it
    if (substring(element_first_row,1,4) == "HLA-") {
      
      # paste HLA allotype in unique_allotypes
      unique_allotypes <- c(unique_allotypes, element_first_row)
      
      # take the belonging ranks of both peptides
      ranks1 <- as.numeric(data_netMHC[index1,i+3])
      ranks2 <- as.numeric(data_netMHC[index2,i+3])
      EL_ranks1 <- c(EL_ranks1,ranks1) 
      EL_ranks2 <- c(EL_ranks2,ranks2) 
      
    }
    
  }
  
  # repeat allotype, so each allotype match with every unique peptide pair
  allotypes <- rep(unique_allotypes, each=length(peptides1))
  
  # repeat peptides, so it match for each allotype
  peptides1 <- rep(peptides1, time=length(unique_allotypes))
  peptides2 <- rep(peptides2, time=length(unique_allotypes)) 
  
  data_netMHC_adjusted <- data.frame(allotypes,peptides1,peptides2,EL_ranks1,EL_ranks2)
  
  return(data_netMHC_adjusted)
}

# finding the cross reactive pairs
finding_cross_reactive_pairs <- function(data_netMHC_adjusted,threshold=1) {
  
  # look if EL_rank 1 and EL_rank 2 is smaller than threshold 
  cross_reactive_pairs <- data_netMHC_adjusted[data_netMHC_adjusted$EL_ranks1 <= threshold 
                                               & data_netMHC_adjusted$EL_ranks2 <= threshold,]
  
  return(cross_reactive_pairs)
}

