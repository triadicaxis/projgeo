#!/usr/bin/env Rscript

##############################################

## read data + anzsic classes
setwd(src)

tm201 <- read.csv("ipgod-201.csv", header=TRUE, quote="", row.names=NULL, stringsAsFactors=FALSE)
tm202 <- read.csv("202-under-construction.csv", header=TRUE, sep = ",", quote = "\"", dec = ".", stringsAsFactors=FALSE)

anzsic.cls <- read.table("lookup-anzsic06-cls.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)

##############################################

## save tm.<each> into a list for later use by 'spatial-join'

lst.tm <- lapply(ls(pattern="tm.+"), function(x) get(x)) ## collect all the above dataframes in a list
names(lst.tm) <- ls(pattern="tm.+") ## add back the dataframe names, RISKY BUT WORKS!!

## to retrieve dataframes from list: list2env(lst.tm, .GlobalEnv)
##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
setwd(once) ## CONTINUE..
