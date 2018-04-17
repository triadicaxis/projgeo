#!/usr/bin/env Rscript

##############################################

## match years to business counts data
dat.abs <- dat.abs[dat.abs$fin_year>=2009 & dat.abs$fin_year<=2013, ]

##############################################

## sort data
dat.abs <- dat.abs[order(dat.abs$fin_year, dat.abs$sa3_code, dat.abs$item_code), ]
row.names(dat.abs) <- NULL

## cut dat.abs by indicator

occ <- unique(dat.abs$item_name)[grep("Occupation of Employed Persons", unique(dat.abs$item_name))]
wge <- unique(dat.abs$item_name)[grep("Wage and Salary Earners by Occupation .+\\(%.+", unique(dat.abs$item_name))]
inc <- unique(dat.abs$item_name)[grep("Estimates of Personal Income - Average", unique(dat.abs$item_name))]
edu <- unique(dat.abs$item_name)[grep("Persons with Post School Qualifications - With", unique(dat.abs$item_name))]
emp <- unique(dat.abs$item_name)[grep("Employed by Industry - .+\\(%.+", unique(dat.abs$item_name))]

## subset dat.abs

occ.marker <- grepl("Occupation of Employed Persons", dat.abs$item_name)
wge.marker <- grepl("Wage and Salary Earners by Occupation .+\\(%.+", dat.abs$item_name)
inc.marker <- grepl("Estimates of Personal Income - Average", dat.abs$item_name)
edu.marker <- grepl("Persons with Post School Qualifications - With", dat.abs$item_name)
emp.marker <- grepl("Employed by Industry - .+\\(%.+", dat.abs$item_name)

ddf.occ <- dat.abs[occ.marker, ]
ddf.wge <- dat.abs[wge.marker, ]
ddf.inc <- dat.abs[inc.marker, ]
ddf.edu <- dat.abs[edu.marker, ]
ddf.emp <- dat.abs[emp.marker, ]

## aggregate values

ddf.occ <- aggregate(value ~ sa3_code + item_name, ddf.occ, FUN=mean, na.rm=TRUE)
ddf.wge <- aggregate(value ~ sa3_code + item_name, ddf.wge, FUN=mean, na.rm=TRUE)
ddf.inc <- aggregate(value ~ sa3_code + item_name, ddf.inc, FUN=mean, na.rm=TRUE)
ddf.edu <- aggregate(value ~ sa3_code + item_name, ddf.edu, FUN=mean, na.rm=TRUE)
ddf.emp <- aggregate(value ~ sa3_code + item_name, ddf.emp, FUN=mean, na.rm=TRUE)

ddf.occ <- merge(x=asgs.sa, y=ddf.occ, by="sa3_code", all=TRUE)
ddf.wge <- merge(x=asgs.sa, y=ddf.wge, by="sa3_code", all=TRUE)
ddf.inc <- merge(x=asgs.sa, y=ddf.inc, by="sa3_code", all=TRUE)
ddf.edu <- merge(x=asgs.sa, y=ddf.edu, by="sa3_code", all=TRUE)
ddf.emp <- merge(x=asgs.sa, y=ddf.emp, by="sa3_code", all=TRUE)

##############################################

## trim individual item descriptions from partly generic to specific (cannot reverse from this point on)

ddf.occ$item_name <- gsub("Occupation of Employed Persons - | \\(%)$", "", ddf.occ$item_name)
ddf.wge$item_name <- gsub("Wage and Salary Earners by Occupation - | \\(%)$", "", ddf.wge$item_name)
ddf.inc$item_name <- gsub("Estimates of Personal Income - Average | \\(\\$)$", "", ddf.inc$item_name)
ddf.edu$item_name <- gsub("Persons with Post School Qualifications - With | \\(%)$", "", ddf.edu$item_name)
ddf.emp$item_name <- gsub("Employed by Industry - | \\(%)$", "", ddf.emp$item_name)

##############################################

## change column names from generic to specific (cannot reverse from this point on)

names(ddf.occ) <- c(names(asgs.sa), "anzsco_major_group", "avg_employed_percent")
names(ddf.wge) <- c(names(asgs.sa), "anzsco_major_group", "avg_wage_earners_percent")
names(ddf.inc) <- c(names(asgs.sa), "income_measure", "avg_annual_income") ## average annual income, averaged across years
names(ddf.edu) <- c(names(asgs.sa), "qualification", "avg_15plus_pop_percent")
names(ddf.emp) <- c(names(asgs.sa), "anzsic_division", "avg_employed_percent")

##############################################

## bring in R&D spend by SA3, by ANZSIC (ddf.rnd2)
source("05-make-df-rnd2.R")

##############################################

## save dff.<each> into a list for later use by 'summarise-stars'

lst.ddf <- lapply(ls(pattern="ddf\\."), function(x) get(x)) ## collect all the above dataframes in a list
names(lst.ddf) <- ls(pattern="ddf\\.") ## add back the dataframe names, RISKY BUT WORKS!!

## to retrieve dataframes from list: list2env(lst.ddf, .GlobalEnv)
##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
