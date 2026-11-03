
# this function calculate the binder based on a threshold
#---------------------------------------------------------------------
calculate_binders <- function(data,threshold=1) {
  
  proteins <- unique(data$ID)
  
  # vector with number of binder for each protein
  binders <- numeric(length(proteins)) 
  index <- 0
  for (i in proteins) {
    
    index <- index+1
    
    # Calculate the number of binders of all proteins in the data with EL rank lower or equal to threshold.
    binders[index] <- sum(data$ID == i & data$EL_Rank<=threshold)

  }
  
  binder_matrix <- matrix(binders, ncol=length(proteins),nrow=1, byrow=TRUE)
  
  return(binder_matrix)

}

calculate_expected_peptides <- function(data,threshold=1) {
  
  proteins <- unique(data$ID)
  
  # vector with number of peptides for each protein
  peptides <- numeric(length(proteins))
  index <- 0
  for (i in proteins) {
    
    index <- index+1
    
    # Calculate the number of peptides of each protein.
    peptides[index] <- sum(data$ID == i)

  }
    
    # Calculate the expected value of the number of binders with EL rank lower or equal to threshold. 
    expected <- as.integer(threshold*peptides/100)
    
    expected_matrix <- matrix(expected, ncol=length(proteins),nrow=1, byrow=TRUE)
    
    return(expected_matrix)
  
}

calculate_stable_proteins <- function(data,threshold=1) {
  
  proteins <- unique(data$ID)
  
  Threshold <- 1
  
  # vector with number of binder for each protein
  stable_proteins <- numeric(length(proteins)) 
  index <- 0
  for (i in proteins) {
    
    index <- index+1
    
    # Calculate the number of stable of all proteins in the data with EL rank lower or equal to threshold.
    stable_proteins[index] <- sum(data$ID == i & data$Rank<=threshold)
    
  }
  
  stability_matrix <- matrix(stable_proteins, ncol=length(proteins),nrow=1, byrow=TRUE)
  
  return(stability_matrix)
  
}