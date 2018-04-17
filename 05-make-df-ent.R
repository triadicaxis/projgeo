#!/usr/bin/env Rscript

##############################################

## add ANZSIC division names and SA3 names to dat.ent and sort tha data
dat.ent <- merge(x=anzsic.div, y=dat.ent, by="anzsic_div_code", all=TRUE) ## merge with anzsic.div
dat.ent <- merge(x=asgs.sa, y=dat.ent, by="sa3_code", all=TRUE) ## merge with asgs.sa
dat.ent <- dat.ent[order(dat.ent$fin_year, dat.ent$sa3_code, dat.ent$anzsic_div_code), ] ## sort by year, by SA3, by ANZSIC
row.names(dat.ent) <- NULL

##############################################

## aggregate business counts and net entries by ANZSIC division, across all SA3s, and all years 

df.ent <- aggregate(cbind(biz_start_count, netent_count, ent_count, ext_count) ~ anzsic_div_code + fin_year, dat.ent, FUN=sum, na.rm=TRUE) ## sum, aggregates all ANZSIC

df1 <- aggregate(biz_start_count ~ anzsic_div_code, df.ent, FUN=mean, na.rm=TRUE) ## mean, annual average business counts, use df.ent!
df2 <- aggregate(netent_count ~ anzsic_div_code, df.ent, FUN=mean, na.rm=TRUE) ## mean, annual average net entries, use df.ent!
df3 <- aggregate(ent_count ~ anzsic_div_code, df.ent, FUN=mean, na.rm=TRUE) ## mean, annual average entries, use df.ent!
df4 <- aggregate(ext_count ~ anzsic_div_code, df.ent, FUN=mean, na.rm=TRUE) ## mean, annual average exits, use df.ent!

df <- merge(x=anzsic.div, y=df1, by="anzsic_div_code", all=TRUE)
df <- merge(x=df, y=df2, by="anzsic_div_code", all=TRUE)
df <- merge(x=df, y=df3, by="anzsic_div_code", all=TRUE)
df <- merge(x=df, y=df4, by="anzsic_div_code", all=TRUE)

names(df) <- c("anzsic_div_code", "anzsic_div_name", "avg_biz_start_count", "avg_netent_count", "avg_ent_count", "avg_ext_count")
df.ent.anzsic <- df ## done.

##############################################

## aggregate business counts and net entries by SA3, across all ANZSIC divisions, and all years 

df.ent <- aggregate(cbind(biz_start_count, netent_count, ent_count, ext_count) ~ sa3_code + fin_year, dat.ent, FUN=sum, na.rm=TRUE) ## sum, aggregates all ANZSIC

df1 <- aggregate(biz_start_count ~ sa3_code, df.ent, FUN=mean, na.rm=TRUE) ## mean, annual average net entries, use df.ent!
df2 <- aggregate(netent_count ~ sa3_code, df.ent, FUN=mean, na.rm=TRUE) ## mean, annual average net entries, use df.ent!
df3 <- aggregate(ent_count ~ sa3_code, df.ent, FUN=mean, na.rm=TRUE) ## mean, annual average entries, use df.ent!
df4 <- aggregate(ext_count ~ sa3_code, df.ent, FUN=mean, na.rm=TRUE) ## mean, annual average exits, use df.ent!

df <- merge(x=asgs.sa, y=df1, by="sa3_code", all=TRUE)
df <- merge(x=df, y=df2, by="sa3_code", all=TRUE)
df <- merge(x=df, y=df3, by="sa3_code", all=TRUE)
df <- merge(x=df, y=df4, by="sa3_code", all=TRUE)

names(df) <- c(names(asgs.sa), "avg_biz_start_count", "avg_netent_count", "avg_ent_count", "avg_ext_count")
df.ent <- df ## done.

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
