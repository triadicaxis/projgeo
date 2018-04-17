#!/usr/bin/env Rscript

library(jsonlite)

##############################################

## read data

setwd(src)

dat.sri <- read.csv("sri-data-sa3.csv", header=TRUE, quote="", row.names=NULL, stringsAsFactors=FALSE, na.strings=c("NA", "", " "))
dat.pop <- read.table("pop-data-sa3.csv", header=TRUE, sep=",", stringsAsFactors=FALSE, na.strings=c("NA", "", " "))
dat.ent <- read.table("ent-data-sa3.csv", header=TRUE, sep=",", stringsAsFactors=FALSE, na.strings=c("NA", "", " "))
#dat.pat <- read.csv("pat-data-sa3.csv", header = TRUE, sep = ",", quote = "\"", dec = ".", stringsAsFactors=FALSE, na.strings=c("NA", "", " "))
#dat.tm <- read.csv("tm-data-sa3.csv", header = TRUE, sep = ",", quote = "\"", dec = ".", stringsAsFactors=FALSE, na.strings=c("NA", "", " "))
dat.rnd <- read.table("rnd-data-sa3.csv", header=TRUE, sep=",", stringsAsFactors=FALSE, na.strings=c("NA", "", " "))
dat.abs <- read.table("absstat-data-sa3.csv", header=TRUE, sep=",", stringsAsFactors=FALSE, na.strings=c("NA", "", " "))
#dat.rnd2 <- read.csv("rnd-data-by-ind-2012-13.csv", header = TRUE, sep = ",", quote = "\"", dec = ".", stringsAsFactors=FALSE, na.strings=c("NA", "", " "))

setwd(json)

dat.pat <- fromJSON(txt = "pat-data-sa3.json") ## expanded dataset, including Francy's PO Boxes
dat.tm <- fromJSON(txt = "tm-data-sa3.json") ## expanded dataset, including Francy's PO Boxes

## for na.strings also try: ^\\s+$|^$
##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
