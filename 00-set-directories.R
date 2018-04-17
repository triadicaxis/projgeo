#!/usr/bin/env Rscript

##############################################

## clear memory and set up working directories

rm(list=ls())

home <- "F:/Work/R-Projects/Geography-Update" ## path to home directory
src <- paste(home, "/Data/CSV", sep="") ## data source directory, CSV
json <- paste(home, "/Data/JSON", sep="") ## data source directory, JSON
dest <- paste(home, "/Results", sep="") ## results destination directory
figs <- paste(home, "/Charts", sep="") ## charts and figures directory
scri <- paste(home, "/Scripts", sep="") ## R scripts directory
once <- paste(home, "/Scripts/Run-Once", sep="") ## R scripts directory, executed once only
wksp <- paste(home, "/Scripts/Workspace", sep="") ## R workpace history directory
bckp <- paste(home, "/Data/Backup", sep="") ## dataframe backup directory

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")