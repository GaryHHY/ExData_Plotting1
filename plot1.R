# Read data frrom zip file
data <- read.table(unz("./exdata_data_household_power_consumption.zip", "household_power_consumption.txt"),header=T, sep=";")

#Subset data to only include records from "2007-02-01" to "2007-02-02"
newdata <- subset(data,as.Date(Date,"%d/%m/%Y") >= "2007-02-01" & as.Date(Date,"%d/%m/%Y") <= "2007-02-02")

#Remove NA(?) data
newdata <- newdata[newdata$Global_active_power != "?",]

#Convert Column Global_active_power to number
newdata$Global_active_power <- as.numeric(newdata$Global_active_power)

#Open png device
png(filename = "plot1.png", width = 480, height = 480, units = "px",bg = "white")

#plot histogram
hist(newdata$Global_active_power,main = "Global Active Power", xlab="Global Active Power (kilowatts)", ylab="Frequency", col= "red")

#close device
dev.off()
