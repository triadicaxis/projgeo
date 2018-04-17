#!/usr/bin/env Rscript

##############################################

## save all dataframes into a list

lst <- lapply(ls(pattern="anzs|asgs|dat|df|filt|ddf"), function(x) get(x)) ## collect all dataframes in a list
names(lst) <- ls(pattern="anzs|asgs|dat|df|filt|ddf") ## add back the dataframe names, RISKY BUT WORKS!!

## cleanup original names, applies to all dataframes that match the pattern in lst

fun1 <- function(x){
    names(x) <- tolower(names(x)) ## all names to lower case
    names(x) <- gsub("x\\.|\\.x", "", names(x)) ## remove all x. or .x from names
    names(x) <- gsub("y\\.|\\.y", "", names(x)) ## remove all y. or .y from names
    names(x) <- gsub("\\.[0-9]", "", names(x)) ## remove all .<num> from names
    names(x) <- gsub("\\.", "", names(x)) ## remove all . from names
    names(x) <- gsub("name11", "name", names(x)) ## replace name11 with name
    names(x) <- gsub("code11", "code", names(x)) ## replace code11 with code
    names(x) <- gsub("x2", "2", names(x)) ## replace x2009, x2010 ... with 2009, 2010 ...
    x}

## specific tweaks to dat.pat and dat.tm

fun2 <- function(x){
    names(x) <- gsub("application_year", "cal_year", names(x)) ## rename application_year to cal_year
    names(x) <- gsub("application_date", "date", names(x)) ## rename application_date to date
    names(x) <- gsub("anzsic_code", "anzsic_cls_code", names(x)) ## rename anzsic_code to anzsic_cls_code
    names(x) <- gsub("type_of_tm", "tm_purpose", names(x)) ## rename to distinguish tm_purpose from tm_type
    x}

lst <- lapply(lst, fun1)
lst <- lapply(lst, fun2)
list2env(lst, .GlobalEnv) ## replace the original dataframes with the renamed ones from the list

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
