# Exploratory Data Analysis
# Project 2
# Plot 3
# Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
#     which of these four sources have seen decreases in emissions from 1999-2008 for Baltimore City? 
#     Which have seen increases in emissions from 1999-2008? Use the ggplot2 plotting system to make a plot answer this question.

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
  group_by(year,type) %>%
  summarise(sum=sum(Emissions))

png("plot3.png")
gplot<-ggplot(plotdata,aes(year,sum))
gplot+geom_point()+facet_grid(.~type)+labs(title="PM2.5 Emission in Baltimore city",
                                           y="Total PM2.5 emission each year")
dev.off()