# Data Analysis for Zebrafish Data

# Jared Brewer and Alice Boos
# Created: June 9, 2015
# Modified: July 14, 2015

# This working directory can be whatever you want and doesn't even have to be added to the R script, if you don't want.
# It can simply be run as a command in the console. 
setwd("~/Documents/Dropbox/GitHub/zebrafish/data")

# First, load the data into R after having reformatted it in Excel.
zrdata <- read.csv("./RedData_07142015_WJB.csv", header=T)
zgdata <- read.csv("./GreenData_07142015_WJB.csv", header=T)

rmeans <- c(mean(zrdata$WT, na.rm=T), mean(zrdata$G, na.rm=T))
zr.std <- c(sd(zrdata$WT, na.rm=T), sd(zrdata$G, na.rm=T)) 
zr.n <- c(sum(zrdata$WT, na.rm=T)/mean(zrdata$G, na.rm=T), sum(zrdata$WT, na.rm=T)/mean(zrdata$G, na.rm=T))
zr.se <- c(zr.std/sqrt(zr.n))

gmeans <- c(mean(zgdata$WT, na.rm=T), mean(zgdata$G, na.rm=T))
zg.std <- c(sd(zgdata$WT, na.rm=T), sd(zgdata$G, na.rm=T)) 
zg.n <- c(sum(zgdata$WT, na.rm=T)/mean(zgdata$G, na.rm=T), sum(zgdata$WT, na.rm=T)/mean(zgdata$G, na.rm=T))
zg.se <- c(zg.std/sqrt(zg.n))

# Perform a paired t-test on the data to determine statistical significance.
# The rationale is that the data are inherently paired and, thus, can be compared directly.

# Red first
var.test(zrdata$WT,zrdata$G)
t.test(zrdata$WT,zrdata$G, var.equal=T)
ry1=(zrdata$WT)
ry2=(zrdata$G)
t.test(ry1,ry2,paired=T)

# Then green
var.test(zgdata$WT,zgdata$G)
t.test(zgdata$WT,zgdata$G, var.equal=T)
gy1=(zgdata$WT)
gy2=(zgdata$G)
t.test(gy1,gy2,paired=T)

# Making a bar plot for the prescribed data. A box plot might be better though?
# Red
zr.bar <- barplot(rmeans, names = c("WT", "G"), xlab="Phenotype", ylab="Time Spent", ylim=c(0, 500), col=c("steelblue1", "firebrick1"))
abline(h=0)
segments(zr.bar, means+zr.se, zr.bar, means-zr.se) 
# Applies vertical marks for standard error
segments(zr.bar -0.05, means+zr.se, zr.bar +0.05, means+zr.se) 
# Makes horizontal tick on positive SE
# Numbers determine the width of the ticks
segments(zr.bar -0.05, means-zr.se, zr.bar +0.05, means-zr.se) 

# Green
zg.bar <- barplot(gmeans, names = c("WT", "G"), xlab="Phenotype", ylab="Time Spent", ylim=c(0, 500), col=c("steelblue1", "firebrick1"))
abline(h=0)
segments(zg.bar, means+zg.se, zg.bar, means-zg.se) 
# Applies vertical marks for standard error
segments(zg.bar -0.05, means+zg.se, zg.bar +0.05, means+zg.se) 
# Makes horizontal tick on positive SE
# Numbers determine the width of the ticks
segments(zg.bar -0.05, means-zg.se, zg.bar +0.05, means-zg.se) 

# Now, since we got a good P-value for the previous analysis, we can analyze just the means for each male so that we don't have an artificially inflated n.
# Same deal, rojo first
zrmeans <- read.csv("./RedMeans_07142015_WJB.csv", header=T)
var.test(zrmeans$WT,zrmeans$G)
t.test(zrmeans$WT,zrmeans$G, var.equal=T)
zry1=(zrmeans$WT)
zry2=(zrmeans$G)
t.test(zry1,zry2,paired=T)

# Verde
zgmeans <- read.csv("./GreenMeans_07142015_WJB.csv", header=T)
var.test(zgmeans$WT,zgmeans$G)
t.test(zgmeans$WT,zgmeans$G, var.equal=T)
zgy1=(zgmeans$WT)
zgy2=(zgmeans$G)
t.test(zgy1,zgy2,paired=T)
