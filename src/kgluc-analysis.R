# With a kgluc_series.csv saved from our BIOL 370 S19 Google Sheet to somewhere on your computer, this script will output a .csv file containing the averge K-GLUC Vm, Lower and Upper 95% confidence interval, and sample size. 
# Written by Glen Ernstrom (new to learning R). Please share you enhancements with me and your classmates!

# read input from .csv file to input data.frame called "kglucs"
kglucs <-read.csv(file="/Users/ernstrom/Documents/Teaching/Courses/BIOL370-s19/Labs/lab-03-crayfish/data/kgluc_series.csv") # change this to match the path to where you put your raw .csv file.

# clean up the header names
names(kglucs) <-c("5.4KGLUC", "40KGLUC", "100KGLUC") 

#summary stats and define variables for building vectors and for calculating 95% CI

# average Vm for each test condition
lowK_avg <- mean(kglucs$"5.4KGLUC")
medK_avg <- mean(na.omit(kglucs$"40KGLUC")) #only 15 samples in this column
highK_avg <- mean(kglucs$"100KGLUC")

#sd Vm for each test condition
lowK_sd <- sd(kglucs$"5.4KGLUC")
medK_sd <- sd(na.omit(kglucs$"40KGLUC"))
highK_sd <- sd(kglucs$"100KGLUC")

# n for each test condition
lowK_n <- length(kglucs$"5.4KGLUC")
medK_n <- length(na.omit(kglucs$"40KGLUC"))
highK_n <- length(kglucs$"100KGLUC")

#sem for each test condition
lowK_sem <- lowK_sd/sqrt(lowK_n)
medK_sem <- medK_sd/sqrt(medK_n)
highK_sem <- highK_sd/sqrt(highK_n)

#Compute 95% CI's assuming we are dealing with normal sample populations. 

# assuming our sample populations are normally distributed we multiply the SEM by a factor from the t-distribition that depends on the N (the sample size). "qt", quantile, provides the value of t-distribution at a particular percentile for a sample population with particular degrees of freedom.

lowK_error <- qt(0.975, df=(lowK_n)-1) * lowK_sem
lower_lowK <- lowK_avg - lowK_error
upper_lowK <- lowK_avg + lowK_error

medK_error <- qt(0.975, df=(medK_n)-1) * medK_sem
lower_medK <- medK_avg - medK_error
upper_medK <- medK_avg + medK_error

highK_error <- qt(0.975, df=(highK_n)-1) * highK_sem
lower_highK <- highK_avg - highK_error
upper_highK <- highK_avg + highK_error

#Let's constuct a new data.frame with the data we most care about

kgluc_stats <-data.frame(saline = c("5.4 KGLUC", "40 KGLUC", "100 KGLUC"))

Vm_avg <- c(lowK_avg, medK_avg, highK_avg)
LowerCI <- c(lower_lowK, lower_medK, lower_highK)
UpperCI <- c(right_5_4, right_40, right_100)

kgluc_stats <- cbind(kgluc_stats, Vm_avg, LowerCI, UpperCI, n)

write.csv(kgluc_stats, "/Users/ernstrom/Documents/Teaching/Courses/BIOL370-s19/Labs/lab-03-crayfish/results/kgluc_stats.csv")