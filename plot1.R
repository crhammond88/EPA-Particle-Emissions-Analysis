## Read the data
NEI <- readRDS("summarySCC_PM25.rds")
## Open connection to PNG file
png("plot1.png")
## Aggregate and sum the data emissions by year
myData <- aggregate(NEI["Emissions"], list(NEI$year), sum)
## Plot the emissions by year using the base plotting system
plot(myData[,1], myData[,2], type="l", xlab="Year", 
     ylab=expression("PM"[2.5]~"Emissions (tons)"),
     main=expression("Total US PM"[2.5]~"Emissions by Year"))
## Close the PNG file
dev.off()