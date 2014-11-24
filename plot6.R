## When using the source command with this script set the option print.eval=TRUE 
## ggplot2 is required to execute this script
require(ggplot2)
## Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCCData <- readRDS("Source_Classification_Code.rds")
## Create a vector containing only the sectors related to vehicles
sectors <- grep("Vehicle",SCCData$EI.Sector,value=TRUE,ignore.case=TRUE)
## Subset source classification data to the SCC column only matching the sectors related to vehicles
codes <- subset(SCCData, SCCData$EI.Sector %in% sectors, select=SCC)$SCC
## Subset the data to only Baltimore City, Maryland or Los Angeles County, California
citydata <- subset(NEI, fips == "24510" | fips == "06037")
## Subset the data to only the sources related to vehicles in BC or LA
data <- subset(citydata, citydata$SCC %in% codes)
## Aggregate and sum the relevant data emissions by year and location
myData <- aggregate(data["Emissions"], list(data$year, data$fips), sum)
## Clarify column names for easy use with qplot
names(myData) <- c("Year", "City", "Emissions")
## Open connection to PNG file
png("plot6.png")
## Plot a comparision of the emissions from vehicles in BC and LA by year with an appropriate legend
qplot(Year,Emissions, data=myData, geom="line", color = City, xlab="Year", 
      ylab=expression("PM"[2.5]~"Emissions from Vehicles (tons)"),
      main=expression("Total PM"[2.5]~"Emissions from Vehicles in Baltimore vs LA")) + scale_colour_discrete(name = "City", 
                                                                        breaks = c("06037","24510"),
                                                                        labels=c("Los Angeles County", "Baltimore City"))
## Close the PNG file
dev.off()