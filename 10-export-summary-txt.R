#!/usr/bin/env Rscript

##############################################

## restore dataframes
list2env(lst.top15, .GlobalEnv)

##############################################

## export top15 as one TXT

setwd(dest)
if(file.exists("summary-ratios-regional-top15.txt")) file.remove("summary-ratios-regional-top15.txt") ## remove the old file

sink("summary-ratios-regional-top15.txt", append=TRUE)

cat(c("REGIONAL TOP15 SA3 LOCATIONS BY VARIOUS RATIOS (FILTERS APPLIED: !SPECIAL CODES, POP>10K, BIZ>1K, RA!=0[>.5], RA=0[SA4 CAPITAL CITY==FALSE])", "\n"), sep="")
cat(c("\n\n", "REGIONAL TOP15 SA3 LOCATIONS BY (START OF YEAR) AVERAGE BUSINESS COUNTS PER 100 POPULATION, ALL YEARS:", "\n"), sep="")
print(top15.biz.pop)

cat(c("\n\n", "REGIONAL TOP15 SA3 LOCATIONS BY COUNT OF SRIs PER 10k POPULATION, ALL YEARS:", "\n"), sep="")
print(top15.sri.pop)
cat(c("\n\n", "REGIONAL TOP15 SA3 LOCATIONS BY COUNT OF SRIs PER 1k (START OF YEAR) AVERAGE BUSINESS COUNTS, ALL YEARS:", "\n"), sep="")
print(top15.sri.biz)

cat(c("\n\n", "REGIONAL TOP15 SA3 LOCATIONS BY AVERAGE BUSINESS ENTRIES (ACROSS ALL YEARS) PER 10k POPULATION:", "\n"), sep="")
print(top15.ent.pop)
cat(c("\n\n", "REGIONAL TOP15 SA3 LOCATIONS BY AVERAGE BUSINESS ENTRIES (ACROSS ALL YEARS) PER 1k (START OF YEAR) AVERAGE BUSINESS COUNTS:", "\n"), sep="")
print(top15.ent.biz)

cat(c("\n\n", "REGIONAL TOP15 SA3 LOCATIONS BY AVERAGE COUNT (ACROSS ALL YEARS) OF PATENT APPLICATIONS PER 10k POPULATION:", "\n"), sep="")
print(top15.pat.pop)
cat(c("\n\n", "REGIONAL TOP15 SA3 LOCATIONS BY AVERAGE COUNT (ACROSS ALL YEARS) OF PATENT APPLICATIONS PER 1k (START OF YEAR) AVERAGE BUSINESS COUNTS:", "\n"), sep="")
print(top15.pat.biz)

cat(c("\n\n", "REGIONAL TOP15 SA3 LOCATIONS BY AVERAGE COUNT (ACROSS ALL YEARS) OF TRADEMARK APPLICATIONS PER 10k POPULATION:", "\n"), sep="")
print(top15.tm.pop)
cat(c("\n\n", "REGIONAL TOP15 SA3 LOCATIONS BY AVERAGE COUNT (ACROSS ALL YEARS) OF TRADEMARK APPLICATIONS PER 1k (START OF YEAR) AVERAGE BUSINESS COUNTS:", "\n"), sep="")
print(top15.tm.biz)

cat(c("\n\n", "REGIONAL TOP15 SA3 LOCATIONS BY AVERAGE R&D SPEND ($m, ACROSS ALL YEARS) PER 10k POPULATION:", "\n"), sep="")
print(top15.rnd.pop)
cat(c("\n\n", "REGIONAL TOP15 SA3 LOCATIONS BY AVERAGE R&D SPEND ($m, ACROSS ALL YEARS) PER 1k (START OF YEAR) AVERAGE BUSINESS COUNTS:", "\n"), sep="")
print(top15.rnd.biz)

cat(c("\n\n", "REGIONAL TOP15 SA3 STARS - THE MOST FREQUENTLY APPEARING SA3 LOCATIONS ON THE REGIONAL TOP 15 SA3 LISTS ABOVE:", "\n"), sep="")
print(df.stars)

sink()

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
