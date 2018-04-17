#!/usr/bin/env Rscript

##############################################

## restore dataframes
list2env(lst.ddf, .GlobalEnv)

##############################################

## select the stars from each df from dat.abs
occ.marker <- ddf.occ$sa3_code %in% df.stars$sa3_code
wge.marker <- ddf.wge$sa3_code %in% df.stars$sa3_code
inc.marker <- ddf.inc$sa3_code %in% df.stars$sa3_code
edu.marker <- ddf.edu$sa3_code %in% df.stars$sa3_code
emp.marker <- ddf.emp$sa3_code %in% df.stars$sa3_code
rnd2.marker <- ddf.rnd2$sa3_code %in% df.stars$sa3_code

stars.occ <- ddf.occ[occ.marker, ]
stars.wge <- ddf.wge[wge.marker, ]
stars.inc <- ddf.inc[inc.marker, ]
stars.edu <- ddf.edu[edu.marker, ]
stars.emp <- ddf.emp[emp.marker, ]
stars.rnd2 <- ddf.rnd2[rnd2.marker, ]

##############################################

## split the dataframe by sa3
lst.occ <- with(stars.occ, split(stars.occ, sa3_code))
lst.wge <- with(stars.wge, split(stars.wge, sa3_code))
lst.inc <- with(stars.inc, split(stars.inc, sa3_code))
lst.edu <- with(stars.edu, split(stars.edu, sa3_code))
lst.emp <- with(stars.emp, split(stars.emp, sa3_code))
lst.rnd2 <- with(stars.rnd2, split(stars.rnd2, sa3_code))

##############################################

## .. by average share of persons employed in each occupation
figs.occ <- lapply(lst.occ,function(x)
     fig <- ggplot(x, aes(x=reorder(anzsco_major_group, avg_employed_percent), y=avg_employed_percent)) +
            geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
            xlab("ANZSCO major group") +
            ylab("Average share of employed by ANZSCO major group (%)") +
            coord_flip() +
            easd.theme2)

## .. by count of wage earners in each occupation
figs.wge <- lapply(lst.wge,function(x)
    fig <- ggplot(x, aes(x=reorder(anzsco_major_group, avg_wage_earners_percent), y=avg_wage_earners_percent)) +
        geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
        xlab("ANZSCO major group") +
        ylab("Average number of wage earners by ANZSCO major group") +
        coord_flip() +
        easd.theme2)

## .. by average income from each income source
figs.inc <- lapply(lst.inc,function(x)
    fig <- ggplot(x, aes(x=reorder(income_measure, avg_annual_income), y=avg_annual_income)) +
        geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
        xlab("Income measure") +
        ylab("Average income by source ($ per year)") +
        coord_flip() +
        easd.theme2)

## .. by average share in the qualification of persons aged 15+ 
figs.edu <- lapply(lst.edu,function(x)
    fig <- ggplot(x, aes(x=reorder(qualification, avg_15plus_pop_percent), y=avg_15plus_pop_percent)) +
        geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
        xlab("Post-school qualification") +
        ylab("Average share of population aged 15+ by qualification (%)") +
        coord_flip() +
        easd.theme2)

## .. by employment status, average number of persons
figs.emp <- lapply(lst.emp,function(x)
    fig <- ggplot(x, aes(x=reorder(anzsic_division, avg_employed_percent), y=avg_employed_percent)) +
        geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
        xlab("ANZSIC division") +
        ylab("Average share of employed by ANZSIC division (%)") +
        coord_flip() +
        easd.theme2)

## .. by business rnd spend, average number of persons
figs.rnd2 <- lapply(lst.rnd2,function(x)
    fig <- ggplot(x, aes(x=reorder(anzsic_div_name, rnd_spend), y=rnd_spend)) +
        geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
        xlab("ANZSIC division") +
        ylab("Business R&D spending by ANZSIC division ($m)") +
        coord_flip() +
        easd.theme2)

##############################################

setwd(paste(figs, "/Stars", sep=""))

invisible(mapply(ggsave, file=paste0(names(figs.occ), " OCC ", asgs.sa$sa3_name[asgs.sa$sa3_code %in% names(figs.occ)], ".png"), plot=figs.occ))
invisible(mapply(ggsave, file=paste0(names(figs.wge), " WGE ", asgs.sa$sa3_name[asgs.sa$sa3_code %in% names(figs.wge)], ".png"), plot=figs.wge))
invisible(mapply(ggsave, file=paste0(names(figs.inc), " INC ", asgs.sa$sa3_name[asgs.sa$sa3_code %in% names(figs.inc)], ".png"), plot=figs.inc))
invisible(mapply(ggsave, file=paste0(names(figs.edu), " EDU ", asgs.sa$sa3_name[asgs.sa$sa3_code %in% names(figs.edu)], ".png"), plot=figs.edu))
invisible(mapply(ggsave, file=paste0(names(figs.emp), " EMP ", asgs.sa$sa3_name[asgs.sa$sa3_code %in% names(figs.emp)], ".png"), plot=figs.emp))
invisible(mapply(ggsave, file=paste0(names(figs.rnd2), " RND ", asgs.sa$sa3_name[asgs.sa$sa3_code %in% names(figs.rnd2)], ".png"), plot=figs.rnd2))

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
