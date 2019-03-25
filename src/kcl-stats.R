# A script for collecting summary statistics
# by Glen Ernstrom, March 24, 2019

# install and load packages
# install.packages("pastecs")  
# install.packages("dplyr")   
library(dplyr) # data manipulation functions
library(pastecs) # for useful summary stats

#load data
kglucs <-read.csv(file="/Users/ernstrom/Documents/Teaching/Courses/BIOL370-s19/Labs/lab-03-crayfish/data/kcl-series.csv", stringsAsFactors = TRUE)  # obviously, change path to point to your .csv file
names(kcls) <- c("KCl", "KGLUC", "Na-free") 

# create a data.frame of summary stats
kcls.stats <- stat.desc(kcls,basic=TRUE, desc=TRUE, norm=FALSE, p=0.95)

kcls.stats

# after inspecting the table, we want the nbr.value, mean, and CI.mean.95 which corresponds to rows 1, 9, 11. There are different ways to pull out these rows. One way is to exclude the rows we don't want by the following:

kclst <- kcls.stats[-c(2:8, 10, 12:14), ]
kclst

kclsts.table <- t(kclst) #tranpose the table
kclsts.table

dnkcl <- kclsts.table[1,2] - kclsts.table[1,3]
upkcl <- kclsts.table[1,2] + kclsts.table[1,3]

dngluc <- kclsts.table[2,2] - kclsts.table[2,3]
upgluc <- kclsts.table[2,2] + kclsts.table[2,3]

dnnafree <- kclsts.table[3,2] - kclsts.table[3,3]
upnafree <- kclsts.table[3,2] + kclsts.table[3,3]

lowCI <- c(dnkcl, dngluc, dnnafree)
upCI <- c(upkcl, upgluc, upnafree)

kclsts.table <- cbind(kclsts.table, lowCI)
kclsts.table <- cbind(kclsts.table, upCI)

kclsts.table

write.csv(kclsts.table, "/Users/ernstrom/Documents/Teaching/Courses/BIOL370-s19/Labs/lab-03-crayfish/results/kcl-stats.csv")