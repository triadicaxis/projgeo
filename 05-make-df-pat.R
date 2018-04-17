#!/usr/bin/env Rscript

##############################################

## match years to business counts data
dat.pat <- dat.pat[dat.pat$cal_year>=2009 & dat.pat$cal_year<=2013, ]

##############################################

## sort data
dat.pat <- dat.pat[order(dat.pat$cal_year, dat.pat$sa3_code, dat.pat$anzsic_cls_code), ]
row.names(dat.pat) <- NULL

## create a column of patent counts
pat_count <- rep(1, times=nrow(dat.pat))
dat.pat <- cbind(dat.pat, pat_count)

##############################################

## make df.pat

df.pat <- aggregate(pat_count ~ sa3_code + cal_year, dat.pat, FUN=sum, na.rm=TRUE) ## sum, adds up patents by SA3, by year
df.pat <- aggregate(pat_count ~ sa3_code, df.pat, FUN=mean, na.rm=TRUE) ## mean, annual average patents, use df.pat!

df.pat <- merge(x=asgs.sa, y=df.pat, by="sa3_code", all=TRUE)
df.pat[is.na(df.pat)] <- 0
names(df.pat) <- c(names(asgs.sa), "avg_pat_count")

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
