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

# Merge date & time into single column
dateTime <- as.POSIXct(paste(data$Date, data$Time, sep = ";"), format = "%d/%m/%Y;%H:%M:%S")
data <- cbind("DateTime" = dateTime, data)
data$Date <- NULL
data$Time <- NULL
remove(dateTime)

# Convert features to numeric
data$Sub_metering_1 <- as.numeric(data$Sub_metering_1)
data$Sub_metering_2 <- as.numeric(data$Sub_metering_2)
data$Sub_metering_3 <- as.numeric(data$Sub_metering_3)

# ========================================================================================================================================
# Plot graph
png(filename = "plot3.png", width = 480, height = 480, units = "px", bg = "transparent")
plot(data$DateTime, data$Sub_metering_1, type="l", col="black",xlab = "", ylab = "Global Active Power (kilowatts)")
lines(data$DateTime, data$Sub_metering_2, type="l", col="red")
lines(data$DateTime, data$Sub_metering_3, type="l", col="blue")
legend("topright", c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),lty = c(1, 1, 1), col=c("black","red", "blue"))

dev.off()
