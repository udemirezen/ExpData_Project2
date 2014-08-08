
### Have total emissions from PM2.5 decreased in the Baltimore City, Maryland 
### (fips == "24510") from 1999 to 2008?

NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

nei <- subset(NEI,NEI$fips=="24510")
nei$year <- as.factor(nei$year)

data <- aggregate(nei$Emissions, by=list(Category=nei$year), FUN=sum)

png(file="q2.png",width = 500,height = 500,units = 'px',type = "cairo-png")

barplot(data$x,
        main="Total PM2.5 Emissions in the Baltimore City, Maryland\n from 1999 to 2008",
        ylab="Total Emission [in Tons]",
        xlab="Years",
        names.arg=as.vector(data$Category),
        col= rainbow(4)
)

dev.off()