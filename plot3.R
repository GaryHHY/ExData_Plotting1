# Read data frrom zip file
data <- read.table(unz("./exdata_data_household_power_consumption.zip", "household_power_consumption.txt"),header=T, sep=";")

#Subset data to only include records from "2007-02-01" to "2007-02-02"
newdata <- subset(data,as.Date(Date,"%d/%m/%Y") >= "2007-02-01" & as.Date(Date,"%d/%m/%Y") <= "2007-02-02")

#Concatenate Date and Time column to create new column called Data_time and convert it to POSIXlt format
newdata$Date_time <- paste(newdata$Date,newdata$Time,sep = " ")
newdata$Date_time <- strptime(newdata$Date_time,"%d/%m/%Y %H:%M:%S")

#Convert columns format from chr to num
newdata$Global_active_power <- as.numeric(newdata$Global_active_power)
newdata$Sub_metering_1 <- as.numeric(newdata$Sub_metering_1)
newdata$Sub_metering_2 <- as.numeric(newdata$Sub_metering_2)
newdata$Sub_metering_3 <- as.numeric(newdata$Sub_metering_3)

#Open png device
png(filename = "plot3.png", width = 480, height = 480, units = "px",bg = "white")

#Plot three lines graphs with legends
plot(newdata$Date_time,newdata$Sub_metering_1,xlab="",ylab="Energy Sub metering",type = "l", lty = 1, col = "black")
lines(newdata$Date_time,newdata$Sub_metering_2,type = "l", lty = 1, col = "red")
lines(newdata$Date_time,newdata$Sub_metering_3,type = "l", lty = 1, col = "blue")
legend("topright", lty = 1 , col = c("black","red", "blue"), legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

#close device
dev.off()