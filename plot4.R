## Reading data as instructed in the course web-page

NEI <- as.data.frame(readRDS("summarySCC_PM25.rds"))
SCC <- as.data.frame(readRDS("Source_Classification_Code.rds"))

## Question-4 code: Across the United States, how have 
## emissions from coal combustion-related sources changed from 1999–2008?

## Extracting coal combustion source-codes through EI.Sector field from SCC data-source

CoalCombustion_SCC1 <- subset(SCC, EI.Sector %in% c("Fuel Comb - Comm/Institutional - Coal",
                                               "Fuel Comb - Electric Generation - Coal",
                                               "Fuel Comb - Industrial Boilers, ICEs - Coal"))
nrow(CoalCombustion_SCC1)

## through short-name matching
CoalCombustion_SCC2 <- subset(SCC, grepl("Comb", Short.Name) & grepl("Coal", Short.Name))
nrow(CoalCombustion_SCC2)

dt1 <- setdiff(CoalCombustion_SCC1$SCC, CoalCombustion_SCC2$SCC)
length(dt1)

dt2 <- setdiff(CoalCombustion_SCC1$SCC, CoalCombustion_SCC2$SCC)
length(dt2)
 
## combining above 2 coal-combustion from SCC data-source
CoalCombustion_SCC <- union(CoalCombustion_SCC1$SCC, CoalCombustion_SCC2$SCC)
length(CoalCombustion_SCC)

## Coal combustion with NEI data-source
CoalCombustion_NEI <- subset(NEI, SCC %in% CoalCombustion_SCC)

## Reading target data for plot-4

dt_plot4 <- ddply(CoalCombustion_NEI, .(year, type), function(x) sum(x$Emissions))
colnames(dt_plot4)[3] <- "Emissions"


library(plyr)
library(ggplot2)

png("plot4.png")

## x11()
qplot(year, Emissions, data=dt_plot4, color=type, geom="line") +
  stat_summary(fun.y = "sum", fun.ymin = "sum", fun.ymax = "sum", 
               color = "black", aes(shape="total"), geom="line") +
  geom_line(aes(size="total", shape = NA)) +
  ggtitle(expression("Year-wise Coal Combustion" ~ PM[2.5] ~ "Emissions by Source Type")) +
  xlab("Year") +
  ylab(expression("Total" ~ PM[2.5] ~ "Emissions (tons)"))

dev.off()


 