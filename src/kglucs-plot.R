# Written by Glen Ernstrom 2019-March. Please share, enhance, or modify. Following Google's R Style Guide for writing clean code (https://google.github.io/styleguide/Rguide).

# With a .csv file as input, returns a publication quality scatter plot with jitter. This version compares the effect of increasing extracellular potassium ion concentration on Vm.

# Load packages. If "not found" error returned use "install.packages".

library(dplyr)  # data manipulation functions
library(ggplot2)  # excellent data visualization
library(reshape2)  # easy wide-long format transformation

kglucs <-read.csv(file="/Users/ernstrom/Documents/Teaching/Courses/BIOL370-s19/Labs/lab-03-crayfish/data/kgluc-series.csv", stringsAsFactors = TRUE)  # obviously, change path to point to your .csv file
names(kglucs) <- c("5.4", "40", "100") 
kglucs
kgl <- melt(kglucs, na.rm = TRUE) # [k] [g]lucs [l]ong form
names(kgl) <- c("conc", "Vm")

levels(kglucs_melted) <- c(levels(kglucs_melted), "5.4", "40", "100")  # coerce the levels order

# to make a ggplot we need to specifiy the data.frame (df), the mapping aesthetic (aes) (x and y values), what kind of plot geometry we want, the axis labels, and tweaks to the fonts, ticks, axes, and plot background to make the plot look clear and legible.

ggplot(data = kgl, mapping = aes(x = conc, y = Vm))+ geom_jitter(width = 0.1, size = 5) + labs (x = expression("["*K^{"+"}*"]"[o] ~(mM)), y = "Membrane Voltage (mV)") + theme(axis.line = element_line(color = "black")) + theme(panel.background = element_blank()) + theme(axis.ticks.length=unit(0.5, "cm")) + theme(axis.text.x = element_text(size = 18)) + theme(axis.text.y = element_text(size = 18)) + theme(axis.title = element_text(size = 18)) + scale_y_continuous(limits = c (-100,0))






