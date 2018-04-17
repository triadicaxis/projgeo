#!/usr/bin/env Rscript

##############################################

## read sora definition table

setwd(src)
df <- read.table("sora-regional-def.csv", header=TRUE, sep=",", stringsAsFactors=FALSE, na.strings=c("NA", "", " "))

## for na.strings also try: ^\\s+$|^$
##############################################

## define filt.sora

df.sora <- df[df$def_name=="Rest of Australia", ]
incl <- df.all$sa3_code %in% df.sora$sa3_code
filt.sora <- df.all[incl, ]

##############################################

## what is the difference between filt.df and filt.sora?

diff1 <- filt.df$sa3_code %in% filt.sora$sa3_code
diff2 <- filt.sora$sa3_code %in% filt.df$sa3_code

df1 <- filt.df[!diff1, ] ## included in our def but missing from sora
df2 <- filt.sora[!diff2, ] ## included in sora but missing from our def

row.names(df1) <- NULL
row.names(df2) <- NULL

## which SA3s are in common?

f1 <- filt.df$sa3_code
f2 <- filt.sora$sa3_code

f <- Reduce(intersect, list(f1, f2)) ## clever trick!
markers <- df.all$sa3_code %in% f
df3 <- df.all[markers, ] ## done.

##############################################

## export CSV for consideration

setwd(paste(dest, "/Compared-With-SORA", sep = ""))
write.table(df1, "sa3-in-our-def-but-excl-from-sora.csv", sep = ",", row.names = FALSE)
write.table(df2, "sa3-in-sora-but-excl-from-our-def.csv", sep = ",", row.names = FALSE)
write.table(df3, "sa3-in-both-sora-and-our-def.csv", sep = ",", row.names = FALSE)

##############################################

## cleanup, save objects, and set directory
setwd(scri)
source("00-cleanup-workspace.R")
