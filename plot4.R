#Reading data
source("readData.R")

#Creating a png 480*480
png("plot4.png", height = 480, width = 480)


par(mfrow= c(2,2))

#Plot
plot(timeStamp, data2plot$Global_active_power, type= "l", xlab="", ylab="Global Active power")
plot(timeStamp, data2plot$Voltage, type="l",xlab="datetime",ylab = "Voltage")
plot(timeStamp, data2plot$Sub_metering_1, type= "l", xlab="", ylab="Energy sub metering")
lines(timeStamp, data2plot$Sub_metering_2, col="red")
lines(timeStamp, data2plot$Sub_metering_3, col="blue")

#legend
legend("topright", 
       col = c("black", "red", "blue"),
       c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"),
       lwd = 1)

#plot data in 2nd row and 2nd column
plot(timeStamp, data2plot$Global_reactive_power, type="l",xlab="datetime",ylab = "Global_reactive_power")

dev.off()