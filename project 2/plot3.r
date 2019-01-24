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

## Extract data by calculating the sum of Emissions by Years
Balt_em <- aggregate(Emissions~year+type, Balt, sum)

## Plotting 

plot3 <-   qplot(year, Emissions, data = Balt_em, color = type, geom = "line") +  
  ggtitle(expression("Baltimore City" ~ PM[2.5] ~ "Emissions by Source Type and Year"))+
  xlab("Year") + ylab(expression("Total"~ PM[2.5] ~ "Emissions (tons)"))

## Saving the copy of the plot to PNG
dev.copy(png, file="plot3.png")
dev.off()
       