install.packages(c('shiny', 'ggvis', 'dplyr', 'RSQLite'))

library("RSQLite")
library("shiny")
library("ggvis")
library("dplyr")

setwd("~/Developing Data Science Products/EMA")

base <- read.csv("REPORT_RESULTa.csv", sep=";")
base15 <- read.csv("REPORT_RESULT 2015a.csv", sep=";")
all_flexitimes <- merge(base, base15, by = "Personnel.Number..P.", all.x=TRUE)
colnames(all_flexitimes) <- c("Number", "First", "Last", "Contract", "Grade", "Flexileave2015", "Certifiedsickleave2015", "Uncertifiedsickleave2015", "Daysnotrecorded2015", "Excess2015")
all_flexitimes$Grade <- as.character(all_flexitimes$Grade)
all_flexitimes$Contract <- as.character(all_flexitimes$Contract)
all_flexitimes$First <- as.character(all_flexitimes$First)
all_flexitimes$Last <- as.character(all_flexitimes$Last)

#all_flexitime <- as.data.frame(all_flexitime)
#dbWriteTable(all_flexitime, "all_flexitime", all_flexitime )







