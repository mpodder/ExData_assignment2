## Reading data as instructed in the course web-page

NEI <- as.data.frame(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.frame(readRDS("Source_Classification_Code.rds"))

## Question-5 code: Compare emissions from motor vehicle sources in 
## Baltimore City with emissions from motor vehicle sources in 
## Los Angeles County, California (fips == "06037"). 
## Which city has seen greater changes over time in motor vehicle emissions?

BCLAC_NEI<- subset(NEI, (fips == "24510" | fips == "06037") & type=="ON-ROAD")

BCLAC_NEI<- transform(BCLAC_NEI,
                region = ifelse(fips == "24510", "Baltimore City", "Los Angeles County"))

## Reading target data for plot-6
BCLAC_PM25 <- ddply(BCLAC_NEI, .(year, region), function(x) sum(x$Emissions))
colnames(BCLAC_PM25)[3] <- "Emissions"

library(plyr)
library(ggplot2)

png("plot6.png")
qplot(year, Emissions, data=BCLAC_PM25, geom="line", color=region) +
  ggtitle(expression("Year-wise Motor Vehicle Emissions of" ~ PM[2.5] ~ "in Baltimore City and Los Angeles County")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))


dev.off()

