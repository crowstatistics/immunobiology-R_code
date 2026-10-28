
calculate_total_freq <- function(N_sym,freq_sym,N_asym,freq_asym) {
  
  N_tot <- N_sym + N_asym
  
  total_freq <- (N_sym*freq_sym + N_asym*freq_asym)/N_tot 
    
  return(total_freq)
}

calculate_odds_ratio <- function(freq_sym,freq_asym) {
  
  oddsratio <- ( freq_asym/(1-freq_asym) ) / ( freq_sym/(1-freq_sym) ) 
  
  return(oddsratio)
}

# take the allotypes who are cross reactive pairs
file_pairs <- "~/bachelor_universiteit/Immunobiologie/poster/corona_cross_reactive_pairs.csv"
cross_reactive_pairs <- read.table(file=file_pairs,sep=";",skip=0,header=TRUE,stringsAsFactors = FALSE)

cross_reactive_allotypes <- unique(cross_reactive_pairs$allotype)

file_Augusto<-"C:/Users/rober/Documents/bachelor_universiteit/Immunobiologie/poster/AugustoSI_allelefrequencies.csv"
Augusto_table <- read.table(file=file_Augusto,sep=",",skip=0,header=TRUE,stringsAsFactors = FALSE)

# make the allotype notation in one column
allotype <- paste(Augusto_table$Locus,Augusto_table$Allele,sep="")

# make allotype in one column
Augusto_table <- cbind(allotype,Augusto_table[c("Symptomatic","Asymptomatic")])

# take only the cross reactive pairs in Augusto table
indices <- which(Augusto_table$allotype %in% cross_reactive_allotypes)

# Augusto table with only the cross reactive pairs 
Augusto_table <- Augusto_table[indices,]

N_sym  <- 1292L
N_asym <- 136L
freq_sym <- Augusto_table$Symptomatic
freq_asym <- Augusto_table$Asymptomatic

allele_freq_tot <- calculate_total_freq(N_sym,freq_sym,N_asym,freq_asym)

odds_ratio <- calculate_odds_ratio(freq_sym,freq_asym)

# make the allotype notation very compact, needed for plot
allotype_compact <- substring( Augusto_table$allotype,5)
allotype_compact <- gsub(pattern=":",replacement="",allotype_compact)

barplot(allele_freq_tot
        ,names.arg=allotype_compact
        , col = "red"
        , ylab = "total frequency")

barplot(odds_ratio
        ,names.arg=allotype_compact
        , col = "blue"
        , ylab = "odds ratio")


