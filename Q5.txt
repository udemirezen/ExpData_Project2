
### How have emissions from motor vehicle sources changed from 1999–2008 in Baltimore City?

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Data Preperation : 
# assuming that everything like Motor Vehicle is categorized by type == 'ON-ROAD'
# subsetting motor vehicles from Baltimore
baltimoreMotorVehiclesNEI <- subset(NEI, fips == 24510 & type == 'ON-ROAD')

# Calculation of the Total Emissions vs Years...
neiFixed <- transform(baltimoreMotorVehiclesNEI, year=factor(year))
data <- aggregate(neiFixed$Emissions, by=list(Years=neiFixed$year), FUN=sum)
names(data)[2] <- c("TotalEmissions")

g <- ggplot(data,aes(x=Years, y=TotalEmissions,color=Years))
g <- g + geom_point(size=4)
g <- g + xlab("Years") 
g <- g + ylab(expression("Total "* PM[2.5]~" Emissions in [Tons]")) 
g <- g + ggtitle(expression("Total "* PM[2.5]~" Emissions of Motor Vehicle Sources in Baltimore City, Maryland"))
g <- g + geom_text(aes(label=data$TotalEmissions, size=1, hjust=0.5, vjust=2)) + theme(legend.position='none')
print(g)
ggsave(filename = "q5.png",plot = g,width = 7,height = 7,dpi = 200)