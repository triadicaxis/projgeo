#!/usr/bin/env Rscript

##############################################

## remove the old file

setwd(dest)
if(file.exists("diagnostics-rnd.txt")) file.remove("diagnostics-rnd.txt") 

##############################################

## FILE diagnostics-rnd.txt gets the following:

toc <- c("DIAGNOSTICS FOR R&D SPEND:", "  1. Data structure", 
         "  2. Missing observations", 
         "  3. Period covered", 
         "  4.1 R&D spend distribution, by GCCSA", 
         "  4.2 Top 15 SA3 locations")
cat(toc, file="diagnostics-rnd.txt", sep="\n",append=TRUE)

## 1. Data structure
out <- c("\n", "1. Data structure:", capture.output(str(dat.rnd))) ## structure of dat.rnd
cat(out, file="diagnostics-rnd.txt", sep="\n",append=TRUE)

## 2. Missing observations
i <- length(which(is.na(dat.rnd$sa3_code)))
j <- length(which(!is.na(dat.rnd$sa3_code)))
k <- round(i/(i+j)*100, 1)
out <- c("\n\n", 
          "2. Missing observations:", "\n", 
          "Missing SA3s = ", i, "\n", 
          "Missing SA3s = ", k, "% of total", "\n")
cat(out, file="diagnostics-rnd.txt", sep="",append=TRUE)

## 3. Period covered (years)
out <- c("\n", "3. Period covered (years):", capture.output(unique(dat.rnd$fin_year))) ## years covered in dat.rnd
cat(out, file="diagnostics-rnd.txt", sep="\n",append=TRUE)

##############################################

## 4.1 Distribution of R&D spend by GCCSA (averaged across years)
i <- aggregate(rnd_spend ~ fin_year + gcc_name, dat.rnd, FUN=sum, na.rm=TRUE)
j <- aggregate(rnd_spend ~ fin_year, dat.rnd, FUN=sum, na.rm=TRUE)
out <- merge(x=i, y=j, by="fin_year", all=TRUE)
names(out) <- c("fin_year", "gcc_name", "rnd_spend", "rnd_australia") ## replace names

pc_share_of_total <- round(out$rnd_spend/out$rnd_australia*100, 1)
out <- cbind(out, pc_share_of_total)

out <- aggregate(cbind(rnd_australia, rnd_spend, pc_share_of_total) ~ gcc_name, out, FUN=mean, na.rm=TRUE) ## use out!
out <- out[order(-out$pc_share_of_total), c(1,3,2,4)] ## sort descending and reorder columns
row.names(out) <- NULL

## ..export
sink(file="diagnostics-rnd.txt", append=TRUE)
cat(c("\n\n", "4.1 Distribution of R&D spend by GCCSA (averaged across years):", "\n"), sep="")
print(out)

## 4.2 Distribution of R&D spend by SA3 (Top 30, averaged across years)
out <- aggregate(rnd_spend ~ sa3_code + fin_year, dat.rnd, FUN=sum, na.rm=TRUE)
out <- aggregate(rnd_spend ~ sa3_code, out, FUN=mean, na.rm=TRUE) ## use out, average across years

out <- merge(x=asgs.sa, y=out, by="sa3_code", all=FALSE)
out <- out[order(-out$rnd_spend), ] ## sort descending and reorder columns
out <- out[1:30, ]
out <- subset(out, select=c(sa3_name, sa4_name, gcc_name, rnd_spend))
row.names(out) <- NULL

## ..export
sink(file="diagnostics-rnd.txt", append=TRUE)
cat(c("\n\n", "4.2 Distribution of R&D spend by SA3 (top 30, averaged across years):", "\n"), sep="")
print(out)

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
