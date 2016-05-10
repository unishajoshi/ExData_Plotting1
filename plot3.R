#Reading data
source("readData.R")

#Creating a png 480*480
png("plot3.png", height = 480, width = 480)

#Plot
plot(timeStamp, data2plot$Sub_metering_1, type= "l", xlab="", ylab="Energy sub metering")
lines(timeStamp, data2plot$Sub_metering_2, col="red")
lines(timeStamp, data2plot$Sub_metering_3, col="blue")

#legend
legend("topright", 
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)

dev.off()