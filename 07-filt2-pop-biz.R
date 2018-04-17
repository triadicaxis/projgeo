#!/usr/bin/env Rscript

##############################################

## Conceptual framework behind FILTER 2:

## Some SA3s have very small populations and small business counts
## Small numbers tend to distort the ratio measures, so excluding these SA3s improves comparability
## This filter rejects all SA3s whose population count < 10,000 and business count < 1,000

##############################################

## make a copy of the full dataset
df <- df.all

##############################################

## FILTER 2: MINIMUM POPULATION AND BUSINESS COUNTS

pop <- df$avg_pop_count
markers.pop <- pop>=10000

biz <- df$avg_biz_start_count
markers.biz <- biz>=1000

markers <- markers.pop & markers.biz
#cbind(markers.pop, markers.biz, markers) ## check that it works
markers[is.na(markers)] <- FALSE
#cbind(markers.pop, markers.biz, markers) ## check that it works

filt2.df <- df[markers, ] ## include only SA3s that meet the minimum pop & biz requirements. done.

##############################################

## checks and balances

incl <- df.all$sa3_code %in% filt2.df$sa3_code ## T/F vector length(df.all) of included SA3s
filt2.dropped <- df.all[!incl, ] ## check: which SA3s have been excluded?
rm(incl)

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
