# Exploratory Data Analysis
# Project 2
# Plot 2
# Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? Using the base plotting system, 
#     make a plot showing the total PM2.5 emission from all sources for each of the years 1999, 2002, 2005, and 2008.

# Load required libraries 
require(dplyr)
require(ggplot2)

# Load data
NEI <- tbl_df(readRDS("summarySCC_PM25.rds"))
SCC <- tbl_df(readRDS("Source_Classification_Code.rds"))

NEI<-transform(NEI,year=factor(year))

#Plot Data
plotdata <- NEI %>%
  group_by(year) %>%
  summarise(sum=sum(Emissions))

png("plot1.png")
plot(plotdata$year,plotdata$sum,type="n",xlab="Year",ylab="Total PM2.5 Emission",boxwex=0.05)
lines(plotdata$year,plotdata$sum)
dev.off()


