#!/usr/bin/env Rscript

##############################################

## tweak original data
dat.rnd2 <- merge(x=anzsic.div, y=dat.rnd2, by="anzsic_div_code", all=TRUE) ## merge with anzsic.div
dat.rnd2$rnd_spend <- as.numeric(dat.rnd2$rnd_spend) ## coerce into numeric
dat.rnd2$rnd_spend <- round(dat.rnd2$rnd_spend/1000000, 1) ## scale rnd spend to $ millions

##############################################

## aggregate rnd_spend by ANZSIC division, by SA3s
df <- aggregate(rnd_spend ~ anzsic_div_code + sa3_code, dat.rnd2, FUN=sum, na.rm=TRUE) ## sum, by anzsic, by SA3
df <- merge(x=anzsic.div, y=df, by="anzsic_div_code", all=TRUE)
df <- merge(x=asgs.sa, y=df, by="sa3_code", all=TRUE)

ddf.rnd2 <- df

##############################################

## DO NOT CLEANUP!
