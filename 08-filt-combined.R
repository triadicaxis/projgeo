#!/usr/bin/env Rscript

##############################################

## combine all filters and apply them to the full dataset (df.all)

f1 <- filt1.df$sa3_code
f2 <- filt2.df$sa3_code
f3 <- filt3.df$sa3_code

f <- Reduce(intersect, list(f1, f2, f3)) ## clever trick!
markers <- df.all$sa3_code %in% f

df <- df.all[markers, ] ## done, but let's also try to bind the fraction columns (below)

##############################################

## cannot bind fraction columns from filt3.df to df, but we can subset filt3.df, RISKY BUT WORKS!!

markers <- filt3.df$sa3_code %in% df$sa3_code
filt.df <- filt3.df[markers, ] ## done.

##############################################

## checks and balances

## what is the difference between filt.df and filt3.df?
incl <- filt3.df$sa3_code %in% filt.df$sa3_code ## T/F vector length(filt3.df) of included SA3s
filt.drop <- filt3.df[!incl, ] ## check: which SA3s have been excluded?
rm(incl)

## which SA3s have been excluded from the regional subset? (export this one)
incl <- df.all$sa3_code %in% filt.df$sa3_code ## T/F vector length(df.all) of SA3s included in the regional subset
filt.drop <- df.all[!incl, ] ## check: which SA3s have been excluded?
rm(incl)

## have all SA3s from df been properly captured in filt.df?
all(df$sa3_code %in% filt.df$sa3_code) ## check: ok if TRUE
all(df$sa3_code==filt.df$sa3_code) ## check: ok if TRUE

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
