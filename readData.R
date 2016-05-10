#Reading Data

if(!dir.exists("HPC_Data")){
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(url, "power_consumption.zip")
unzip("power_consumption.zip",exdir = "HPC_Data")
hpc_data <- read.table("HPC_Data/household_power_consumption.txt", sep = ";", header = TRUE, na = "?",colClasses = c("character","character",rep("numeric",7)))        
}


#Subsetting data for the requied dates only
data2plot <- subset(hpc_data,Date == "1/2/2007" | Date == "2/2/2007")

#Formatting the time stamp
timeStamp <- strptime(paste(data2plot$Date,data2plot$Time), "%d/%m/%Y %H:%M:%S")