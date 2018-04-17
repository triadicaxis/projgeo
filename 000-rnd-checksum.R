#!/usr/bin/env Rscript

##############################################

## check that our rnd.ex (data for the national innovation map) is the same as the original

x <- subset(dat.rnd, select=c(sa3_code, sa3_name, fin_year, rnd_spend))
x <- x[order(x$sa3_code, x$fin_year), ]
row.names(x) <- NULL

y <- subset(rnd.ex, select=c(sa3_code, sa3_name, fin_year, rnd_spend))
y <- y[order(y$sa3_code, y$fin_year), ]
row.names(y) <- NULL

x[!(x$rnd_spend %in% y$rnd_spend), ] ## check: <0 rows> if correct

##############################################

## cleanup, save objects, and set directory

setwd(scri)