#!/usr/bin/env Rscript

##############################################

## read lookup tables

setwd(src)

anzsic.div <- read.table("lookup-anzsic06-div.csv", header=TRUE, sep=",", stringsAsFactors=FALSE, na.strings=c("NA", "", " "))
anzsic.cls <- read.table("lookup-anzsic06-cls.csv", header=TRUE, sep=",", stringsAsFactors=FALSE, na.strings=c("NA", "", " "))
asgs.sa <- read.table("lookup-asgs-vol1-sa.csv", header=TRUE, sep=",", stringsAsFactors=FALSE, na.strings=c("NA", "", " "))
asgs.ra <- read.table("lookup-asgs-vol5-ra.csv", header=TRUE, sep=",", stringsAsFactors=FALSE, na.strings=c("NA", "", " "))

## for na.strings also try: ^\\s+$|^$
##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
