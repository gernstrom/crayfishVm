# Written by Glen Ernstrom 2019-March. Please share, enhance, or modify. Following Google's R Style Guide for writing clean code (https://google.github.io/styleguide/Rguide).

# With a .csv file as input, returns a publication quality scatter plot with jitter. This version compares the effects of a low chloride soluiton and sodium-free soluiton on resting Vm.

# Load packages. If "not found" error returned use "install.packages".

library(dplyr)  # data manipulation functions
library(ggplot2)  # excellent data visualization
library(reshape2)  # easy wide-long format transformation

kcls <-read.csv(file="/Users/ernstrom/Documents/Teaching/Courses/BIOL370-s19/Labs/lab-03-crayfish/data/kcl-series.csv", stringsAsFactors = TRUE)  # obviously, change path to point to your .csv file
names(kcls) <- c("KCl", "low chloride", "sodium-free")
kgcls
kcl <- melt(kcls, na.rm = TRUE) # [k] [c]ls [l]ong form
names(kcl) <- c("conc", "Vm")

levels(kcl) <- c(levels(kcl), "5.4", "40", "100")  # coerce the levels order

# to make a ggplot we need to specifiy the data.frame (df), the mapping aesthetic (aes) (x and y values), what kind of plot geometry we want, the axis labels, and tweaks to the fonts, ticks, axes, and plot background to make the plot look clear and legible.

ggplot(data = kcl, mapping = aes(x = conc, y = Vm))+ geom_jitter(width = 0.1, size = 5) + labs (x = expression("["*K^{"+"}*"]"[o]~5.4~(mM)), y = "Membrane Voltage (mV)") + theme(axis.line = element_line(color = "black")) + theme(panel.background = element_blank()) + theme(axis.ticks.length=unit(0.5, "cm")) + theme(axis.text.x = element_text(size = 18)) + theme(axis.text.y = element_text(size = 18)) + theme(axis.title = element_text(size = 18)) + scale_y_continuous(limits = c (-100,0))