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
## Subset the data to only Baltimore City, Maryland
BCdata <- subset(NEI, fips == "24510")
## Subset data to only the sources related to vehicles in Baltimore City, Maryland
data <- subset(BCdata, BCdata$SCC %in% codes)
## Aggregate and sum the relevant data emissions by year
myData <- aggregate(data["Emissions"], list(data$year), sum)
## Clarify column names for easy use with qplot
names(myData) <- c("Year","Emissions")
## Open connection to PNG file
png("plot5.png")
## Plot the emissions by year broken by source type using the ggplot2 plotting system
## to visualize which types have increased or decreased emissions
qplot(Year,Emissions, data=myData, geom="line", xlab="Year", 
      ylab=expression("PM"[2.5]~"Emissions from Vehicles (tons)"),
      main=expression("Total PM"[2.5]~"Emissions from Vehicles by Year in Baltimore City, MD"))
## Close the PNG file
dev.off()