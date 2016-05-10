#Reading data
source("readData.R")

#Creating a png 480*480
png("plot2.png", height = 480, width = 480)

#Plot
plot(timeStamp, data2plot$Global_active_power, type= "l", xlab="", ylab="Global Active Power (kilowatts)")

dev.off()