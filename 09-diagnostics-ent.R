#!/usr/bin/env Rscript

##############################################

## remove the old file

setwd(dest)
if(file.exists("diagnostics-ent.txt")) file.remove("diagnostics-ent.txt")

##############################################

## FILE diagnostics-ent.txt gets the following:

toc <- c("DIAGNOSTICS FOR BUSINESS ENTRIES:", "  1. Data structure", 
         "  2. Missing observations", 
         "  3. Period & ANZSIC covered", 
         "  4. Top sa3s by business counts & net entries")
cat(toc, file="diagnostics-ent.txt", sep="\n",append=TRUE)

## 1. Data structure
out <- c("\n", "1. Data structure:", capture.output(str(dat.ent))) ## structure of dat.ent
cat(out, file="diagnostics-ent.txt", sep="\n",append=TRUE)

## 2. Missing observations
i <- length(which(is.na(dat.ent$sa3_code)))
j <- length(which(!is.na(dat.ent$sa3_code)))
k <- round(i/(i+j)*100, 1)
out <- c("\n\n", 
          "2. Missing observations:", "\n", 
          "Missing SA3 = ", i, "\n", 
          "Missing SA3 = ", k, "% of total", "\n") 
cat(out, file="diagnostics-ent.txt", sep="", append=TRUE)

## 3. Period & ANZSIC covered
out <- c("\n", "3.1 Period covered (years):", capture.output(unique(dat.ent$fin_year))) ## years covered in dat.ent
cat(out, file="diagnostics-ent.txt", sep="\n",append=TRUE)

out <- c("\n", "3.2 ANZSIC divisions covered:", capture.output(unique(dat.ent$anzsic_div_code))) ## ANZSIC divisions covered in dat.ent
cat(out, file="diagnostics-ent.txt", sep="\n",append=TRUE)

##############################################

## Aggregate business counts and net entries by anzsic, across all SA3s, and all years 

df <- aggregate(cbind(biz_start_count, biz_end_count, netent_count) ~ anzsic_div_code + fin_year, dat.ent, FUN=sum, na.rm=TRUE) ## sum, aggregates all ANZSIC

biz.start <- aggregate(biz_start_count ~ anzsic_div_code, df, FUN=mean, na.rm=TRUE) ## mean, averages across years
biz.end <- aggregate(biz_end_count ~ anzsic_div_code, df, FUN=mean, na.rm=TRUE) ## mean, averages across years
netent <- aggregate(netent_count ~ anzsic_div_code, df, FUN=mean, na.rm=TRUE) ## mean, averages across years

biz.pc.chg <- round(netent$netent_count/biz.start$biz_start_count*100, 1) ## bind this one
biz.pc.shr.start <- biz.start$biz_start_count/sum(biz.start$biz_start_count)
biz.pc.shr.end <- biz.end$biz_end_count/sum(biz.end$biz_end_count)
biz.pc.shr <- round((biz.pc.shr.start + biz.pc.shr.end)/2*100, 1) ## bind this one

ent.by.anzsic <- merge(x=anzsic.div, y=biz.start, by="anzsic_div_code")
ent.by.anzsic <- merge(x=ent.by.anzsic, y=biz.end, by="anzsic_div_code")
ent.by.anzsic <- merge(x=ent.by.anzsic, y=netent, by="anzsic_div_code")
ent.by.anzsic <- cbind(ent.by.anzsic, biz.pc.chg, biz.pc.shr)

names(ent.by.anzsic) <- c("anzsic_div_code", "anzsic_div_name", "biz_start_count", "biz_end_count", "netent_count", "netent_pc_chg", "biz_pc_shr")

out <- c("\n", "3.3 Business counts and entries by ANZSIC division, across all SA3s, annual average between 2008-09 and 2012-13: ", capture.output(ent.by.anzsic))
cat(out, file="diagnostics-ent.txt", sep="\n",append=TRUE)

latest.biz.count <- sum(df$biz_end_count[df$fin_year==2013])
out <- c("\n\n", "3.4 Total Business count at end of year 2012-13 (all SA3s, all ANZSIC divisions): ", capture.output(latest.biz.count), "\n")
cat(out, file="diagnostics-ent.txt", sep="",append=TRUE)

##############################################

## 4. Top 25 SA3s by business counts, net change & entry rates (all SA3s)

i <- aggregate(avg_biz_start_count ~ sa3_name, df.ent, FUN=sum, na.rm=TRUE)
j <- aggregate(avg_netent_count ~ sa3_name, df.ent, FUN=sum, na.rm=TRUE)

df <- Reduce(function(x, y) merge(x, y, all=TRUE), list(i, j))
netent_pc_chg <- round(df$avg_netent_count/df$avg_biz_start_count*100, 1)
df <- cbind(df, netent_pc_chg)

df1 <- df[order(df$avg_biz_start_count, decreasing=TRUE), ]
df1 <- df1[1:15, ]
row.names(df1) <- NULL

df2 <- df[order(df$avg_netent_count, decreasing=TRUE), ]
df2 <- df2[1:15, ]
row.names(df2) <- NULL

df3 <- df[order(df$netent_pc_chg, decreasing=TRUE), ]
df3 <- df3[1:15, ]
row.names(df3) <- NULL

out <- c("\n", "4.1 Top 15 locations with high business counts, all years: ", capture.output(df1))
cat(out, file="diagnostics-ent.txt", sep="\n",append=TRUE)

out <- c("\n", "4.2 Top 15 locations with high change in net counts, all years: ", capture.output(df2))
cat(out, file="diagnostics-ent.txt", sep="\n",append=TRUE)

out <- c("\n", "4.3 Top 15 locations with high net percent change, all years: ", capture.output(df3))
cat(out, file="diagnostics-ent.txt", sep="\n",append=TRUE)

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
