#!/usr/bin/env Rscript

##############################################

## remove the old file

setwd(dest)
if(file.exists("diagnostics-pat.txt")) file.remove("diagnostics-pat.txt") 

##############################################

## FILE diagnostics-pat.txt gets the following:

toc <- c("DIAGNOSTICS FOR PATENTS:", "  1. Data structure", 
         "  2. Missing observations", 
         "  3. Period covered", 
         "  4.1 Patent distribution, by GCCSA", 
         "  4.2 Top 15 SA3 locations", 
         "  4.3 Patent type structure")
cat(toc, file="diagnostics-pat.txt", sep="\n",append=TRUE)

## 1. Data structure
out <- c("\n", "1. Data structure:", capture.output(str(dat.pat))) ## structure of dat.pat
cat(out, file="diagnostics-pat.txt", sep="\n",append=TRUE)

## 2. Missing observations
i <- length(which(is.na(dat.pat$sa3_code)))
j <- length(which(!is.na(dat.pat$sa3_code)))
k <- round(i/(i+j)*100, 1)
out <- c("\n\n", 
          "2. Missing observations:", "\n", 
          "Missing SA3s = ", i, "\n", 
          "Missing SA3s = ", k, "% of total", "\n")
cat(out, file="diagnostics-pat.txt", sep="",append=TRUE)

## 3. Period covered (years)
out <- c("\n", "3. Period covered (years):", capture.output(unique(dat.pat$cal_year))) ## years covered in dat.pat
cat(out, file="diagnostics-pat.txt", sep="\n",append=TRUE)

##############################################

## 4.1 Distribution of patents by GCCSA (averaged across years)
i <- aggregate(pat_count ~ cal_year + gcc_name, dat.pat, FUN=sum, na.rm=TRUE)
j <- aggregate(pat_count ~ cal_year, dat.pat, FUN=sum, na.rm=TRUE)
out <- merge(x=i, y=j, by="cal_year", all=TRUE)
names(out) <- c("cal_year", "gcc_name", "pat_count", "pat_australia") ## replace names

pc_share_of_total <- round(out$pat_count/out$pat_australia*100, 1)
out <- cbind(out, pc_share_of_total)

out <- aggregate(cbind(pat_australia, pat_count, pc_share_of_total) ~ gcc_name, out, FUN=mean, na.rm=TRUE) ## use out!
out <- out[order(-out$pc_share_of_total), c(1,3,2,4)] ## sort descending and reorder columns
row.names(out) <- NULL

## ..export
sink(file="diagnostics-pat.txt", append=TRUE)
cat(c("\n\n", "4.1 Distribution of patents by GCCSA (averaged across years):", "\n"), sep="")
print(out)

## 4.2 Distribution of patents by SA3 (Top 30, averaged across years)
out <- aggregate(pat_count ~ sa3_code + cal_year, dat.pat, FUN=sum, na.rm=TRUE)
out <- aggregate(pat_count ~ sa3_code, out, FUN=mean, na.rm=TRUE) ## use out, average across years

out <- merge(x=asgs.sa, y=out, by="sa3_code", all=FALSE)
out <- out[order(-out$pat_count), ] ## sort descending and reorder columns
out <- out[1:30, ]
out <- subset(out, select=c(sa3_name, sa4_name, gcc_name, pat_count))
row.names(out) <- NULL

## ..export
sink(file="diagnostics-pat.txt", append=TRUE)
cat(c("\n\n", "4.2 Distribution of patents by SA3 (top 30, averaged across years):", "\n"), sep="")
print(out)

##############################################

## 4.3 Patent types by frequency

pat.type <- data.frame(table(unlist(dat.pat$patent_type)))
pat.type <- pat.type[order(-pat.type$Freq), ]
row.names(pat.type) <- NULL

out <- sum(pat.type$Freq)
pc_share_of_total <- round(pat.type$Freq/out*100, 1)
out <- cbind(pat.type, pc_share_of_total)
names(out) <- c("patent_type", "frequency", "pc_share_of_total")

out <- c("\n", "4.3 Patent type structure (all years, all locations): ", capture.output(out))
cat(out, file="diagnostics-pat.txt", sep="\n",append=TRUE)

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
