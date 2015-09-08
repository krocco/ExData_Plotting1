## set the column classes, reading dates as characters at first
cols <- c(rep("character",2),rep("numeric",7))

## read the data into a large dataframe
largeData <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?", colClasses= cols)

## subset the data for the dates in question
keyDates <- c("1/2/2007","2/2/2007")

data <- subset(bigData, Date == keyDates[1] | Date == keyDates[2])

## purge the large dataset from memory
rm(largeData)

## reclass dates and times after combinging to a single column
data$Date <- paste(data$Date,data$Time,sep = " ")
data$Date <- strptime(data$Date, "%d/%m/%Y%H:%M:%S")

# open png
png(file = "plot4.png")
# set grid plotting 2 x 2
par(mfrow = c(2,2))

# set the title of the plot
title = "Energy sub metering"

# First Plot
plot(data$Date,data$Global_active_power, ylab = "Global Active Power", xlab = "", type = "l")

# 2nd plot
plot(data$Date,data$Voltage, ylab = "Voltage", xlab = "datetime", type = "l")

# 3rd plot
plot(data$Date,data$Sub_metering_1, col = "black",ylab = title, xlab = "", type = "l")
lines(data$Date,data$Sub_metering_2, col = "red")
lines(data$Date,data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1)

#4th plot
plot(data$Date,data$Global_reactive_power, ylab = "Global_reactive_power", xlab = "datetime", type = "l")

# close the png device
dev.off()

