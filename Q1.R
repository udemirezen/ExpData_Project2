NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

### Have total emissions from PM2.5 decreased in the United States from 1999 to 2008? 
### Using the base plotting system, make a plot showing :
### the total PM2.5 emission from all sources 
### for each of the years 1999, 2002, 2005, and 2008.

NEI$year <- as.factor(NEI$year)
#data <- table(NEI$year,NEI$Emissions)
data <- aggregate(NEI$Emissions, by=list(Category=NEI$year), FUN=sum)

png(file="q1.png",width = 500,height = 500,units = 'px',type = "cairo-png")
bp <- barplot(data$x,
        main="Total PM2.5 Emissions in the United States from 1999 to 2008",
        ylab="Total Emission [in Tons]",
        xlab="Years",
        names.arg=as.vector(data$Category),
        col= rainbow(4),
        las=3   
        )
dev.off()