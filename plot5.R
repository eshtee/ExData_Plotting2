# Exploratory Data Analysis
# Project 2
# Plot 6
# How have emissions from motor vehicle sources changed from 1999-2008 in Baltimore City?

# Load required libraries 
require(dplyr)
require(ggplot2)

# Load data
NEI <- tbl_df(readRDS("summarySCC_PM25.rds"))
SCC <- tbl_df(readRDS("Source_Classification_Code.rds"))

NEI<-transform(NEI,year=factor(year))
vehicles<-as.data.frame(SCC[grepl("vehicles",SCC$SCC.Level.Two,ignore.case=T),c(1,3)])

#Plot Data
plotdata <- NEI %>%
  filter(fips=="24510")  %>%
  merge(vehicles,by="SCC") %>%
  group_by(year) %>%
  summarise(sum=sum(Emissions))

png("plot5.png")
gplot<-ggplot(plotdata,aes(year,sum))
gplot+geom_point(size=4)+labs(title="PM2.5 Emission from motor vehicle sources in Baltimore City",
                              y="Total PM2.5 emission each year")
dev.off()
