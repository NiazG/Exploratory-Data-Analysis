#Load Libraries
# ========================================================================================================================================
library('dplyr')
library('ggplot2')
library('reshape2')
# ========================================================================================================================================
# Download and extract Data and load file
zipFile <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"

if(!file.exists("Data/household_power_consumption.txt")){ 
        dataURL <- "https://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
        download.file(dataURL, zipFile, mode ="wb")  
        unzip(zipFile, exdir = "Data")
        file.remove(zipFile)
}

# load power consumption data
fileNamePower <- file.path("Data", "household_power_consumption.txt")

data <- read.table(file = fileNamePower, header = TRUE, sep = ';')

# subset dataset
data <- subset(data, Date == '1/2/2007' | Date == '2/2/2007')

# Convert Global Active Power to numeric
data$Global_active_power <- as.numeric(data$Global_active_power)

# ========================================================================================================================================
# Create and plot graph
# Plot graph

png(filename = "plot1.png", width = 480, height = 480, units = "px", bg = "transparent")
hist(data$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Active Power (kilowatts)")

dev.off()
