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


# set the title of the plot
title = "Energy sub metering"
# open the png device
png(file = "plot3.png")
plot(data$Date,data$Sub_metering_1, col = "black",ylab = title, xlab = "", type = "l")
lines(data$Date,data$Sub_metering_2, col = "red")
lines(data$Date,data$Sub_metering_3, col = "blue")
legend("topright", legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), col = c("black","red","blue"), lty = 1)
dev.off()