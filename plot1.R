
## Reading data as instructed in the course web-page

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Question-1 code: Have total emissions from PM2.5 decreased in the 
## United States from 1999 to 2008? Using the base plotting system, 
## make a plot showing the total PM2.5 emission from all sources for 
## each of the years 1999, 2002, 2005, and 2008.

## Reading target data for plot-1
dt_plot1 <- aggregate(NEI[c("Emissions")], list(year = NEI$year), sum)

## Creating plot-1
x11()

png("plot1.png")
plot(dt_plot1$year, dt_plot1$Emissions, type = "b", col="blue", lwd=2,
     xlab="Year", ylab=expression("Total" ~ PM[2.5] ~ "Emissions (tons)"),
     main=expression("Total" ~ PM[2.5] ~ "Emissions by Year in US"))

dev.off()
