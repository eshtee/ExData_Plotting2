# Exploratory Data Analysis
# Project 2
# Plot 2
# Have total emissions from PM2.5 decreased in the Baltimore City, Maryland (fips == "24510") from 1999 to 2008? 
#     Use the base plotting system to make a plot answering this question.

# Load required libraries 
require(dplyr)
require(ggplot2)

# Load data
NEI <- tbl_df(readRDS("summarySCC_PM25.rds"))
SCC <- tbl_df(readRDS("Source_Classification_Code.rds"))

NEI<-transform(NEI,year=factor(year))

#Plot Data
plotdata <- NEI %>%
  filter(fips=="24510")  %>%
  group_by(year) %>%
  summarise(sum=sum(Emissions))

png("plot2.png")
plot(plotdata$year,plotdata$sum,type="n",xlab="Year",ylab="Total PM2.5 Emission",
     main="PM2.5 emission in Baltimore City",boxwex=0.05)
lines(plotdata$year,plotdata$sum)
dev.off()