#!/usr/bin/env Rscript

##############################################

## remove the old file

setwd(dest)
if(file.exists("diagnostics-tm.txt")) file.remove("diagnostics-tm.txt") 

##############################################

## FILE diagnostics-tm.txt gets the following:

toc <- c("DIAGNOSTICS FOR TRADEMARKS:", "  1. Data structure", 
         "  2. Missing observations", 
         "  3. Period covered", 
         "  4.1 Trademark distribution, by GCCSA", 
         "  4.2 Top 15 SA3 locations", 
         "  4.3 Trademark type structure",
         "  4.4 Trademark purpose by frequency")
cat(toc, file="diagnostics-tm.txt", sep="\n",append=TRUE)

## 1. Data structure
out <- c("\n", "1. Data structure:", capture.output(str(dat.tm))) ## structure of dat.tm
cat(out, file="diagnostics-tm.txt", sep="\n",append=TRUE)

## 2. Missing observations
i <- length(which(is.na(dat.tm$sa3_code)))
j <- length(which(!is.na(dat.tm$sa3_code)))
k <- round(i/(i+j)*100, 1)
out <- c("\n\n", 
          "2. Missing observations:", "\n", 
          "Missing SA3s = ", i, "\n", 
          "Missing SA3s = ", k, "% of total", "\n")
cat(out, file="diagnostics-tm.txt", sep="",append=TRUE)

## 3. Period covered (years)
out <- c("\n", "3. Period covered (years):", capture.output(unique(dat.tm$cal_year))) ## years covered in dat.tm
cat(out, file="diagnostics-tm.txt", sep="\n",append=TRUE)

##############################################

## 4.1 Distribution of trademarks by GCCSA (averaged across years)
i <- aggregate(tm_count ~ cal_year + gcc_name, dat.tm, FUN=sum, na.rm=TRUE)
j <- aggregate(tm_count ~ cal_year, dat.tm, FUN=sum, na.rm=TRUE)
out <- merge(x=i, y=j, by="cal_year", all=TRUE)
names(out) <- c("cal_year", "gcc_name", "tm_count", "tm_australia") ## replace names

pc_share_of_total <- round(out$tm_count/out$tm_australia*100, 1)
out <- cbind(out, pc_share_of_total)

out <- aggregate(cbind(tm_australia, tm_count, pc_share_of_total) ~ gcc_name, out, FUN=mean, na.rm=TRUE) ## use out!
out <- out[order(-out$pc_share_of_total), c(1,3,2,4)] ## sort descending and reorder columns
row.names(out) <- NULL

## ..export
sink(file="diagnostics-tm.txt", append=TRUE)
cat(c("\n\n", "4.1 Distribution of trademarks by GCCSA (averaged across years):", "\n"), sep="")
print(out)

## 4.2 Distribution of trademarks by SA3 (Top 30, averaged across years)
out <- aggregate(tm_count ~ sa3_code + cal_year, dat.tm, FUN=sum, na.rm=TRUE)
out <- aggregate(tm_count ~ sa3_code, out, FUN=mean, na.rm=TRUE) ## use out, average across years

out <- merge(x=asgs.sa, y=out, by="sa3_code", all=FALSE)
out <- out[order(-out$tm_count), ] ## sort descending and reorder columns
out <- out[1:30, ]
out <- subset(out, select=c(sa3_name, sa4_name, gcc_name, tm_count))
row.names(out) <- NULL

## ..export
sink(file="diagnostics-tm.txt", append=TRUE)
cat(c("\n\n", "4.2 Distribution of trademarks by SA3 (top 30, averaged across years):", "\n"), sep="")
print(out)

##############################################

## 4.3 Trademark types by frequency

tm.type <- data.frame(table(unlist(dat.tm$tm_type)))
tm.type <- tm.type[order(-tm.type$Freq), ]
row.names(tm.type) <- NULL

out <- sum(tm.type$Freq)
pc_share_of_total <- round(tm.type$Freq/out*100, 1)
out <- cbind(tm.type, pc_share_of_total)
names(out) <- c("trademark_type", "frequency", "pc_share_of_total")

out <- c("\n", "4.3 Trademark type structure (all years, all locations): ", capture.output(out))
cat(out, file="diagnostics-tm.txt", sep="\n",append=TRUE)

##############################################

## 4.4 Trademark purpose by frequency

tm.purpose <- data.frame(table(unlist(dat.tm$tm_purpose)))
tm.purpose <- tm.purpose[order(-tm.purpose$Freq), ]
row.names(tm.purpose) <- NULL

out <- sum(tm.purpose$Freq)
pc_share_of_total <- round(tm.purpose$Freq/out*100, 1)
out <- cbind(tm.purpose, pc_share_of_total)
names(out) <- c("trademark_purpose", "frequency", "pc_share_of_total")

out <- c("\n", "4.4 Trademark purpose structure (all years, all locations): ", capture.output(out))
cat(out, file="diagnostics-tm.txt", sep="\n",append=TRUE)

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
