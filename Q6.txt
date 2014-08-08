
### Compare emissions from motor vehicle sources in Baltimore City with emissions from motor vehicle sources 
### in Los Angeles County, California (fips == 06037). 
### Which city has seen greater changes over time in motor vehicle emissions?

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Data Preperation : 
# assuming that everything like Motor Vehicle is categorized by type == 'ON-ROAD'
# subsetting motor vehicles from Maryland and California Separately
baltimoreMotorVehiclesNEI   <- subset(NEI, fips == "24510" & type == "ON-ROAD")
californiaMotorVechiclesNEI <- subset(NEI, fips == "06037" & type == "ON-ROAD")
# Calculation of the Total Emissions vs Years per City...
neiFixedMD <- transform(baltimoreMotorVehiclesNEI, year=factor(year))
neiFixedCA <- transform(californiaMotorVechiclesNEI, year=factor(year))
neiFixedCA$City <- c("CA")
neiFixedMD$City <- c("MD")
neiFixed <- rbind(neiFixedCA,neiFixedMD)
data <- aggregate(neiFixed$Emissions, by=list(Years=neiFixed$year,City=neiFixed$City), FUN=sum)

names(data)[3] <- c("TotalEmissions")

g <- ggplot(data,aes(x=Years, y=TotalEmissions,color=City,group=City))
g <- g + geom_point(size=4)
g <- g + geom_line()
g <- g + xlab("Years") 
g <- g + ylab(expression("Total "* PM[2.5]~" Emissions in [Tons]")) 
g <- g + ggtitle(expression("Total "* PM[2.5]~" Emissions of Motor Vehicle Sources in Maryland and California"))
g <- g + geom_text(aes(label=data$TotalEmissions, size=1, hjust=0.5, vjust=2))
print(g)
ggsave(filename = "q6.png",plot = g,width = 7,height = 7,dpi = 200)
