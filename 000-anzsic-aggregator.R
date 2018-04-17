#!\usr\bin\env Rscript

##############################################

## Notes:

## anzsic-06.csv downloaded from here http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/1292.0.55.0022006?OpenDocument
## ..use only 'Classes' worksheet, save as anzsic-06.csv, rename column headers as v1, v2, .., v5
## anzsic-06-rev1.csv downloaded from here http://www.abs.gov.au/AUSSTATS/abs@.nsf/DetailsPage/1292.0.55.0042006%20(Revision%201.0)?OpenDocument
## ..use only 'Table1' worksheet, save as anzsic-06-rev1.csv, rename column headers as v1, v2

## Regular expressions: https:\\stat.ethz.ch\R-manual\R-devel\library\base\html\regex.html
## Regular expressions: http:\\www.endmemo.com\program\R\grep.php

##############################################

## clear memory and set up working directories
rm(list=ls())
home <- "G:/OCE/ASB/Innovation Research/2. Research projects/Geography of Innovation/Update" ## path to home directory
src <- paste(home, "/Data/CSV", sep="") ## anzsic source directory
dest <- paste(home, "/Data/ANZSIC", sep="") ## results destination directory
scri <- paste(home, "/Scripts/Run-Once", sep="") ## R scripts directory

## read original ANZSIC 2006 and Revision 1 tables
setwd(src)
anzsic <- read.table("anzsic-06.csv", sep=",", header=TRUE, stringsAsFactors=FALSE, na.strings=c("NA", "", " "))
rev1 <- read.table("anzsic-06-rev1.csv", sep=",", header=TRUE, stringsAsFactors=FALSE, na.strings=c("NA", "", " "))

##############################################

## extract ANZSIC divisions (letters)
x <- grepl("^[A-Z]$", anzsic$v1)
df.div <- subset(anzsic, x, select=c(v1, v2))
names(df.div) <- c("div_code", "div_name")

## extract ANZSIC sub-divisions (1-2 digits)
x <- grepl("^[0-9]{1,2}$", anzsic$v2)
df.sub <- subset(anzsic, x, select=c(v2, v3))
names(df.sub) <- c("sub_code", "sub_name")

## extract ANZSIC groups (2-3 digits)
x <- grepl("^[0-9]{2,3}$", anzsic$v3)
df.grp <- subset(anzsic, x, select=c(v3, v4))
names(df.grp) <- c("grp_code", "grp_name")

## extract ANZSIC classes (3-4 digits)
x <- grepl("^[0-9]{3,4}$", anzsic$v4)
df.cls <- subset(anzsic, x, select=c(v4, v5))
names(df.cls) <- c("cls_code", "cls_name")

rm(x)

##############################################

## extract all non-NA rows from Revision 1 (revised ANZSIC primary activities)
y <- !is.na(rev1$v1)
df.act <- subset(rev1, y, select=c(v1, v2))
names(df.act) <- c("cls_code", "act_name")

rm(y)

##############################################

## find duplicates and their frequencies, sort descending
tbl.act <- data.frame(unlist(table(df.act$cls_code)))
tbl.act <- tbl.act[order(-tbl.act$Freq), ]
tbl.act$Var1 <- as.character(tbl.act$Var1)
names(tbl.act) <- c("cls_code", "act_count")

## recombine ANSZIC 2006 classes with Revision 1 activities
df.act2 <- merge(x=df.cls, y=df.act, by=1, all=TRUE)
names(df.act2) <- c("cls_code", "cls_name", "act_name")

##############################################

## prepare new code columns, bind them to df

df <- anzsic

div_code <- as.character(anzsic$v1)
sub_code <- as.character(anzsic$v2)
grp_code <- as.character(anzsic$v3)
cls_code <- as.character(anzsic$v4)

df <- cbind(df, div_code, sub_code, grp_code, cls_code)

##############################################

## fill out missing values

## .. cls code
for (i in 3:nrow(df)) {
    if (grepl("^[0-9]{3,4}$", df$cls_code[i])) {
        df$cls_code[i] <- df$cls_code[i]
    } else if (is.na(df$cls_code[i])) {
        df$cls_code[i] <- df$cls_code[i-1]
    } else
        df$cls_code[i] <- NA
}

## .. grp code
for (i in 2:nrow(df)) {
    if (grepl("^[0-9]{2,3}$", df$grp_code[i])) {
        df$grp_code[i] <- df$grp_code[i]
    } else if (is.na(df$grp_code[i])) {
        df$grp_code[i] <- df$grp_code[i-1]
    } else
        df$grp_code[i] <- NA
}

## .. sub code
for (i in 1:nrow(df)) {
    if (grepl("^[0-9]{1,2}$", df$sub_code[i])) {
        df$sub_code[i] <- df$sub_code[i]
    } else if (is.na(df$sub_code[i])) {
        df$sub_code[i] <- df$sub_code[i-1]
    } else
        df$sub_code[i] <- NA
}

## .. div code
for (i in 1:nrow(df)) {
    if (is.na(df$div_code[i])) {
        df$div_code[i] <- df$div_code[i-1]
    } else {
        df$div_code[i] <- df$div_code[i]
    }
}

##############################################

## merge dataframes

lst <- list(df, df.cls, df.grp, df.sub, df.div) ## could also include tbl.act
df <- Reduce(function(x, y) merge(x, y, all=TRUE), lst)

df <- subset(df, select=c(div_code, div_name, sub_code, sub_name, grp_code, grp_name, cls_code, cls_name)) ## could also include act_count
df <- df[with(df, order(div_code, sub_code, grp_code, cls_code)), ]
row.names(df) <- NULL

df <- df[complete.cases(df), ]

##############################################

## export results to destination directory

setwd(dest)
write.table(df.div, "anzsic-div.csv", sep=",", row.names=FALSE)
write.table(df.sub, "anzsic-sub.csv", sep=",", row.names=FALSE)
write.table(df.grp, "anzsic-grp.csv", sep=",", row.names=FALSE)
write.table(df.cls, "anzsic-cls.csv", sep=",", row.names=FALSE)
write.table(df.act2, "rev1-act.csv", sep=",", row.names=FALSE)
write.table(df, "anzsic-full.csv", sep=",", row.names=FALSE)

## copy file to ~/Data/CSV
file.copy(from="anzsic-full.csv", 
          to="G:/OCE/ASB/Innovation Research/2. Research projects/Geography of Innovation/Update/Data/CSV/anzsic-full.csv") 

##############################################

## clean up and save
