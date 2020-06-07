# Read data frrom zip file
data <- read.table(unz("./exdata_data_household_power_consumption.zip", "household_power_consumption.txt"),header=T, sep=";")

#Subset data to only include records from "2007-02-01" to "2007-02-02"
newdata <- subset(data,as.Date(Date,"%d/%m/%Y") >= "2007-02-01" & as.Date(Date,"%d/%m/%Y") <= "2007-02-02")

#Concatenate Date and Time column to create new column called Data_time and convert it to POSIXlt format
newdata$Date_time <- paste(newdata$Date,newdata$Time,sep = " ")
newdata$Date_time <- strptime(newdata$Date_time,"%d/%m/%Y %H:%M:%S")

#Convert columns format from chr to num
newdata$Global_active_power <- as.numeric(newdata$Global_active_power)
newdata$Global_reactive_power <- as.numeric(newdata$Global_reactive_power)
newdata$Voltage <- as.numeric(newdata$Voltage)
newdata$Sub_metering_1 <- as.numeric(newdata$Sub_metering_1)
newdata$Sub_metering_2 <- as.numeric(newdata$Sub_metering_2)
newdata$Sub_metering_3 <- as.numeric(newdata$Sub_metering_3)

#Open png device
png(filename = "plot4.png", width = 480, height = 480, units = "px",bg = "white")

#4 Base plots in 1 Graph
par(mfrow = c(2,2))
# 1 plot
plot(newdata$Date_time,newdata$Global_active_power,xlab="",ylab="Global Active Power",type = "l", lty = 1)
# 2 plot
plot(newdata$Date_time,newdata$Voltage,xlab="datetime",ylab="Voltage",type = "l", lty = 1)
# 3 plot
plot(newdata$Date_time,newdata$Sub_metering_1,xlab="",ylab="Energy Sub metering",type = "l", lty = 1, col = "black")
lines(newdata$Date_time,newdata$Sub_metering_2,type = "l", lty = 1, col = "red")
lines(newdata$Date_time,newdata$Sub_metering_3,type = "l", lty = 1, col = "blue")
legend("topright", lty = 1 , col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))
#4 plot
plot(newdata$Date_time,newdata$Global_reactive_power,xlab="datetime",ylab="Global_reactive_power",type = "l", lty = 1)

#close device
dev.off()