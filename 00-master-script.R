#!/usr/bin/env Rscript

rm(list=ls())
.rs.restartR() ## restart R session

## IMPORTANT: wait until session fully restarts (about 30 seconds)

##############################################

options(warn=-1) ## -1 to supress warning messages, 0 to turn them back on
setwd("F:/Work/R-Projects/Geography-Update/Scripts")

source("00-set-directories.R")
source("00-set-themes.R")

##############################################
##############################################

## IMPORTANT: execute each line separately, once only, wait until fully executed before running next line

setwd(once)
source("001-read-pat-full.R") ## run separately, takes a while (cca 1 minute)
source("002-merge-pat-full.R") ## run separately, takes a while (cca 1 minutes)
source("003-pat-spatial-join.R") ## run separately, takes a while (cca 1 minute)
.rs.restartR() ## restart R session, wait until session fully restarts (about 30 seconds)

setwd(once)
source("001-read-tm-full.R") ## run separately, takes a while (cca 2 minutes)
source("002-merge-tm-full.R") ## run separately, takes a while (cca 2 minutes)
source("003-tm-spatial-join.R") ## run separately, takes a while (cca 2 minutes)
.rs.restartR() ## restart R session, wait until session fully restarts (about 30 seconds)

##############################################
##############################################

source("01-read-lookups.R")
source("02-read-data.R")
source("04-rename-variables.R")

##############################################

source("05-make-df-sri.R")
source("05-make-df-pop.R")
source("05-make-df-ent.R")

source("05-make-df-pat.R")
source("05-make-df-tm.R")
source("05-make-df-rnd.R")

source("05-make-df-abs.R")

##############################################

source("06-make-df-all.R")
source("06-aus-innov-map.R")

##############################################

source("07-filt1-specials.R")
source("07-filt2-pop-biz.R")
source("07-filt3-regional.R")

##############################################

source("08-filt-combined.R")
source("08-filt-sora.R")

##############################################

source("09-summarise-top15.R")
source("09-summarise-gcc.R")

source("09-diagnostics-sri.R")
source("09-diagnostics-pop.R")
source("09-diagnostics-ent.R")

source("09-diagnostics-pat.R")
source("09-diagnostics-tm.R")
source("09-diagnostics-rnd.R")

##############################################
##############################################

## IMPORTANT: run these individually, line by line

source("10-export-summary-txt.R")
source("10-export-all-csv.R")
source("10-export-summary-charts.R")
source("10-summarise-stars.R")

##############################################

#source("11-analyse-<name1>.R")
#source("11-analyse-<name2>.R")
#source("11-analyse-<name3>.R")

##############################################
