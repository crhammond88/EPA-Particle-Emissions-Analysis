## When using the source command with this script set the option print.eval=TRUE 
## ggplot2 is required to execute this script
require(ggplot2)
## Read the data
NEI <- readRDS("summarySCC_PM25.rds")
SCCData <- readRDS("Source_Classification_Code.rds")
## Create a vector containing only the sectors related to coal
sectors <- grep("Coal",SCCData$EI.Sector,value=TRUE,ignore.case=TRUE)
## Subset source classification data to the SCC column only matching the sectors related to coal
codes <- subset(SCCData, SCCData$EI.Sector %in% sectors, select=SCC)$SCC
## Subset data to only the sources related to coal
data <- subset(NEI, NEI$SCC %in% codes)
## Aggregate and sum the relevant data emissions by year
myData <- aggregate(data["Emissions"], list(data$year), sum)
## Clarify column names for easy use with qplot
names(myData) <- c("Year","Emissions")
## Open connection to PNG file
png("plot4.png")
## Plot the emissions by year from coal sources
qplot(Year,Emissions, data=myData, geom="line", xlab="Year", 
      ylab=expression("PM"[2.5]~"Emissions from Coal (tons)"),
      main=expression("Total US PM"[2.5]~"Emissions by Year from Coal"))
## Close the PNG file
dev.off()