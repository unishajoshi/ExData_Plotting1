#Reading data
source("readData.R")

#Creating a png 480*480
png("plot1.png", height = 480, width = 480)

#plot1
hist(data2plot$Global_active_power, xlab = "Global Active power (kilowatts)", col = "red", main = "Global Active Power")

dev.off()