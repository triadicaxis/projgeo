#!/usr/bin/env Rscript

##############################################

## restore dataframes
list2env(lst.tm, .GlobalEnv)

##############################################

## fix ANZSIC variable name
n <- names(tm202[2:length(names(tm202))])
names(tm202) <- c("anzsic_code", n)

## convert all classifying variables into class = character
tm201$tm_number <- as.integer(tm201$tm_number)
tm201$postcode <- as.character(tm201$postcode)
tm201$applicant_no <- as.character(tm201$applicant_no)

tm202$anzsic_code <- as.character(tm202$anzsic_code)
tm202$abn <- as.character(tm202$abn) ## abn variable missing, find out why
tm202$acn <- as.character(tm202$acn)
tm202$ipa_applt_id <- as.character(tm202$ipa_applt_id)
tm202$tm_number <- as.character(tm202$tm_number)
tm202$ipa_id <- as.character(tm202$ipa_id)
tm202$ipa_abn <- as.character(tm202$ipa_abn)
tm202$ipa_acn <- as.character(tm202$ipa_acn)
tm202$patstat_appln_id <- as.character(tm202$patstat_appln_id)

##############################################

## merge tm+ipgod, subset Australia, and sort tha data by year

tm.merged <- merge(x=tm202, y=tm201, by="tm_number", all=FALSE) ## keeps only matched data, consistent with Francy's

#tm.merged.au <- tm.merged[tm.merged$country.x=="AU" | tm.merged$country.y=="AU", ] ## subset Australia only, more comprehensive
tm.merged.au <- tm.merged[tm.merged$country.x=="AU", ] ## subset Australia only, consistent with Francy's data
tm.merged.au <- tm.merged.au[order(tm.merged.au$application_year, tm.merged.au$anzsic_code), ] ## sort by year, by anzsic
row.names(tm.merged.au) <- NULL

##############################################

## only interested in years 2008 onwards, and Australian applicants
tm.merged.au <- tm.merged.au[tm.merged.au$application_year >= 2008, ]
tm.merged.au <- tm.merged.au[tm.merged.au$application_year <= 2014, ]
tm.merged.au$australian.x <- as.integer(tm.merged.au$australian.x) ## convert into class = integer
tm.merged.au$australian.y <- as.integer(tm.merged.au$australian.y) ## convert into class = integer

##############################################

## delete tm.merged
rm(tm.merged)

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
