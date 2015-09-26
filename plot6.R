# Exploratory Data Analysis
# Project 2
# Plot 6

# Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources in Los Angeles County, 
#    California (fips == "06037"). Which city has seen greater changes over time in motor vehicle emissions

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
  filter(fips=="24510" | fips=="06037")  %>%
  mutate(city=ifelse(fips=="24510","Baltimore","LA")) %>%
  merge(vehicles,by="SCC") %>%
  group_by(year,city) %>%
  summarise(sum=sum(Emissions))

png("plot6.png")
gplot<-ggplot(plotdata,aes(year,sum))
gplot+geom_point(aes(color=city),size=4)+labs(title="PM2.5 Emission from motor vehicle sources",
                                              y="Total PM2.5 emission each year")

dev.off()