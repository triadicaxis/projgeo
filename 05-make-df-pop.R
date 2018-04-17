#!/usr/bin/env Rscript

##############################################

## convert data wide to long, by year
## these might be calendar years, so 2009 means 2009 (Jan - Dec). Low impact but need to check anyway.

dat.pop <- reshape(dat.pop, direction="long", varying=list(names(dat.pop)[which(names(dat.pop)=="2008"):ncol(dat.pop)]), 
                   v.names="pop_count", timevar="fin_year", times=2008:2014)
dat.pop <- dat.pop[ ,1:ncol(dat.pop)-1]
dat.pop <- dat.pop[order(dat.pop$fin_year, dat.pop$sa3_code), ]
row.names(dat.pop) <- NULL

##############################################

## match years to business counts data
dat.pop <- dat.pop[dat.pop$fin_year>=2009 & dat.pop$fin_year<=2013, ]

##############################################

## make df.pop

df.pop <- aggregate(pop_count ~ sa3_code, dat.pop, FUN=mean, na.rm=TRUE) ## aggregate away years, use mean
df.pop <- merge(asgs.sa, df.pop, by="sa3_code", all=TRUE)
names(df.pop) <- c(names(asgs.sa), "avg_pop_count")

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
