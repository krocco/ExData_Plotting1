## set the column classes, reading dates as characters at first
cols <- c(rep("character",2),rep("numeric",7))

## read the data into a large dataframe
largeData <- read.table("household_power_consumption.txt", header = T, sep = ";", na.strings = "?", colClasses= cols)

## subset the data for the dates in question
keyDates <- c("1/2/2007","2/2/2007")

data <- subset(largeData, Date == keyDates[1] | Date == keyDates[2])

## purge the large dataset from memory
rm(largeData)

## reclass dates and times after combinging to a single column
data$Date <- paste(data$Date,data$Time,sep = " ")
data$Date <- strptime(data$Date, "%d/%m/%Y%H:%M:%S")


# set the title of the plot
title = "Global Active Power"
# open the png device
png(file = "plot2.png")
plot(data$Date,data$Global_active_power, ylab = paste(title," (kilowatts)"), xlab = "", type = "l")
# close the png device
dev.off()