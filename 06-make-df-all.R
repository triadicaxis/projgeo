#!/usr/bin/env Rscript

##############################################

## merge all the aggregated indicators from df.<each> into a single dataframe df1

lst <- list(asgs.sa, df.sri, df.pop, df.ent, df.pat, df.tm, df.rnd)
df1 <- Reduce(function(x, y) merge(x, y, all=TRUE), lst)
df1[is.na(df1)] <- 0

##############################################

## calculate ratios

avg_biz_per_100_pop <- df1$avg_biz_start_count/(df1$avg_pop_count/100)

sri_per_10k_pop <- df1$total_sri_count/(df1$avg_pop_count/10000)
sri_per_1k_biz <- df1$total_sri_count/(df1$avg_biz_start_count/1000)

avg_ent_per_10k_pop <- df1$avg_netent_count/(df1$avg_pop_count/10000)
avg_ent_per_1k_biz <- df1$avg_netent_count/(df1$avg_biz_start_count/1000)

avg_pat_per_10k_pop <- df1$avg_pat_count/(df1$avg_pop_count/10000)
avg_pat_per_1k_biz <- df1$avg_pat_count/(df1$avg_biz_start_count/1000)

avg_tm_per_10k_pop <- df1$avg_tm_count/(df1$avg_pop_count/10000)
avg_tm_per_1k_biz <- df1$avg_tm_count/(df1$avg_biz_start_count/1000)

avg_rnd_per_10k_pop <- df1$avg_rnd_spend/(df1$avg_pop_count/10000)
avg_rnd_per_1k_biz <- df1$avg_rnd_spend/(df1$avg_biz_start_count/1000)

## bind ratios into a single dataframe df2

df2 <- cbind(asgs.sa, 
             avg_biz_per_100_pop,
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

## combine df1 and df2 into df
df <- Reduce(function(x, y) merge(x, y, all=TRUE), list(df1, df2))

## create df.all (the benchmark dataframe) for assessing the impact of filters 
df.all <- df

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
