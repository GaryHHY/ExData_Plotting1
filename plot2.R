# Read data frrom zip file
data <- read.table(unz("./exdata_data_household_power_consumption.zip", "household_power_consumption.txt"),header=T, sep=";")

#Subset data to only include records from "2007-02-01" to "2007-02-02"
newdata <- subset(data,as.Date(Date,"%d/%m/%Y") >= "2007-02-01" & as.Date(Date,"%d/%m/%Y") <= "2007-02-02")

#Concatenate Date and Time column to create new column called Data_time and convert it to POSIXlt format
newdata$Date_time <- paste(newdata$Date,newdata$Time,sep = " ")
newdata$Date_time <- strptime(newdata$Date_time,"%d/%m/%Y %H:%M:%S")

#Remove NA(?) data
newdata <- newdata[newdata$Global_active_power != "?",]

#Convert Column Global_active_power to number
newdata$Global_active_power <- as.numeric(newdata$Global_active_power)

#Open png device
png(filename = "plot2.png", width = 480, height = 480, units = "px",bg = "white")

#plot the line graph
plot(newdata$Date_time,newdata$Global_active_power,xlab="",ylab="Global Active Power (kilowatts)",type = "l", lty = 1)

#close device
dev.off()
