install.packages(c('shiny', 'ggvis', 'dplyr', 'RSQLite'))

library("RSQLite")
library("shiny")
library("ggvis")
library("dplyr")

setwd("~/Developing Data Science Products/EMA")

base <- read.csv("REPORT_RESULTa.csv", sep=";")
base15 <- read.csv("REPORT_RESULT 2015a.csv", sep=";")
all_flexitime <- merge(base, base15, by = "Personnel.Number..P.", all.x=TRUE)

#all_flexitime <- as.data.frame(all_flexitime)
#dbWriteTable(all_flexitime, "all_flexitime", all_flexitime )







