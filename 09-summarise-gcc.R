#!/usr/bin/env Rscript

##############################################

## group SA3s by GCCSA, using base package

df <- asgs.sa

sa3_count <- rep(1, times=nrow(df)) ## create a column of SA3 counts and bind it to df
df <- cbind(df, sa3_count)
df <- aggregate(sa3_count ~ gcc_code + gcc_name, df, FUN=sum, na.rm=TRUE)

## Alternative: group SA3s by GCCSA, using the pipe operator %>% from dplyr

#require(dplyr)
#df <- asgs.sa %>%
#    group_by(gcc_code, gcc_name) %>% 
#    summarise(sa3_count = length(gcc_code))

##############################################

## create a dataframe of all indicators by GCCSA

i <- aggregate(total_sri_count ~ gcc_code, df.sri, FUN=sum, na.rm=TRUE)
j <- aggregate(avg_pop_count ~ gcc_code, df.pop, FUN=sum, na.rm=TRUE)
k <- aggregate(avg_biz_start_count ~ gcc_code, df.ent, FUN=sum, na.rm=TRUE)

## ..ent
l <- aggregate(netent_count ~ gcc_code + fin_year, dat.ent, FUN=sum, na.rm=TRUE)
l <- aggregate(netent_count ~ gcc_code, l, FUN=mean, na.rm=TRUE)

## ..pat
m <- aggregate(pat_count ~ gcc_code + cal_year, dat.pat, FUN=sum, na.rm=TRUE)
m <- aggregate(pat_count ~ gcc_code, m, FUN=mean, na.rm=TRUE)

## ..tm
n <- aggregate(tm_count ~ gcc_code + cal_year, dat.tm, FUN=sum, na.rm=TRUE)
n <- aggregate(tm_count ~ gcc_code, n, FUN=mean, na.rm=TRUE)

## ..rnd
o <- aggregate(rnd_spend ~ gcc_code + fin_year, dat.rnd, FUN=sum, na.rm=TRUE)
o <- aggregate(rnd_spend ~ gcc_code, o, FUN=mean, na.rm=TRUE)

df <- Reduce(function(x, y) merge(x, y, all=TRUE), list(df, i, j, k, l, m, n, o))
df <- df[order(-df$sa3_count), ] ## done.
row.names(df) <- NULL

##############################################

## calculate and bind all ratio measures to df

sri_per_10k_pop <- df$total_sri_count/(df$avg_pop_count/10000)
sri_per_1k_biz <- df$total_sri_count/(df$avg_biz_start_count/1000)

avg_ent_per_10k_pop <- df$netent_count/(df$avg_pop_count/10000)
avg_ent_per_1k_biz <- df$netent_count/(df$avg_biz_start_count/1000)

avg_pat_per_10k_pop <- df$pat_count/(df$avg_pop_count/10000)
avg_pat_per_1k_biz <- df$pat_count/(df$avg_biz_start_count/1000)

avg_tm_per_10k_pop <- df$tm_count/(df$avg_pop_count/10000)
avg_tm_per_1k_biz <- df$tm_count/(df$avg_biz_start_count/1000)

avg_rnd_per_10k_pop <- df$rnd_spend/(df$avg_pop_count/10000)
avg_rnd_per_1k_biz <- df$rnd_spend/(df$avg_biz_start_count/1000)

df <- cbind(df,
            sri_per_10k_pop,
            sri_per_1k_biz,
            avg_ent_per_10k_pop,
            avg_ent_per_1k_biz,
            avg_pat_per_10k_pop,
            avg_pat_per_1k_biz,
            avg_tm_per_10k_pop,
            avg_tm_per_1k_biz,
            avg_rnd_per_10k_pop,
            avg_rnd_per_1k_biz)

##############################################

## check result
sum(df$sa3_count)==nrow(asgs.sa) ## check: TRUE if ok

## save the GCCSA dataframe for later use by 'export-summary-charts' (charts must exclude NAs)
df.gcc <- df[complete.cases(df), ] # done.

##############################################

## export as CSV (include NAs also)

setwd(dest)
write.table(df, "all_indicators_by_gcc.csv", sep=",", row.names = FALSE)

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
