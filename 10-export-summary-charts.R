#!/usr/bin/env Rscript

##############################################

## restore dataframes: SA3
list2env(lst.top15, .GlobalEnv)

##############################################

## CHARTS:

## prepare dataframes for charts: SA3

fig01 <- subset(top15.biz.pop, select=c(sa3_name, avg_biz_per_100_pop))

fig02 <- subset(top15.sri.pop, select=c(sa3_name, sri_per_10k_pop))
fig03 <- subset(top15.sri.biz, select=c(sa3_name, sri_per_1k_biz))

fig04 <- subset(top15.ent.pop, select=c(sa3_name, avg_ent_per_10k_pop))
fig05 <- subset(top15.ent.biz, select=c(sa3_name, avg_ent_per_1k_biz))

fig06 <- subset(top15.pat.pop, select=c(sa3_name, avg_pat_per_10k_pop))
fig07 <- subset(top15.pat.biz, select=c(sa3_name, avg_pat_per_1k_biz))

fig08 <- subset(top15.tm.pop, select=c(sa3_name, avg_tm_per_10k_pop))
fig09 <- subset(top15.tm.biz, select=c(sa3_name, avg_tm_per_1k_biz))

fig10 <- subset(top15.rnd.pop, select=c(sa3_name, avg_rnd_per_10k_pop))
fig11 <- subset(top15.rnd.biz, select=c(sa3_name, avg_rnd_per_1k_biz))

## prepare dataframes for charts: GCCSA

fig12 <- subset(df.gcc, select=c(gcc_name, sri_per_10k_pop))
fig13 <- subset(df.gcc, select=c(gcc_name, sri_per_1k_biz))

fig14 <- subset(df.gcc, select=c(gcc_name, avg_ent_per_10k_pop))
fig15 <- subset(df.gcc, select=c(gcc_name, avg_ent_per_1k_biz))

fig16 <- subset(df.gcc, select=c(gcc_name, avg_pat_per_10k_pop))
fig17 <- subset(df.gcc, select=c(gcc_name, avg_pat_per_1k_biz))

fig18 <- subset(df.gcc, select=c(gcc_name, avg_tm_per_10k_pop))
fig19 <- subset(df.gcc, select=c(gcc_name, avg_tm_per_1k_biz))

fig20 <- subset(df.gcc, select=c(gcc_name, avg_rnd_per_10k_pop))
fig21 <- subset(df.gcc, select=c(gcc_name, avg_rnd_per_1k_biz))

##############################################

## save figs into a list for later use by Shiny app

lst.figs <- lapply(ls(pattern="fig[0-9]+"), function(x) get(x)) ## collect all the above dataframes in a list
names(lst.figs) <- ls(pattern="fig[0-9]+") ## add back the dataframe names, RISKY BUT WORKS!!

##############################################

library("ggplot2")

