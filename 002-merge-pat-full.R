#!/usr/bin/env Rscript

##############################################

## restore dataframes
list2env(lst.pat, .GlobalEnv)

##############################################

## fix ANZSIC variable name
n <- names(pat102[2:length(names(pat102))])
names(pat102) <- c("anzsic_code", n)

## convert all classifying variables into class = character
pat101$australian_appl_no <- as.character(pat101$australian_appl_no)

pat102$australian_appl_no <- as.character(pat102$australian_appl_no)
pat102$anzsic_code <- as.character(pat102$anzsic_code)
pat102$abn <- as.character(pat102$abn)
pat102$acn <- as.character(pat102$acn)
pat102$ipa_applt_id <- as.character(pat102$ipa_applt_id)
pat102$ipa_id <- as.character(pat102$ipa_id)
pat102$ipa_abn <- as.character(pat102$ipa_abn)
pat102$ipa_acn <- as.character(pat102$ipa_acn)
pat102$patstat_appln_id <- as.character(pat102$patstat_appln_id)

##############################################

## merge pat+pat101, subset Australia, and sort tha data by year

pat.merged <- merge(x=pat102, y=pat101, by="australian_appl_no", all=FALSE) ## keeps only matched data, consistent with Francy's

#pat.merged.au <- pat.merged[pat.merged$country.x=="AU" | pat.merged$country.y=="AU", ] ## subset Australia only, more comprehensive
pat.merged.au <- pat.merged[pat.merged$country.x=="AU", ] ## subset Australia only, consistent with Francy's data
pat.merged.au <- pat.merged.au[order(pat.merged.au$application_year, pat.merged.au$anzsic_code), ] ## sort by year, by anzsic
row.names(pat.merged.au) <- NULL

##############################################

## only interested in years 2008 onwards, and Australian applicants
pat.merged.au <- pat.merged.au[pat.merged.au$application_year >= 2008, ]
pat.merged.au <- pat.merged.au[pat.merged.au$application_year <= 2014, ]
pat.merged.au$australian.x <- as.integer(pat.merged.au$australian.x) ## convert into class = integer
pat.merged.au$australian.y <- as.integer(pat.merged.au$australian.y) ## convert into class = integer

## convert big.x into class = integer
pat.merged.au$big.x <- as.integer(pat.merged.au$big.x)
pat.merged.au$big.x[is.na(pat.merged.au$big.x)] <- 0

##############################################

## delete pat.merged
rm(pat.merged)

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
