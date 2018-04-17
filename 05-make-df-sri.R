#!/usr/bin/env Rscript

##############################################

## create a column of SRI counts and bind it to dat.sri
sri_count <- rep(1, times=nrow(dat.sri))
dat.sri <- cbind(dat.sri, sri_count) ## important in order to obtain counts

##############################################

## create df.sri

df1 <- dat.sri[which(grepl("University - Main", dat.sri$org_type)), ] ## nrow(df1) = sum of uni_main across Australia
df2 <- dat.sri[which(grepl("University - Other", dat.sri$org_type)), ]
df3 <- subset(dat.sri, group_name=="CSIRO")
df4 <- dat.sri[which(grepl("Cooperative Research Centre", dat.sri$org_type)), ]
df5 <- dat.sri[which(grepl("Research Service Provider", dat.sri$org_type)), ]
df6 <- dat.sri[which(grepl("Excellence", dat.sri$org_type)), ]

df1 <- aggregate(sri_count ~ sa3_code, df1, FUN=sum, na.rm=TRUE) ## aggregate uni_main_count by sa3_code
df2 <- aggregate(sri_count ~ sa3_code, df2, FUN=sum, na.rm=TRUE)
df3 <- aggregate(sri_count ~ sa3_code, df3, FUN=sum, na.rm=TRUE)
df4 <- aggregate(sri_count ~ sa3_code, df4, FUN=sum, na.rm=TRUE)
df5 <- aggregate(sri_count ~ sa3_code, df5, FUN=sum, na.rm=TRUE)
df6 <- aggregate(sri_count ~ sa3_code, df6, FUN=sum, na.rm=TRUE)

names(df1) <- c("sa3_code", "uni_main_count") ## set column names
names(df2) <- c("sa3_code", "uni_other_count")
names(df3) <- c("sa3_code", "csiro_count")
names(df4) <- c("sa3_code", "crc_count")
names(df5) <- c("sa3_code", "rsp_count")
names(df6) <- c("sa3_code", "coe_count")

df <- merge(asgs.sa, df1, by="sa3_code", all=TRUE) ## merge each into df
df <- merge(df, df2, by="sa3_code", all=TRUE)
df <- merge(df, df3, by="sa3_code", all=TRUE)
df <- merge(df, df4, by="sa3_code", all=TRUE)
df <- merge(df, df5, by="sa3_code", all=TRUE)
df <- merge(df, df6, by="sa3_code", all=TRUE)

df[is.na(df)] <- 0 ## NAs get zero
df[is.na(df)] <- 0
df[is.na(df)] <- 0
df[is.na(df)] <- 0
df[is.na(df)] <- 0
df[is.na(df)] <- 0

## add a total SRI column to df
total_sri_count <- as.data.frame(rowSums(df[ ,(ncol(df)-5):ncol(df)]))
names(total_sri_count) <- "total_sri_count"

## create df.sri
df.sri <- cbind(df, total_sri_count) ## done.

##############################################

## merge SRI counts into dat.sri
df <- subset(df, select=c(sa3_code, uni_main_count, uni_other_count, csiro_count, crc_count, rsp_count, coe_count)) ## exclude total_sri_count
dat.sri <- merge(dat.sri, df, by="sa3_code", all=FALSE) ## done.

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
