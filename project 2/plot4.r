## Download the zip file
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
## Unzipping the files
unzip(zipfile = "dataFiles.zip")

## Reading th files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Get the coal combustion-related sources from SCC
Codes <- SCC$SCC[grep("coal", SCC$EI.Sector, ignore.case=TRUE)]

## Subset Data with the code
SCCdata <- subset(NEI, SCC %in% Codes)

## Extract data by calculating the sum of Emissions
coal <- aggregate(Emissions~year, SCCdata, sum)

## Plotting
with(coal, plot(year, Emissions,
                   , xlab = "Year", ylab = "Total Emissions", type="l"
                   , main="Total Emissions for 
                   coal combustion-related sources"))

## Saving the copy of the plot to PNG
dev.copy(png, file="plot4.png")
dev.off()

