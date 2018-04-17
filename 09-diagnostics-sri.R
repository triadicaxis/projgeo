#!/usr/bin/env Rscript

##############################################

## remove the old file

setwd(dest)
if(file.exists("diagnostics-sri.txt")) file.remove("diagnostics-sri.txt") 

##############################################

## FILE diagnostics-sri.txt gets the following:

toc <- c("DIAGNOSTICS FOR SRIs:", "  1. Data structure",
         "  2. Missing observations", 
         "  3. Distribution of SRIs by SA3", 
         "  4. Frequency of SRIs")
cat(toc, file="diagnostics-sri.txt", sep="\n",append=TRUE)

## .. 1. Data structure
out <- c("\n", "1. Data structure:", capture.output(str(dat.sri)))
cat(out, file="diagnostics-sri.txt", sep="\n",append=TRUE)

## .. 2. Missing observations
i <- length(which(is.na(dat.sri$sa3_code)))
j <- length(which(!is.na(dat.sri$sa3_code)))
k <- round(i/(i+j)*100, 1)
out <- c("\n\n", 
          "2. Missing observations:", "\n", 
          "Missing SA3 = ", i, "\n", 
          "Missing SA3 = ", k, "% of total", "\n")
cat(out, file="diagnostics-sri.txt", sep="",append=TRUE)

##############################################

## 3. Distribution of SRIs by SA3 (across all SA3s)
out <- c("\n", "3.1. Distribution of SRIs across all SA3s:")
cat(out, file="diagnostics-sri.txt", sep="\n",append=TRUE)

uni.main.shr <- sum(df.sri$uni_main_count)/sum(df.sri$total_sri_count)
uni.main.shr <- round(as.numeric(uni.main.shr)*100, 1)
out <- c("Share of UNIs (main campus) in all SA3s = ", uni.main.shr, "% of total", "\n")
cat(out, file="diagnostics-sri.txt", sep="", append=TRUE) ## Unis main campus

uni.other.shr <- sum(df.sri$uni_other_count)/sum(df.sri$total_sri_count)
uni.other.shr <- round(as.numeric(uni.other.shr)*100, 1)
out <- c("Share of UNIs (other campus) in all SA3s = ", uni.other.shr, "% of total", "\n")
cat(out, file="diagnostics-sri.txt", sep="", append=TRUE) ## Unis other campus

csiro.shr <- sum(df.sri$csiro_count)/sum(df.sri$total_sri_count)
csiro.shr <- round(as.numeric(csiro.shr)*100, 1)
out <- c("Share of CSIROs in all SA3s = ", csiro.shr, "% of total", "\n")
cat(out, file="diagnostics-sri.txt", sep="", append=TRUE) ## CSIROs

crc.shr <- sum(df.sri$crc_count)/sum(df.sri$total_sri_count)
crc.shr <- round(as.numeric(crc.shr)*100, 1)
out <- c("Share of CRCs in all SA3s = ", crc.shr, "% of total", "\n")
cat(out, file="diagnostics-sri.txt", sep="", append=TRUE) ## CRCs

rsp.shr <- sum(df.sri$rsp_count)/sum(df.sri$total_sri_count)
rsp.shr <- round(as.numeric(rsp.shr)*100, 1)
out <- c("Share of RSPs in all SA3s = ", rsp.shr, "% of total", "\n")
cat(out, file="diagnostics-sri.txt", sep="", append=TRUE) ## RSPs

coe.shr <- sum(df.sri$coe_count)/sum(df.sri$total_sri_count)
coe.shr <- round(as.numeric(coe.shr)*100, 1)
out <- c("Share of COEs in all SA3s = ", coe.shr, "% of total", "\n")
cat(out, file="diagnostics-sri.txt", sep="", append=TRUE) ## COEs

## ..top SA3s with the highest number of SRIs (>=7)
out <- subset(df.sri, select=c(sa3_name, total_sri_count))
out <- out[order(-out$total_sri_count), ]
row.names(out) <- NULL
names(out) <- c("sa3_name", "total_sri_count")
out <- out[out$total_sri_count>=7, ]

sink(file="diagnostics-sri.txt", append=TRUE)
cat(c("\n\n", "3.2 Top 15 across all SA3s, by the number of SRIs:", "\n"), sep="")
print(out)

##############################################

## 3. Distribution of SRIs by SA3 (within regional subset of SA3s)
out <- c("\n", "3.3. Distribution of SRIs within the regional subset:")
cat(out, file="diagnostics-sri.txt", sep="\n",append=TRUE)

## .. aggregate filt.df by SRI count

uni.main.shr <- sum(filt.df$uni_main_count)/sum(filt.df$total_sri_count)
uni.main.shr <- round(as.numeric(uni.main.shr)*100, 1)
out <- c("Share of UNIs (main campus) within the regional subset of SA3s = ", uni.main.shr, "% of total", "\n")
cat(out, file="diagnostics-sri.txt", sep="", append=TRUE) ## Unis main campus

