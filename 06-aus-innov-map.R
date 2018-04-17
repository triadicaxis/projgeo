#!/usr/bin/env Rscript

##############################################

## population

pop.ex <- aggregate(pop_count ~ sa3_code + fin_year, dat.pop, FUN=sum, na.rm=TRUE)

pop.ex <- merge(x=asgs.sa, y=pop.ex, by="sa3_code", all=FALSE)
#pop.ex[is.na(pop.ex)] <- 0
pop.ex <- pop.ex[order(pop.ex$fin_year, pop.ex$sa3_code), ]
row.names(pop.ex) <- NULL

setwd(paste(dest, "/National-Innovation-Map", sep = ""))
write.table(pop.ex, "pop-by-sa3-by-year.csv", sep=",", row.names=FALSE) ## done.

##############################################

## businesses

biz.ex <- aggregate(biz_start_count ~ sa3_code + fin_year, dat.ent, FUN=sum, na.rm=TRUE)

biz.ex <- merge(x=asgs.sa, y=biz.ex, by="sa3_code", all=TRUE)
#biz.ex[is.na(biz.ex)] <- 0
biz.ex <- biz.ex[order(biz.ex$fin_year, biz.ex$sa3_code), ]
row.names(biz.ex) <- NULL

setwd(paste(dest, "/National-Innovation-Map", sep = ""))
write.table(biz.ex, "biz-by-sa3-by-year.csv", sep=",", row.names=FALSE) ## done.

##############################################
##############################################

## ..rnd

rnd.ex <- aggregate(rnd_spend ~ sa3_code + fin_year, dat.rnd, FUN=sum, na.rm=TRUE)
rnd.ex <- merge(x=asgs.sa, y=rnd.ex, by="sa3_code", all=FALSE)
#rnd.ex[is.na(rnd.ex)] <- 0

rnd.ex <- Reduce(function(x, y) merge(x, y, all=TRUE), list(rnd.ex, pop.ex))
rnd.ex <- Reduce(function(x, y) merge(x, y, all=TRUE), list(rnd.ex, biz.ex))
rnd.ex <- rnd.ex[order(rnd.ex$fin_year, rnd.ex$sa3_code), ]
row.names(rnd.ex) <- NULL

setwd(paste(dest, "/National-Innovation-Map", sep = ""))
write.table(rnd.ex, "rnd-by-sa3-by-year.csv", sep=",", row.names=FALSE) ## done.

## check: open and run ~/Scripts/Run-Once/rnd-checksum.R here

##############################################
colnames(pop.ex)[which(names(pop.ex)=="fin_year")] <- "cal_year" ## need to change fin_year to cal_year
colnames(biz.ex)[which(names(biz.ex)=="fin_year")] <- "cal_year" ## need to change fin_year to cal_year
##############################################

## ..patents

pat.ex <- aggregate(pat_count ~ sa3_code + cal_year, dat.pat, FUN=sum, na.rm=TRUE)
pat.ex <- merge(x=asgs.sa, y=pat.ex, by="sa3_code", all=TRUE)
#pat.ex[is.na(pat.ex)] <- 0

pat.ex <- Reduce(function(x, y) merge(x, y, all=TRUE), list(pat.ex, pop.ex))
pat.ex <- Reduce(function(x, y) merge(x, y, all=TRUE), list(pat.ex, biz.ex))
pat.ex <- pat.ex[order(pat.ex$cal_year, pat.ex$sa3_code), ]
row.names(pat.ex) <- NULL

setwd(paste(dest, "/National-Innovation-Map", sep = ""))
write.table(pat.ex, "pat-by-sa3-by-year.csv", sep=",", row.names=FALSE) ## done.

##############################################

## ..trademarks

tm.ex <- aggregate(tm_count ~ sa3_code + cal_year, dat.tm, FUN=sum, na.rm=TRUE)
tm.ex <- merge(x=asgs.sa, y=tm.ex, by="sa3_code", all=TRUE)
#tm.ex[is.na(tm.ex)] <- 0

tm.ex <- Reduce(function(x, y) merge(x, y, all=TRUE), list(tm.ex, pop.ex))
tm.ex <- Reduce(function(x, y) merge(x, y, all=TRUE), list(tm.ex, biz.ex))
tm.ex <- tm.ex[order(tm.ex$cal_year, tm.ex$sa3_code), ]
row.names(tm.ex) <- NULL

setwd(paste(dest, "/National-Innovation-Map", sep = ""))
write.table(tm.ex, "tm-by-sa3-by-year.csv", sep=",", row.names=FALSE) ## done.

##############################################

## save <each>.ex into a list for later use

lst.map <- lapply(ls(pattern="\\.ex"), function(x) get(x)) ## collect all the above dataframes in a list
names(lst.map) <- ls(pattern="\\.ex") ## add back the dataframe names, RISKY BUT WORKS!!

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
