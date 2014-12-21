## Reading data as instructed in the course web-page

NEI <- as.data.frame(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.frame(readRDS("Source_Classification_Code.rds"))

## Question-5 code: How have emissions from motor vehicle sources 
## changed from 1999–2008 in Baltimore City?

BC_NEI <- subset(NEI, fips == "24510" & type=="ON-ROAD")

## Reading target data for plot-5
dt_plot5<- ddply(BC_NEI, .(year), function(x) sum(x$Emissions))
colnames(dt_plot5)[2] <- "Emissions"


library(plyr)
library(ggplot2)

png("plot5.png")

qplot(year, Emissions, data=dt_plot5, geom="line") +
  ggtitle(expression("Year-wise Motor Vehicle Emissions of" ~ PM[2.5] ~ "in Baltimore City")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

dev.off()