## chart: Top15 regions, by Business counts per 100 inhabitants
fig01 <- ggplot(fig01, aes(x=reorder(sa3_name, avg_biz_per_100_pop), y=avg_biz_per_100_pop)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("SA3 region") +
    ylab("Business counts per 100 inhabitants") +
    coord_flip() +
    easd.theme

## chart: Top15 regions, by SRI counts per 10k inhabitants
fig02 <- ggplot(fig02, aes(x=reorder(sa3_name, sri_per_10k_pop), y=sri_per_10k_pop)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("SA3 region") +
    ylab("SRI counts per 10k inhabitants") +
    coord_flip() +
    easd.theme

## chart: Top15 regions, by SRI counts per 1k businesses
fig03 <- ggplot(fig03, aes(x=reorder(sa3_name, sri_per_1k_biz), y=sri_per_1k_biz)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("SA3 region") +
    ylab("SRI counts per 1k businesses") +
    coord_flip() +
    easd.theme

## chart: Top15 regions, by Net entries per 10k inhabitants
fig04 <- ggplot(fig04, aes(x=reorder(sa3_name, avg_ent_per_10k_pop), y=avg_ent_per_10k_pop)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("SA3 region") +
    ylab("Net entries per 10k inhabitants") +
    coord_flip() +
    easd.theme

## chart: Top15 regions, by Net entries per 1k businesses
fig05 <- ggplot(fig05, aes(x=reorder(sa3_name, avg_ent_per_1k_biz), y=avg_ent_per_1k_biz)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("SA3 region") +
    ylab("Net entries per 1k businesses") +
    coord_flip() +
    easd.theme

## chart: Top15 regions, by Patent applications per 10k inhabitants
fig06 <- ggplot(fig06, aes(x=reorder(sa3_name, avg_pat_per_10k_pop), y=avg_pat_per_10k_pop)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("SA3 region") +
    ylab("Patent applications per 10k inhabitants") +
    coord_flip() +
    easd.theme

## chart: Top15 regions, by Patent applications per 1k businesses
fig07 <- ggplot(fig07, aes(x=reorder(sa3_name, avg_pat_per_1k_biz), y=avg_pat_per_1k_biz)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("SA3 region") +
    ylab("Patent applications per 1k businesses") +
    coord_flip() +
    easd.theme

## chart: Top15 regions, by Trademark applications per 10k inhabitants
fig08 <- ggplot(fig08, aes(x=reorder(sa3_name, avg_tm_per_10k_pop), y=avg_tm_per_10k_pop)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("SA3 region") +
    ylab("Trademark applications per 10k inhabitants") +
    coord_flip() +
    easd.theme

## chart: Top15 regions, by Trademark applications per 1k businesses
fig09 <- ggplot(fig09, aes(x=reorder(sa3_name, avg_tm_per_1k_biz), y=avg_tm_per_1k_biz)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("SA3 region") +
    ylab("Trademark applications per 1k businesses") +
    coord_flip() +
    easd.theme

## chart: Top15 regions, by Business R&D spend per 10k inhabitants
fig10 <- ggplot(fig10, aes(x=reorder(sa3_name, avg_rnd_per_10k_pop), y=avg_rnd_per_10k_pop)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("SA3 region") +
    ylab("Business R&D spend per 10k inhabitants ($m)") +
    coord_flip() +
    easd.theme

## chart: Top15 regions, by Business R&D spend per 1k businesses
fig11 <- ggplot(fig11, aes(x=reorder(sa3_name, avg_rnd_per_1k_biz), y=avg_rnd_per_1k_biz)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("SA3 region") +
    ylab("Business R&D spend per 1k businesses ($m)") +
    coord_flip() +
    easd.theme

##############################################

## charts: GCCSA

## chart: GCCSA, by SRI counts per 10k inhabitants
fig12 <- ggplot(fig12, aes(x=reorder(gcc_name, sri_per_10k_pop), y=sri_per_10k_pop)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("GCC statistical area") +
    ylab("SRI counts per 10k inhabitants") +
    coord_flip() +
    easd.theme

## chart: GCCSA, by SRI counts per 1k businesses
fig13 <- ggplot(fig13, aes(x=reorder(gcc_name, sri_per_1k_biz), y=sri_per_1k_biz)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("GCC statistical area") +
    ylab("SRI counts per 1k businesses") +
    coord_flip() +
    easd.theme

## chart: GCCSA, by Net entries per 10k inhabitants
fig14 <- ggplot(fig14, aes(x=reorder(gcc_name, avg_ent_per_10k_pop), y=avg_ent_per_10k_pop)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("GCC statistical area") +
    ylab("Net entries per 10k inhabitants") +
    coord_flip() +
    easd.theme

## chart: GCCSA, by Net entries per 1k businesses
fig15 <- ggplot(fig15, aes(x=reorder(gcc_name, avg_ent_per_1k_biz), y=avg_ent_per_1k_biz)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("GCC statistical area") +
    ylab("Net entries per 1k businesses") +
    coord_flip() +
    easd.theme

## chart: GCCSA, by Patent applications per 10k inhabitants
fig16 <- ggplot(fig16, aes(x=reorder(gcc_name, avg_pat_per_10k_pop), y=avg_pat_per_10k_pop)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("GCC statistical area") +
    ylab("Patent applications per 10k inhabitants") +
    coord_flip() +
    easd.theme

## chart: GCCSA, by Patent applications per 1k businesses
fig17 <- ggplot(fig17, aes(x=reorder(gcc_name, avg_pat_per_1k_biz), y=avg_pat_per_1k_biz)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("GCC statistical area") +
    ylab("Patent applications per 1k businesses") +
    coord_flip() +
    easd.theme

## chart: GCCSA, by Trademark applications per 10k inhabitants
fig18 <- ggplot(fig18, aes(x=reorder(gcc_name, avg_tm_per_10k_pop), y=avg_tm_per_10k_pop)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("GCC statistical area") +
    ylab("Trademark applications per 10k inhabitants") +
    coord_flip() +
    easd.theme

## chart: GCCSA, by Trademark applications per 1k businesses
fig19 <- ggplot(fig19, aes(x=reorder(gcc_name, avg_tm_per_1k_biz), y=avg_tm_per_1k_biz)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("GCC statistical area") +
    ylab("Trademark applications per 1k businesses") +
    coord_flip() +
    easd.theme

## chart: GCCSA, by Business R&D spend per 10k inhabitants
fig20 <- ggplot(fig20, aes(x=reorder(gcc_name, avg_rnd_per_10k_pop), y=avg_rnd_per_10k_pop)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("GCC statistical area") +
    ylab("Business R&D spend per 10k inhabitants ($m)") +
    coord_flip() +
    easd.theme

## chart: GCCSA, by Business R&D spend per 1k businesses
fig21 <- ggplot(fig21, aes(x=reorder(gcc_name, avg_rnd_per_1k_biz), y=avg_rnd_per_1k_biz)) +
    geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
    xlab("GCC statistical area") +
    ylab("Business R&D spend per 1k businesses ($m)") +
    coord_flip() +
    easd.theme

##############################################

## export figures to charts directory

setwd(figs)

print(fig01)
ggsave("regional-top15-avg-biz-counts-per-100-pop.png", width = 2.55, height = 2.9, dpi = 120)

print(fig02)
ggsave("regional-top15-sri-counts-per-10k-pop.png", width = 2.55, height = 2.9, dpi = 120)

print(fig03)
ggsave("regional-top15-sri-counts-per-1k-biz.png", width = 2.55, height = 2.9, dpi = 120)

print(fig04)
ggsave("regional-top15-avg-netent-per-10k-pop.png", width = 2.55, height = 2.9, dpi = 120)

print(fig05)
ggsave("regional-top15-avg-netent-per-1k-biz.png", width = 2.55, height = 2.9, dpi = 120)

print(fig06)
ggsave("regional-top15-avg-pat-per-10k-pop.png", width = 2.55, height = 2.9, dpi = 120)

print(fig07)
ggsave("regional-top15-avg-pat-per-1k-biz.png", width = 2.55, height = 2.9, dpi = 120)

print(fig08)
ggsave("regional-top15-avg-tm-per-10k-pop.png", width = 2.55, height = 2.9, dpi = 120)

print(fig09)
ggsave("regional-top15-avg-tm-per-1k-biz.png", width = 2.55, height = 2.9, dpi = 120)

print(fig10)
ggsave("regional-top15-avg-rnd-per-10k-pop.png", width = 2.55, height = 2.9, dpi = 120)

print(fig11)
ggsave("regional-top15-avg-rnd-per-1k-biz.png", width = 2.55, height = 2.9, dpi = 120)

##############################################

print(fig12)
ggsave("gccsa-sri-counts-per-10k-pop.png", width = 2.55, height = 2.9, dpi = 120)

print(fig13)
ggsave("gccsa-sri-counts-per-1k-biz.png", width = 2.55, height = 2.9, dpi = 120)

print(fig14)
ggsave("gccsa-avg-netent-per-10k-pop.png", width = 2.55, height = 2.9, dpi = 120)

print(fig15)
ggsave("gccsa-avg-netent-per-1k-biz.png", width = 2.55, height = 2.9, dpi = 120)

print(fig16)
ggsave("gccsa-avg-pat-per-10k-pop.png", width = 2.55, height = 2.9, dpi = 120)

print(fig17)
ggsave("gccsa-avg-pat-per-1k-biz.png", width = 2.55, height = 2.9, dpi = 120)

print(fig18)
ggsave("gccsa-avg-tm-per-10k-pop.png", width = 2.55, height = 2.9, dpi = 120)

print(fig19)
ggsave("gccsa-avg-tm-per-1k-biz.png", width = 2.55, height = 2.9, dpi = 120)

print(fig20)
ggsave("gccsa-avg-rnd-per-10k-pop.png", width = 2.55, height = 2.9, dpi = 120)

print(fig21)
ggsave("gccsa-avg-rnd-per-1k-biz.png", width = 2.55, height = 2.9, dpi = 120)

##############################################

## export top15 as one TXT

setwd(dest)
if(file.exists("summary-ratios-regional-top15.txt")) file.remove("summary-ratios-regional-top15.txt") ## remove the old file

sink("summary-ratios-regional-top15.txt", append=TRUE)

cat(c("REGIONAL TOP15 SA3 LOCATIONS BY VARIOUS RATIOS (FILTERS APPLIED: !SPECIAL CODES, POP>10K, BIZ>1K, RA!=0[>.5], RA=0[GCCSA=FALSE])", "\n"), sep="")
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

cat(c("\n\n", "REGIONAL TOP15 SA3 STARS - THE MOST FREQUENTLY APPEARING SA3 LOCATIONS ON THE REGIONAL TOP 25 SA3 LISTS ABOVE:", "\n"), sep="")
print(df.stars)

sink()

##############################################

## cleanup, save objects, and set directory

setwd(scri)
source("00-cleanup-workspace.R")
