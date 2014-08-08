
### Across the United States, how have emissions from coal combustion-related sources changed from 1999–2008?

library(ggplot2)

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

# Data Preperation : SCC.Level.One -> SCC.Level.four is from general explanation to specific.
# SCC.Level.One attribute is very proper for "Combustion" search.
# SCC.Level.Four attribute is very proper for "Coal" search.
# Then we have to find the intersection of these logic vectors to find "Combustion" and "Coal" related data.
# By using this final vector, we can get all necessary data from NEI set...
combustionSearch <- grepl("comb", SCC$SCC.Level.One, ignore.case=TRUE)
coalSearch <- grepl("coal", SCC$SCC.Level.Four, ignore.case=TRUE) 
coalCombustion <- (combustionSearch & coalSearch)
idsOfInterest <- SCC[coalCombustion,]$SCC
combustionNEI <- NEI[NEI$SCC %in% idsOfInterest,]

# Calculation of the Total Emissions vs Years...
neiFixed <- transform(combustionNEI, year=factor(year))
data <- aggregate(neiFixed$Emissions, by=list(Years=neiFixed$year), FUN=sum)
names(data)[2] <- c("TotalEmissions")

g <- ggplot(data,aes(x=Years, y=TotalEmissions,color=Years))
g <- g + geom_point(size=4)
g <- g + xlab("Years") 
g <- g + ylab(expression("Total "* PM[2.5]~" Emissions in [Tons]")) 
g <- g + ggtitle(expression("Total "* PM[2.5]~" Emissions Across USA related to Coal Combustion"))
g <- g + ylim(c(0,600000))
print(g)
ggsave(filename = "q4.png",plot = g,width = 7,height = 7,dpi = 200)