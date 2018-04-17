#!/usr/bin/env Rscript

##############################################

## make a copy of the regional subset
df <- filt.df

##############################################

## Top15 SA3 locations

## ..biz
top15.biz.pop <- subset(df, select=c(sa3_code, sa3_name, sa4_name, gcc_name, ste_name, avg_biz_per_100_pop, avg_biz_start_count, avg_pop_count))
top15.biz.pop <- top15.biz.pop[order(-top15.biz.pop$avg_biz_per_100_pop), ]
top15.biz.pop <- top15.biz.pop[1:15, ] ## switch this on/off as needed
row.names(top15.biz.pop) <- NULL

## ..sri
top15.sri.pop <- subset(df, select=c(sa3_code, sa3_name, sa4_name, gcc_name, ste_name, sri_per_10k_pop, total_sri_count, avg_pop_count))
top15.sri.pop <- top15.sri.pop[order(-top15.sri.pop$sri_per_10k_pop), ]
top15.sri.pop <- top15.sri.pop[1:15, ] ## switch this on/off as needed
row.names(top15.sri.pop) <- NULL

top15.sri.biz <- subset(df, select=c(sa3_code, sa3_name, sa4_name, gcc_name, ste_name, sri_per_1k_biz, total_sri_count, avg_biz_start_count))
top15.sri.biz <- top15.sri.biz[order(-top15.sri.biz$sri_per_1k_biz), ]
top15.sri.biz <- top15.sri.biz[1:15, ] ## switch this on/off as needed
row.names(top15.sri.biz) <- NULL

## ..ent
top15.ent.pop <- subset(df, select=c(sa3_code, sa3_name, sa4_name, gcc_name, ste_name, avg_ent_per_10k_pop, avg_netent_count, avg_pop_count))
top15.ent.pop <- top15.ent.pop[order(-top15.ent.pop$avg_ent_per_10k_pop), ]
top15.ent.pop <- top15.ent.pop[1:15, ] ## switch this on/off as needed
row.names(top15.ent.pop) <- NULL

top15.ent.biz <- subset(df, select=c(sa3_code, sa3_name, sa4_name, gcc_name, ste_name, avg_ent_per_1k_biz, avg_netent_count, avg_biz_start_count))
top15.ent.biz <- top15.ent.biz[order(-top15.ent.biz$avg_ent_per_1k_biz), ]
top15.ent.biz <- top15.ent.biz[1:15, ] ## switch this on/off as needed
row.names(top15.ent.biz) <- NULL

## ..pat
top15.pat.pop <- subset(df, select=c(sa3_code, sa3_name, sa4_name, gcc_name, ste_name, avg_pat_per_10k_pop, avg_pat_count, avg_pop_count))
top15.pat.pop <- top15.pat.pop[order(-top15.pat.pop$avg_pat_per_10k_pop), ]
top15.pat.pop <- top15.pat.pop[1:15, ] ## switch this on/off as needed
row.names(top15.pat.pop) <- NULL

top15.pat.biz <- subset(df, select=c(sa3_code, sa3_name, sa4_name, gcc_name, ste_name, avg_pat_per_1k_biz, avg_pat_count, avg_biz_start_count))
top15.pat.biz <- top15.pat.biz[order(-top15.pat.biz$avg_pat_per_1k_biz), ]
top15.pat.biz <- top15.pat.biz[1:15, ] ## switch this on/off as needed
row.names(top15.pat.biz) <- NULL

## ..tm
top15.tm.pop <- subset(df, select=c(sa3_code, sa3_name, sa4_name, gcc_name, ste_name, avg_tm_per_10k_pop, avg_tm_count, avg_pop_count))
top15.tm.pop <- top15.tm.pop[order(-top15.tm.pop$avg_tm_per_10k_pop), ]
top15.tm.pop <- top15.tm.pop[1:15, ] ## switch this on/off as needed
row.names(top15.tm.pop) <- NULL

top15.tm.biz <- subset(df, select=c(sa3_code, sa3_name, sa4_name, gcc_name, ste_name, avg_tm_per_1k_biz, avg_tm_count, avg_biz_start_count))
top15.tm.biz <- top15.tm.biz[order(-top15.tm.biz$avg_tm_per_1k_biz), ]
top15.tm.biz <- top15.tm.biz[1:15, ] ## switch this on/off as needed
row.names(top15.tm.biz) <- NULL

## ..rnd
top15.rnd.pop <- subset(df, select=c(sa3_code, sa3_name, sa4_name, gcc_name, ste_name, avg_rnd_per_10k_pop, avg_rnd_spend, avg_pop_count))
top15.rnd.pop <- top15.rnd.pop[order(-top15.rnd.pop$avg_rnd_per_10k_pop), ]
top15.rnd.pop <- top15.rnd.pop[1:15, ] ## switch this on/off as needed
row.names(top15.rnd.pop) <- NULL

top15.rnd.biz <- subset(df, select=c(sa3_code, sa3_name, sa4_name, gcc_name, ste_name, avg_rnd_per_1k_biz, avg_rnd_spend, avg_biz_start_count))
top15.rnd.biz <- top15.rnd.biz[order(-top15.rnd.biz$avg_rnd_per_1k_biz), ]
top15.rnd.biz <- top15.rnd.biz[1:15, ] ## switch this on/off as needed
row.names(top15.rnd.biz) <- NULL

##############################################

## save top15 into a list for later use by 'export-summary-charts'

lst.top15 <- lapply(ls(pattern="top15\\."), function(x) get(x)) ## collect all the above dataframes in a list
names(lst.top15) <- ls(pattern="top15\\.") ## add back the dataframe names, RISKY BUT WORKS!!

##############################################

## now identify the stars within the Top15 SA3 lists

vec.star <- c(top15.biz.pop$sa3_name,
              top15.sri.pop$sa3_name,
              top15.sri.biz$sa3_name,
              top15.ent.pop$sa3_name,
              top15.ent.biz$sa3_name,
              top15.pat.pop$sa3_name,
              top15.pat.biz$sa3_name,
              top15.tm.pop$sa3_name,
              top15.tm.biz$sa3_name,
              top15.rnd.pop$sa3_name,
              top15.rnd.biz$sa3_name)

df.stars <- as.data.frame(table(vec.star))
names(df.stars) <- c("sa3_name", "frequency") ## for all SA3 locations, they should all have the same frequency
df.stars <- merge(x=asgs.sa, y=df.stars, by="sa3_name", all=FALSE)
df.stars <- df.stars[order(-df.stars$frequency), ]
df.stars <- df.stars[df.stars$frequency>=4, ] ## SA3s appearing in top15 four or more times
row.names(df.stars) <- NULL

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
