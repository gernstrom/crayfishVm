# A script for doing simple one-way ANOVA
# by Glen Ernstrom, March 26, 2019

# load packages with useful data transformation functions
library(dplyr) #if necessary use install.packages("dplyr") first
library(reshape2) #if necessary use install.packages("reshape2")

# load data and change line below to point to your file
# the .csv file I used for this is on GitHub

kglucs <- read.csv(file = "/Users/ernstrom/Documents/Teaching/Courses/BIOL370-s19/Labs/lab-03-crayfish/data/kgluc-series.csv")  

names(kglucs) <- c("5.4", "40", "100") #this makes the column names more useful

# convert data from "wide" format to "long" format. melt is smart enough to use the column names as separate grouping levels for the data in the "long" format

kgl <- melt(kglucs, variable.name = "conc", value.name = "Vm") 

# do a simple one-way ANOVA with the aov().
aov.kgl <- aov(Vm~conc, data = kgl)
summary(aov.kgl) #report the results as F(df1, df2)= F value; p-value.
# Run the Post Hoc tests to determine which pairs are significantly different from each other
TukeyHSD(aov.kgl) # include the p-values comnparing control to test in your data table in your report

#if p adj is "0" this means "p<0.001" otherwise report exact p-values out to 3 decimal places.