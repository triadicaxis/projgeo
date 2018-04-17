#!/usr/bin/env Rscript

##############################################

## convert data wide to long, by year

dat.rnd <- reshape(dat.rnd, direction="long", varying=list(names(dat.rnd)[which(names(dat.rnd)=="2008"):ncol(dat.rnd)]), 
                   v.names="rnd_spend", timevar="fin_year", times=2008:2014)
dat.rnd <- dat.rnd[ ,1:ncol(dat.rnd)-1]
dat.rnd <- dat.rnd[order(dat.rnd$fin_year, dat.rnd$sa3_code), ]
row.names(dat.rnd) <- NULL

## merge dat.rnd with asgs.sa
dat.rnd$sa3_name <- NULL
dat.rnd <- merge(asgs.sa, dat.rnd, by="sa3_code", all=FALSE)

## scale rnd spend to $ millions
dat.rnd$rnd_spend <- round(dat.rnd$rnd_spend/1000000, 1)

##############################################

## match years to business counts data
dat.rnd <- dat.rnd[dat.rnd$fin_year>=2009 & dat.rnd$fin_year<=2013, ]

##############################################

## make df.rnd

df.rnd <- aggregate(rnd_spend ~ sa3_code, dat.rnd, FUN=mean, na.rm=TRUE) ## aggregate away years, use mean
df.rnd <- merge(asgs.sa, df.rnd, by="sa3_code", all=TRUE)
names(df.rnd) <- c(names(asgs.sa), "avg_rnd_spend")

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
