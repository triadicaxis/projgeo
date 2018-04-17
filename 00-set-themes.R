#!/usr/bin/env Rscript

##############################################

## 1. easd chart theme

library("ggplot2")

easd.theme <- theme(axis.text=element_text(size=5.5, color="#595A5B"), ## black text #000000 / grey text #595A5B
                    axis.title=element_text(size=5.5), ## can add argument face="bold"
                    panel.background=element_rect(fill="white"),
                    panel.border=element_blank(),
                    panel.grid.major.x=element_line(color="#BCBFC1"), ## grey grid
                    panel.grid.minor.x=element_line(color="#BCBFC1"),  ## grey grid
                    panel.grid.major.y=element_blank(),
                    axis.line=element_line(color="#BCBFC1"), ## grey axis line
                    axis.line.y=element_blank(),
                    axis.ticks.x=element_blank(),
                    axis.ticks.y=element_blank(),
                    axis.title.x=element_text(color="#595A5B"),  ## black text #000000 / grey text #595A5B
                    axis.title.y=element_blank())

##############################################

## 2. custom theme

library("ggplot2")

easd.theme2 <- theme(axis.text=element_text(size=10, color="#595A5B"), ## black text #000000 / grey text #595A5B
                    axis.title=element_text(size=10), ## can add argument face="bold"
                    panel.background=element_rect(fill="white"),
                    panel.border=element_blank(),
                    panel.grid.major.x=element_line(color="#BCBFC1"), ## grey grid
                    panel.grid.minor.x=element_line(color="#BCBFC1"),  ## grey grid
                    panel.grid.major.y=element_blank(),
                    panel.grid.minor.y=element_blank(),
                    axis.line=element_line(color="#BCBFC1"), ## grey axis line
                    axis.line.y=element_blank(),
                    axis.ticks.x=element_blank(),
                    axis.ticks.y=element_blank(),
                    axis.title.x=element_text(color="#595A5B"),  ## black text #000000 / grey text #595A5B
                    axis.title.y=element_blank())

##############################################

## 3. custom theme

library("ggplot2")

easd.theme3 <- theme(axis.text=element_text(size=10, color="#595A5B"), ## black text #000000 / grey text #595A5B
                     axis.title=element_text(size=10), ## can add argument face="bold"
                     axis.text.x = element_text(angle = 90, hjust = 1),
                     panel.background=element_rect(fill="white"),
                     panel.border=element_blank(),
                     panel.grid.major.x=element_blank(),
                     panel.grid.minor.x=element_blank(),
                     panel.grid.major.y=element_line(color="#BCBFC1"), ## grey grid
                     panel.grid.minor.y=element_line(color="#BCBFC1"),  ## grey grid
                     axis.line=element_line(color="#BCBFC1"), ## grey axis line
                     axis.line.y=element_blank(),
                     axis.ticks.x=element_blank(),
                     axis.ticks.y=element_blank(),
                     axis.title.x=element_blank(),  ## black text #000000 / grey text #595A5B
                     axis.title.y=element_blank())

##############################################

## template for use in scripts:

## create chart
#fig <- ggplot(fig, aes(x=reorder(sa3_name, total_count), y=total_count)) +
#  geom_bar(stat="identity", fill="#22789A", alpha=1, width=0.8) +
#  xlab("SA3 region") +
#  ylab("Total counts") +
#  coord_flip() +
#  easd.theme

## export figures to charts directory
#setwd(figs)
#print(fig)
#ggsave("chart-name.png", width = 2.9, height = 2.9, dpi = 120)


##############################################

## 2. shiny app chart theme

library("ggplot2")

app.theme <- theme(axis.text=element_text(size=10, color="#000000"), ## black text #000000 / grey text #595A5B
                    axis.title=element_text(size=10), ## can add argument face="bold"
                    panel.background=element_rect(fill="white"),
                    panel.border=element_blank(),
                    panel.grid.major.x=element_line(color="#BCBFC1"), ## grey grid
                    panel.grid.minor.x=element_line(color="#BCBFC1"),  ## grey grid
                    panel.grid.major.y=element_blank(),
                    axis.line=element_line(color="#BCBFC1"), ## grey axis line
                    axis.line.y=element_blank(),
                    axis.ticks.x=element_blank(),
                    axis.ticks.y=element_blank(),
                    axis.title.x=element_text(color="#000000"),  ## black text #000000 / grey text #595A5B
                    axis.title.y=element_blank())

##############################################

## cleanup, save objects, and set directory

setwd(scri)
#source("00-cleanup-workspace.R")