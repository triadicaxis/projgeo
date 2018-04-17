#!/usr/bin/env Rscript

##############################################

## Conceptual framework behind FILTER 3:

## SA3s are divided into 'cities' or 'non-cities', based on ra_code
## Cities are further divided into 'capital' and 'non-capital', based on sa4_name
## Non-cities are further divided into 'more remote' and 'less remote', based on the fraction of people living remotely
## The 'regional subset' (filt3.df) is defined as 'non-capital SA3s' + 'more remote SA3s'

##############################################

## extract only the 2nd digits of ra_code (note that 0=city, !0=non-city)
ra <- as.numeric(substr(asgs.ra$ra_code, start=2, stop=2)) ## vector of length=asgs.ra

##############################################

## CITY SUB-FILTER: identify 'non-capital city' SA3s

## .. identify all cities
city <- ra==0 ## include any SA3 that is a 'city'
df.city <- subset(asgs.ra, city) ## the 'city' subset, excluding all 'remote areas'
df.city <- merge(x=df.city, y=subset(asgs.sa, select=c(sa3_code, sa4_name)), by="sa3_code", all=FALSE)
row.names(df.city) <- NULL

## .. identify capital cities

x1 <- grepl("Sydney", df.city$sa4_name) ## T/F vector of length=df.city, with Sydney in sa4_name
x2 <- grepl("Melbourne", df.city$sa4_name) ## T/F vector of length=df.city, with Melbourne in sa4_name
x3 <- grepl("Brisbane", df.city$sa4_name) ## T/F vector of length=df.city, with Brisbane in sa4_name
x4 <- grepl("Perth", df.city$sa4_name) ## T/F vector of length=df.city, with Perth in sa4_name
x5 <- grepl("Adelaide", df.city$sa4_name) ## T/F vector of length=df.city, with Adelaide in sa4_name
x6 <- grepl("Hobart", df.city$sa4_name) ## T/F vector of length=df.city, with Hobart in sa4_name
x7 <- grepl("Darwin", df.city$sa4_name) ## T/F vector of length=df.city, with Darwin in sa4_name
x8 <- grepl("Australian Capital Territory", df.city$sa4_name) ## T/F vector of length=df.city, with Australian Capital Territory in sa4_name

cap.city <- ifelse(x1==TRUE | x2==TRUE | x3==TRUE | x4==TRUE | x5==TRUE | x6==TRUE | x7==TRUE | x8==TRUE, TRUE, FALSE)

## .. dataframe of non-capital cities
noncap.city <- df.city[!cap.city, ]
names(noncap.city) <- c("sa3_code", "sa3_name", "ra_code", "ra_name", "fraction_city", "sa4_name")
row.names(noncap.city) <- NULL ## done.

##############################################

## REMOTENESS SUB-FILTER: identify 'more remote' SA3s

## .. identify all remote SA3s, regardless of the fraction of population living remotely
remote <- ra!=0 ## include any SA3 that's not a 'city'
df.remote <- subset(asgs.ra, remote) ## the 'remote areas' subset, excluding all 'cities'
df.remote <- merge(x=df.remote, y=subset(asgs.sa, select=c(sa3_code, sa4_name)), by="sa3_code", all=FALSE)
row.names(df.remote) <- NULL

## .. aggregate df.remote by SA3
y1 <- aggregate(fraction ~ sa3_code, df.remote, FUN=sum, na.rm=TRUE) ## aggregate remote fractions by SA3
more.remote <- y1[y1$fraction>=0.5, ] ## at least 50% residents live remotely

## .. dataframe of more remote SA3s
more.remote <- merge(x=subset(asgs.sa, select=c(sa3_code, sa3_name, sa4_name)), y=more.remote, by="sa3_code", all=FALSE)
names(more.remote) <- c("sa3_code", "sa3_name", "sa4_name", "fraction_remote")
row.names(more.remote) <- NULL ## done.

##############################################

## FILTER 3: REGIONAL SUBSET (NO DATA): non-capital cities + more remote

x.city <- subset(noncap.city, select=c(sa3_code, fraction_city))
y.remote <- subset(more.remote, select=c(sa3_code, fraction_remote))
df.sa <- subset(asgs.sa, select=c(sa3_code, sa3_name, sa4_name))

df <- Reduce(function(x, y) merge(x, y, all=TRUE), list(x.city, y.remote)) ## to check which SA3s are both 'non-capital cities' and 'more remote', set all=FALSE
df <- merge(x=df.sa, y=df, by="sa3_code", all=FALSE)

## FILTER 3: REGIONAL SUBSET (WITH DATA): bind data to df

markers <- df.all$sa3_code %in% df$sa3_code
filt3.df <- data.frame(subset(df, select=c(fraction_city, fraction_remote)), df.all[markers, ])
filt3.df <- filt3.df[ ,c(3:10, 1:2, 11:length(names(filt3.df)))] ## reorder columns. done.

##############################################

## FILTER 3 ADJUSTMENT: remove capitals that snuck back in via the REMOTENESS SUB-FILTER (just repeat routine from df.city)

x1 <- grepl("Sydney", filt3.df$sa4_name) ## T/F vector of length=filt3.df, with Sydney in sa4_name
x2 <- grepl("Melbourne", filt3.df$sa4_name) ## T/F vector of length=filt3.df, with Melbourne in sa4_name
x3 <- grepl("Brisbane", filt3.df$sa4_name) ## T/F vector of length=filt3.df, with Brisbane in sa4_name
x4 <- grepl("Perth", filt3.df$sa4_name) ## T/F vector of length=filt3.df, with Perth in sa4_name
x5 <- grepl("Adelaide", filt3.df$sa4_name) ## T/F vector of length=filt3.df, with Adelaide in sa4_name
x6 <- grepl("Hobart", filt3.df$sa4_name) ## T/F vector of length=filt3.df, with Hobart in sa4_name
x7 <- grepl("Darwin", filt3.df$sa4_name) ## T/F vector of length=filt3.df, with Darwin in sa4_name
x8 <- grepl("Australian Capital Territory", filt3.df$sa4_name) ## T/F vector of length=filt3.df, with Australian Capital Territory in sa4_name

cap.city <- ifelse(x1==TRUE | x2==TRUE | x3==TRUE | x4==TRUE | x5==TRUE | x6==TRUE | x7==TRUE | x8==TRUE, TRUE, FALSE)

## .. dataframe of non-capital cities
filt3.df <- filt3.df[!cap.city, ]
row.names(filt3.df) <- NULL ## done.

##############################################

## checks and balances

incl <- df.all$sa3_code %in% filt3.df$sa3_code ## T/F vector length(df.all) of included SA3s
filt3.dropped <- df.all[!incl, ] ## check: which SA3s have been excluded?
rm(incl)

##############################################

## more checks and balances

length(unique(df.city$sa3_code))==nrow(df.city) ## check: no need to aggregate 'cities' unless FALSE
length(unique(more.remote$sa3_code))==nrow(more.remote) ## check: TRUE if 'more remote' SA3s aggregated correctly
length(unique(filt3.df$sa3_code))==nrow(filt3.df) ## check: TRUE if 'regional subset' aggregated correctly
#nrow(noncap.city)+nrow(more.remote)==sum(!is.na(filt3.df$fraction_city)) + sum(!is.na(filt3.df$fraction_remote)) ## check: TRUE if 'regional subset' = 'non-capital cities' + 'more remote SA3s'

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
