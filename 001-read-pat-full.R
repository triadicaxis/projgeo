#!/usr/bin/env Rscript

##############################################

## read data + anzsic classes
setwd(src)

pat101 <- read.csv("ipgod-101.csv", header=TRUE, quote="", row.names=NULL, stringsAsFactors=FALSE)
pat102 <- read.csv("102-under-construction.csv", header = TRUE, sep = ",", quote = "\"", dec = ".", stringsAsFactors=FALSE)

anzsic.cls <- read.table("lookup-anzsic06-cls.csv", header=TRUE, sep=",", stringsAsFactors=FALSE)

##############################################

## save pat.<each> into a list for later use by 'spatial-join'

lst.pat <- lapply(ls(pattern="pat.+"), function(x) get(x)) ## collect all the above dataframes in a list
names(lst.pat) <- ls(pattern="pat.+") ## add back the dataframe names, RISKY BUT WORKS!!

## to retrieve dataframes from list: list2env(lst.pat, .GlobalEnv)
##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
setwd(once) ## CONTINUE..
