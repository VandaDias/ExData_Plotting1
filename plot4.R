# opens needed packages
library(dplyr)
library(lubridate)

# roughly checks if computer has enough memory to run the dataset
# 2,075,259 rows by 9 columns
dataset_size <- round(2075259*9*8/2^{20}/1024, 2) #in Gb
try(if(dataset_size > 4) stop("not enough memory"))

# reads household power consumption table
hpc_zipfile <- "exdata%2Fdata%2Fhousehold_power_consumption.zip"
hpc_column_classes <- c(rep("character", 2), rep("numeric", 7))
hpc_all <- read.table(unzip(hpc_zipfile, "household_power_consumption.txt"), header = TRUE, sep = ";", colClasses = hpc_column_classes, na.strings = "?", row.names = NULL)

# formats and selects dates
hpc_all$DateFormated <- as.Date(hpc_all$Date, "%d/%m/%Y")
hpc <- filter(hpc_all, DateFormated >= "2007-02-01" & DateFormated <= "2007-02-02")

# formats times
hpc$TimeFormated <- strptime(paste(hpc$Date, hpc$Time), "%d/%m/%Y %H:%M:%S")

# outputs plot 4
png(file = "plot4.png", width = 480, height = 480)
par(mfrow = c(2,2))
plot(hpc$TimeFormated, hpc$Global_active_power, type = "l", xlab = "", ylab = "Global Active Power")
plot(hpc$TimeFormated, hpc$Voltage, type = "l", xlab = "datetime", ylab = "Voltage")
plot(hpc$TimeFormated, hpc$Sub_metering_1, type = "l", xlab = "", ylab = "Energy sub metering")
lines(hpc$TimeFormated, hpc$Sub_metering_2, type = "l", col = "red")
lines(hpc$TimeFormated, hpc$Sub_metering_3, type = "l", col = "blue")
legend("topright", bty = "n", lty = c(1,1,1), col = c("black", "red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"))
plot(hpc$TimeFormated, hpc$Global_reactive_power, type = "l", xlab = "datetime", ylab = "Global_reactive_power")
dev.off()
