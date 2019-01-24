## Download the zip file
download.file(url = "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2FNEI_data.zip"
              , destfile = paste(path, "dataFiles.zip", sep = "/"))
## Unzipping the files
unzip(zipfile = "dataFiles.zip")

## Readinf th files
NEI <- readRDS("summarySCC_PM25.rds")
SCC <- readRDS("Source_Classification_Code.rds")

## Selecting the Baltimore City
Balt <- NEI[NEI$fips == "24510",]

## Get motor vehicle sources in SCC
MVS <- subset(SCC, Data.Category == "Onroad")
BaltCodes <- MVS$SCC

## Subset Data with the code
BaltData <- subset(Balt, SCC %in% BaltCodes)

## Extract data by calculating the sum of Emissions
Baltmotor <- aggregate(Emissions ~ year, BaltData, sum)

## Plotting 
plot5 <- with(Baltmotor, plot(year, Emissions, type = "l", 
                            xlab="Year", ylab = "Total Emissions", 
                            main="Total Emissions for motor vehicle sources changed in Baltimore City"))

dev.copy(png, file="plot5.png")
dev.off()

