## Read the data
NEI <- readRDS("summarySCC_PM25.rds")
## Open connection to PNG file
png("plot2.png")
## Subset the data to only Baltimore City, Maryland
data <- subset(NEI, fips == "24510")
## Aggregate and sum the relevant data emissions by year
myData <- aggregate(data["Emissions"], list(data$year), sum)
## Plot the emissions by year using the base plotting system
plot(myData[,1], myData[,2], type="l", xlab="Year", 
     ylab=expression("PM"[2.5]~"Emissions (tons)"),
     main=expression("Total PM"[2.5]~"Emissions by Year for Baltimore City, Maryland"))
## Close the PNG file
dev.off()