uni.other.shr <- sum(filt.df$uni_other_count)/sum(filt.df$total_sri_count)
uni.other.shr <- round(as.numeric(uni.other.shr)*100, 1)
out <- c("Share of UNIs (other campus) within the regional subset of SA3s = ", uni.other.shr, "% of total", "\n")
cat(out, file="diagnostics-sri.txt", sep="", append=TRUE) ## Unis other campus

csiro.shr <- sum(filt.df$csiro_count)/sum(filt.df$total_sri_count)
csiro.shr <- round(as.numeric(csiro.shr)*100, 1)
out <- c("Share of CSIROs within the regional subset of SA3s = ", csiro.shr, "% of total", "\n")
cat(out, file="diagnostics-sri.txt", sep="", append=TRUE) ## CSIROs

crc.shr <- sum(filt.df$crc_count)/sum(filt.df$total_sri_count)
crc.shr <- round(as.numeric(crc.shr)*100, 1)
out <- c("Share of CRCs within the regional subset of SA3s = ", crc.shr, "% of total", "\n")
cat(out, file="diagnostics-sri.txt", sep="", append=TRUE) ## CRCs

rsp.shr <- sum(filt.df$rsp_count)/sum(filt.df$total_sri_count)
rsp.shr <- round(as.numeric(rsp.shr)*100, 1)
out <- c("Share of RSPs within the regional subset of SA3s = ", rsp.shr, "% of total", "\n")
cat(out, file="diagnostics-sri.txt", sep="", append=TRUE) ## RSPs

coe.shr <- sum(filt.df$coe_count)/sum(filt.df$total_sri_count)
coe.shr <- round(as.numeric(coe.shr)*100, 1)
out <- c("Share of COEs within the regional subset of SA3s = ", coe.shr, "% of total", "\n")
cat(out, file="diagnostics-sri.txt", sep="", append=TRUE) ## COEs

## ..top SA3s within the regional subset with the highest number of SRIs
out <- subset(filt.df, select=c(sa3_name, total_sri_count))
out <- out[order(-out$total_sri_count), ]
row.names(out) <- NULL
names(out) <- c("sa3_name", "total_sri_count")
out <- out[out$total_sri_count>=3, ]

sink(file="diagnostics-sri.txt", append=TRUE)
cat(c("\n\n", "3.4 Top 15 SA3s within the regional subset, by the number of SRIs:", "\n"), sep="")
print(out)

##############################################

## 4. Frequency of SRIs by org_type, and by group_name across all SA3s

## ..Top 15 SRIs across all SA3s by org type
out <- data.frame(table(unlist(dat.sri$org_type)))
out <- out[order(-out$Freq), ]
row.names(out) <- NULL
names(out) <- c("org_type", "frequency")
out <- out[1:15, ]

sink(file="diagnostics-sri.txt", append=TRUE)
cat(c("\n\n", "4.1 Top 15 SRIs across all SA3s, by org type:", "\n"), sep="")
print(out)
sink()

## ..Top 15 SRIs across all SA3s by group name
out <- data.frame(table(unlist(dat.sri$group_name)))
out <- out[order(-out$Freq), ]
row.names(out) <- NULL
names(out) <- c("group_name", "frequency")
out <- out[1:15, ]

sink(file="diagnostics-sri.txt", append=TRUE)
cat(c("\n\n", "4.2 Top 15 SRIs across all SA3s, by group name:", "\n"), sep="")
print(out)
sink()

##############################################

## 4. Frequency of SRIs by org_type, and by group_name within the regional subset of SA3s

## .. subset dat.sri to identify only the regional subset SA3s (equivalent to applying all filters to dat.sri)
markers <- dat.sri$sa3_code %in% filt.df$sa3_code
dat.sri.filt <- dat.sri[markers, ]

## ..Top 15 SRIs within the regional subset by org type
out <- data.frame(table(unlist(dat.sri.filt$org_type)))
out <- out[order(-out$Freq), ]
row.names(out) <- NULL
names(out) <- c("org_type", "frequency")
out <- out[1:15, ]

sink(file="diagnostics-sri.txt", append=TRUE)
cat(c("\n\n", "4.3 Top 15 SRIs within the regional subset, by org type:", "\n"), sep="")
print(out)
sink()

## ..Top 15 SRIs within the regional subset by group name
out <- data.frame(table(unlist(dat.sri.filt$group_name)))
out <- out[order(-out$Freq), ]
row.names(out) <- NULL
names(out) <- c("group_name", "frequency")
out <- out[1:15, ]

sink(file="diagnostics-sri.txt", append=TRUE)
cat(c("\n\n", "4.4 Top 15 SRIs within the regional subset, by group name:", "\n"), sep="")
print(out)
sink()

##############################################

## cleanup, save objects, and set directory
setwd(scri)
source("00-cleanup-workspace.R")
