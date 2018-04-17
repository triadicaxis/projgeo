#!\usr\bin\env Rscript

## NOTES:
## download shapefile 1270055001_sa3_2011_aust_shape.zip from ABS
## .. from this url: http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/1270.0.55.001July%202011
## source: http://www.r-bloggers.com/things-i-forget-reading-a-shapefile-in-r-with-readogr/
## source: http://stackoverflow.com/questions/24174042/matching-georeferenced-data-with-shape-file-in-r

##############################################

## restore dataframes
list2env(lst.tm, .GlobalEnv)

##############################################

## load packages
library(sp)
library(utils)
library(rgdal)

##############################################

## read shapefile and data
setwd("F:/Work/R-Projects/Geography-Update/Data/Shapefiles")
shp <- readOGR(".", layer="SA3_2011_AUST")
pts.tm <- tm.merged.au

##############################################

## remove all rows with NAs in lat OR lon, spatial join doesn't like them!
pts.tm <- pts.tm[!(is.na(pts.tm$lat)|is.na(pts.tm$lon)), ]

##############################################

## spatial join, make sure that pts.tm is a data.frame
coordinates(pts.tm) <- ~lon+lat
proj4string(pts.tm) <- proj4string(shp)

##############################################

## create new dataframe
dat.tm <- pts.tm %over% shp
dat.tm <- cbind.data.frame(pts.tm, dat.tm)

##############################################

## export CSV to ~/Data/JSON

library(jsonlite)

setwd(json)
js <- toJSON(dat.tm, pretty = TRUE)
cat(js, file = "tm-data-sa3.json")

## to retrieve dataframe again from JSON:
#library(jsonlite)
#setwd(json)
#dat.tm <- fromJSON(txt = "tm-data-sa3.json")

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
