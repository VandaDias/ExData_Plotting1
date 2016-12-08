# opens needed packages
library(dplyr)

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

# outputs plot 1
png(file = "plot1.png", width = 480, height = 480)
hist(hpc$Global_active_power, col = "red", main = "Global Active Power", xlab = "Global Acive Power (kilowatts)", ylab = "Frequency")
dev.off()
