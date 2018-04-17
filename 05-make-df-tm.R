#!/usr/bin/env Rscript

##############################################

## match years to business counts data
dat.tm <- dat.tm[dat.tm$cal_year>=2009 & dat.tm$cal_year<=2013, ]

##############################################

## sort data
dat.tm <- dat.tm[order(dat.tm$cal_year, dat.tm$sa3_code, dat.tm$anzsic_cls_code), ]
row.names(dat.tm) <- NULL

## create a column of trademark counts
tm_count <- rep(1, times=nrow(dat.tm))
dat.tm <- cbind(dat.tm, tm_count)

##############################################

## make df.tm

df.tm <- aggregate(tm_count ~ sa3_code + cal_year, dat.tm, FUN=sum, na.rm=TRUE) ## sum, adds up trademarks by SA3, by year
df.tm <- aggregate(tm_count ~ sa3_code, df.tm, FUN=mean, na.rm=TRUE) ## mean, annual average trademarks, use df.tm!

df.tm <- merge(x=asgs.sa, y=df.tm, by="sa3_code", all=TRUE)
df.tm[is.na(df.tm)] <- 0
names(df.tm) <- c(names(asgs.sa), "avg_tm_count")

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
