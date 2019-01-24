## Download the zip file
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
## Unzipping the files
unzip(zipfile = "dataFiles.zip")

## Readinf th files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Subset data by Maryland and Los Angeles
data<-NEI[with(NEI, fips == "06037"|fips == "24510"), ]

## Get motor vehicle sources in SCC
onroad <- subset(SCC,Data.Category == "Onroad")
motorCodes <- onroad$SCC

## Subset Data with the code
motorData <- subset(data, SCC %in% motorCodes)

## Extract data by calculating the sum of Emissions
Motor <- aggregate(Emissions~year + fips, motorData, sum)

## Load the library
library(ggplot2)

## Plot
g <- ggplot(Motor, aes(year, Emissions))
g + facet_grid(. ~ fips) + geom_line()

dev.copy(png, file = "plot6.png") 
dev.off()




