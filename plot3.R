## Reading data as instructed in the course web-page

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question-3 code: Of the four types of sources indicated by the type 
## (point, nonpoint, onroad, nonroad) variable, which of these four sources 
## have seen decreases in emissions from 1999–2008 for Baltimore City? 
## Which have seen increases in emissions from 1999–2008? Use the ggplot2 
## plotting system to make a plot answer this question.

## Reading target data for plot-3

BaltimoreCity <- subset(NEI, fips == "24510")

dt_plot3 <- aggregate(BaltimoreCity[c("Emissions")], list(type = BaltimoreCity$type, year = BaltimoreCity$year), sum)

library(plyr)
library(ggplot2)

png("plot3.png")
qplot(year, Emissions, data=dt_plot3, color=type, geom="line") +
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emissions by Source Type and Year")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

dev.off()





p <- ggplot(dt_plot3, aes(x=year, y=Emissions, colour=type)) +
     geom_point(alpha=.3) +
     geom_smooth(alpha=.2, size=1, method="loess") +
     ggtitle("Total Emissions by Type in Baltimore City")

print(p)
