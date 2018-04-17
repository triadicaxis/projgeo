#!/usr/bin/env Rscript

##############################################

## remove the old file

setwd(dest)
if(file.exists("diagnostics-pop.txt")) file.remove("diagnostics-pop.txt")

##############################################

## FILE diagnostics-pop.txt gets the following:

toc <- c("DIAGNOSTICS FOR POPULATION:", "  1. Data structure", 
         "  2. Period covered", 
         "  3. Missing observations",
         "  4. Distribution by GCCSA, by year")
cat(toc, file="diagnostics-pop.txt", sep="\n",append=TRUE)

## ..1. Data structure
out <- c("\n", "1. Data structure:", capture.output(str(dat.pop)))
cat(out, file="diagnostics-pop.txt", sep="\n",append=TRUE)

## ..2. Period covered
out <- c("\n", "2. Period covered (years):", capture.output(unique(dat.pop$fin_year))) ## years covered in dat.pop
cat(out, file="diagnostics-pop.txt", sep="\n",append=TRUE)

## ..3. Missing observations
i <- length(which(is.na(dat.pop$pop_count)))
j <- length(which(!is.na(dat.pop$pop_count)))
k <- round(i/(i+j)*100, 1)
out <- c("\n\n", 
          "3. Missing observations:", "\n", 
          "Missing pop info = ", i, "\n", 
          "Missing pop info = ", k, "% of total", "\n")
cat(out, file="diagnostics-pop.txt", sep="",append=TRUE)

## ..4. Distribution of population by GCCSA (averaged across years)
i <- aggregate(pop_count ~ fin_year + gcc_name, dat.pop, FUN=sum, na.rm=TRUE)
j <- aggregate(pop_count ~ fin_year, dat.pop, FUN=sum, na.rm=TRUE)
out <- merge(x=i, y=j, by="fin_year")
names(out) <- c("fin_year", "gcc_name", "pop_count", "pop_australia") ## give proper names to all vars

share_of_total <- round(out$pop_count/out$pop_australia*100, 1)
out <- cbind(out, share_of_total)

## ..average across years
out <- aggregate(cbind(pop_australia, pop_count, share_of_total) ~ gcc_name, out, FUN=mean, na.rm=TRUE) ## use out!
out <- out[order(-out$share_of_total), c(1,3,2,4)] ## sort descending and reorder columns
row.names(out) <- NULL

sink(file="diagnostics-pop.txt", append=TRUE)
cat(c("\n\n", "4. Distribution of population by GCCSA (averaged across years):", "\n"), sep="")
print(out)

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
