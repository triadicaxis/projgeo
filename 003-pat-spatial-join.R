#!\usr\bin\env Rscript

## NOTES:
## download shapefile 1270055001_sa3_2011_aust_shape.zip from ABS
## .. from this url: http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/1270.0.55.001July%202011
## source: http://www.r-bloggers.com/things-i-forget-reading-a-shapefile-in-r-with-readogr/
## source: http://stackoverflow.com/questions/24174042/matching-georeferenced-data-with-shape-file-in-r

##############################################

## restore dataframes
list2env(lst.pat, .GlobalEnv)

##############################################

## load packages
library(sp)
library(utils)
library(rgdal)

##############################################

## read shapefile and data
setwd("F:/Work/R-Projects/Geography-Update/Data/Shapefiles")
shp <- readOGR(".", layer="SA3_2011_AUST")
pts.pat <- pat.merged.au

##############################################

## remove all rows with NAs in lat OR lon, spatial join doesn't like them!
pts.pat <- pts.pat[!(is.na(pts.pat$lat)|is.na(pts.pat$lon)), ]

##############################################

## spatial join, make sure that pts.pat is a data.frame
coordinates(pts.pat) <- ~lon+lat
proj4string(pts.pat) <- proj4string(shp)

##############################################

## create new dataframe
dat.pat <- pts.pat %over% shp
dat.pat <- cbind.data.frame(pts.pat, dat.pat)

##############################################

## export CSV to ~/Data/JSON

library(jsonlite)

setwd(json)
js <- toJSON(dat.pat, pretty = TRUE)
cat(js, file = "pat-data-sa3.json")

## to retrieve dataframe again from JSON:
#library(jsonlite)
#setwd(json)
#dat.pat <- fromJSON(txt = "pat-data-sa3.json")

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
