## When using the source command with this script set the option print.eval=TRUE 
## ggplot2 is required to execute this script
require(ggplot2)
## Read the data
NEI <- readRDS("summarySCC_PM25.rds")
## Subset the data to only Baltimore City, Maryland
data <- subset(NEI, fips == "24510")
## Aggregate and sum the relevant data emissions by year and type
myData <- aggregate(data["Emissions"], list(data$year, data$type), sum)
## Clarify column names for easy use with qplot
names(myData) <- c("Year","Type","Emissions")
## Open connection to PNG file
png("plot3.png")
## Plot the emissions by year broken by source type using the ggplot2 plotting system
## to visualize which types have increased or decreased emissions
qplot(Year,Emissions, data=myData, color=Type, geom="line", xlab="Year", 
      ylab=expression("PM"[2.5]~"Emissions (tons)"),
      main=expression("Total PM"[2.5]~"Emissions for each Type by Year in Baltimore City, MD"))
## Close the PNG file
dev.off()