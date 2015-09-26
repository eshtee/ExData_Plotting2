# Exploratory Data Analysis
# Project 2
# Plot 4
# Across the United States, how have emissions from coal combustion-related sources changed from 1999-2008?

# Load required libraries 
require(dplyr)
require(ggplot2)

# Load data
NEI <- tbl_df(readRDS("summarySCC_PM25.rds"))
SCC <- tbl_df(readRDS("Source_Classification_Code.rds"))

NEI<-transform(NEI,year=factor(year))

combustion<-tbl_df(as.data.frame(SCC[grepl("combustion",SCC$SCC.Level.One,ignore.case=T) & 
                                       grepl("coal",SCC$SCC.Level.Three,ignore.case=T),c(1,3)]))

NEI_coal_comb<-merge(combustion,NEI,by="SCC")


#Plot Data
plotdata <- NEI_coal_comb %>%
  select(year,Emissions) %>%
  group_by(year) %>%
  summarise(sum=sum(Emissions))

png("plot4.png")
gplot<-ggplot(plotdata,aes(year,sum))
gplot+geom_point(size=4)+labs(title="PM2.5 Emission from coal combustion-related sources ",
                              y="Total PM2.5 emission each year")
dev.off()
