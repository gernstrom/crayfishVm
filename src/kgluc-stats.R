# A script for collecting summary statistics
# by Glen Ernstrom, March 24, 2019

# install and load packages
# install.packages("pastecs")  
# install.packages("dplyr")   
library(dplyr) # data manipulation functions
library(pastecs) # for useful summary stats

#load data
kglucs <-read.csv(file="/Users/ernstrom/Documents/Teaching/Courses/BIOL370-s19/Labs/lab-03-crayfish/data/kgluc-series.csv", stringsAsFactors = TRUE)  # obviously, change path to point to your .csv file
names(kglucs) <- c("5.4", "40", "100") 

# create a data.frame of summary stats
kgluc.stats <- stat.desc(kglucs[,1:3],basic=TRUE, desc=TRUE, norm=FALSE, p=0.95)

kgluc.stats

# after inspecting the table, we want the nbr.value, mean, and CI.mean.95 which corresponds to rows 1, 9, 11. There are different ways to pull out these rows. One way is to exclude the rows we don't want by the following:

kglucst <- kgluc.stats[-c(2:8, 10, 12:14), ]
kglucst

kglucs.table <- t(kglucst)
kglucs.table

dn54 <- kglucs.table[1,2] - kglucs.table[1,3]
up54 <- kglucs.table[1,2] + kglucs.table[1,3]

dn40 <- kglucs.table[2,2] - kglucs.table[2,3]
up40 <- kglucs.table[2,2] + kglucs.table[2,3]

dn100 <- kglucs.table[3,2] - kglucs.table[3,3]
up100 <- kglucs.table[3,2] + kglucs.table[3,3]

lowCI <- c(dn54, dn40, dn100)
upCI <- c(up54, up40, up100)

kglucs.table <- cbind(kglucs.table, lowCI)
kglucs.table <- cbind(kglucs.table, upCI)

kglucs.table

write.csv(kglucs.table, "/Users/ernstrom/Documents/Teaching/Courses/BIOL370-s19/Labs/lab-03-crayfish/results/kgluc-stats.csv")






