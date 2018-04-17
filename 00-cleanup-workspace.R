#!/usr/bin/env Rscript

##############################################

## cleanup and save

keep <- c("home", "src", "json", "dest", "figs", "scri", "once", "wksp", "bckp", 
          "anzsic.div", "anzsic.cls", "asgs.sa", "asgs.ra", 
          "easd.theme", "easd.theme2",
          "dat.sri", "dat.pop", "dat.ent", "dat.pat", "dat.tm", "dat.rnd", "dat.rnd2", "dat.abs", 
          "df.sri", "df.pop", "df.ent", "df.pat", "df.tm", "df.rnd", "df.all", "df.stars", "df.gcc",
          "filt1.df", "filt2.df", "filt3.df", "filt.df", "filt.drop", "filt.sora",
          "lst.pat", "lst.tm", "lst.map", "lst.top15", "lst.figs", "lst.ddf")

rm(list=ls()[!ls() %in% keep])
#.rs.restartR() ## restart R session

##############################################

## go back into the script folder
setwd(scri)
