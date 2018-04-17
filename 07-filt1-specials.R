#!/usr/bin/env Rscript

##############################################

## Conceptual framework behind FILTER 1:
## SA3s classified as Migratory - Offshore - Shipping or Special Purpose Codes are irrelevant.

##############################################

## make a copy of the full dataset
df <- df.all

##############################################

## FILTER 1: MIGRATORY & SPECIAL PURPOSE CODES

excl1 <- grepl("Migratory - Offshore - Shipping", df$sa3_name)
excl2 <- grepl("Special Purpose Codes SA3", df$sa3_name)
filt1.df <- df[!(excl1 | excl2), ] ## exclude migratory & special purpose SA3s from df done.

##############################################

## checks and balances

incl <- df.all$sa3_code %in% filt1.df$sa3_code ## T/F vector length(df.all) of included SA3s
filt1.dropped <- df.all[!incl, ] ## check: which SA3s have been excluded?
rm(incl)

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
