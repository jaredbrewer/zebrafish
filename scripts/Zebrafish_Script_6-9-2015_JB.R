# Data Analysis for Zebrafish Data

# Jared Brewer and Alice Boos
# Created: June 9, 2015
# Modified: June 9, 2015

setwd("~/Documents/Dropbox/Biology/Animal Behavior/Zebrafish Lab/Lab Data")

# First, load the data into R after having reformatted it in Excel.
zfdata <- read.csv("./Zebrafish_Data_6-15-2015_JB.csv", header=T)

means <- c(mean(zfdata$WT, na.rm=T), mean(zfdata$G, na.rm=T))
zf.std <- c(sd(zfdata$WT, na.rm=T), sd(zfdata$G, na.rm=T)) 
zf.n <- c(sum(zfdata$WT, na.rm=T)/mean(zfdata$G, na.rm=T), sum(zfdata$WT, na.rm=T)/mean(zfdata$G, na.rm=T))
zf.se <- c(zf.std/sqrt(zf.n))

# Perform a paired t-test on the data to determine statistical significance.
var.test(zfdata$WT,zfdata$G)
t.test(zfdata$WT,zfdata$G, var.equal=T)
y1=(zfdata$WT)
y2=(zfdata$G)
t.test(y1,y2,paired=T)

# Making a bar plot for the prescribed data. A box plot might be better though. 
zf.bar <- barplot(means, names = c("WT", "G"), xlab="Phenotype", ylab="Time Spent", ylim=c(0, 500), col=c("steelblue1", "firebrick1"))
abline(h=0)
segments(zf.bar, means+zf.se, zf.bar, means-zf.se) 
# Applies vertical marks for standard error
segments(zf.bar -0.05, means+zf.se, zf.bar +0.05, means+zf.se) 
# Makes horizontal tick on positive SE
# Numbers determine the width of the ticks
segments(zf.bar -0.05, means-zf.se, zf.bar +0.05, means-zf.se) 

# Now, since we got a good P-value for the previous analysis, we can analyze just the means for each male so that we don't have an artificially inflated n.
zfmeans <- read.csv("./Zebrafish_Means_6-15-2015_JB.csv", header=T)
var.test(zfmeans$WT,zfmeans$G)
t.test(zfmeans$WT,zfmeans$G, var.equal=T)
zy1=(zfmeans$WT)
zy2=(zfmeans$G)
t.test(zy1,zy2,paired=T)

# Box Plot
# This data may be best represented with a boxplot, although that is far from mandatory. The barplot looks good.

wtmean <- c(mean(zfdata$WT, na.rm=T))
gmean <- c(mean(zfdata$G, na.rm=T))

zf.box <- boxplot(WT~G, data=zfdata, xlab="Phenotype", ylab="Time Spent")
# Having some trouble sorting this out. I want a box plot with the two phenotypes on the x and the y axis as time spent. For some reason, it doesn't want that.
abline(h=0)
segments(zf.box, means+zf.se, zf.box, means-zf.se) 
# Applies vertical marks for standard error
segments(zf.box -0.05, means+zf.se, zf.box +0.05, means+zf.se) 
# Makes horizontal tick on positive SE
# Numbers determine the width of the ticks
segments(zf.box -0.05, means-zf.se, zf.box +0.05, means-zf.se)

