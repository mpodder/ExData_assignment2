## Reading data as instructed in the course web-page

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question-2 code: Have total emissions from PM2.5 decreased in the 
## Baltimore City, Maryland (fips == "24510") from 1999 to 2008? Use 
## the base plotting system to make a plot answering this question.

## Reading target data for plot-2

BaltimoreCity <- subset(NEI, fips == "24510")
dt_plot2 <- aggregate(BaltimoreCity[c("Emissions")], list(year = BaltimoreCity$year), sum)

## Creating plot-2
x11()

png("plot2.png")

plot(dt_plot2$year, dt_plot2$Emissions, type = "b", col="blue", lwd=2,
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main=expression("Total" ~ PM[2.5] ~ "Emissions by Year in Baltimore City, Maryland"))

dev.off()

