#!/usr/bin/env Rscript

##############################################

## export CSV

setwd(dest)
write.table(df.all, "full-dataset-all-indicators.csv", sep = ",", row.names = FALSE)
write.table(filt.df, "regional-subset-all-indicators.csv", sep = ",", row.names = FALSE)
write.table(filt.drop, "excluded-from-regional-subset.csv", sep = ",", row.names = FALSE)

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
