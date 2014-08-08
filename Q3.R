
### Of the four types of sources indicated by the type (point, nonpoint, onroad, nonroad) variable, 
### which of these four sources have seen decreases in emissions from 1999–2008 for Baltimore City? 
### Which have seen increases in emissions from 1999–2008?

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

nei <- subset(NEI,NEI$fips=="24510")

neiFixed <- transform(nei, type=factor(type), year=factor(year))
data <- aggregate(neiFixed$Emissions, by=list(Years=neiFixed$year,Types=neiFixed$type), FUN=sum)
names(data)[3] <- c("TotalEmissions")

g <- ggplot(data,aes(x=Years, y=TotalEmissions,color=Types))
g <- g + geom_point(size=4)
g <- g + facet_wrap(~Types ,ncol=1,nrow=4)
g <- g + xlab("Years") 
g <- g + ylab(expression("Total "* PM[2.5]~" Emissions in [Tons]")) 
g <- g + ggtitle(expression("Total "* PM[2.5]~" Emissions in Baltimore City Years Between 1999–2008"))
print(g)
ggsave(filename = "q3.png",plot = g,width = 7,height = 7,dpi = 200)