
# needed for some functions
source("~/bachelor_universiteit/Immunobiologie/R_dependencies/write_cross_reactive_pairs_table.R")

# files needed to import data
file_netMHC <- "~/bachelor_universiteit/Immunobiologie/poster/corona_NetMHCpan.xls"
cross_reactive_pairs_file <- "~/bachelor_universiteit/Immunobiologie/poster/corona_cross_reactive_pairs.csv"

# writing a csv table
write_cross_reactive_pairs_table(input_file = file_netMHC,
                                 output_file = cross_reactive_pairs_file)



