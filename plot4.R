## Set classes to speed up read.table

tmp <- read.table("household_power_consumption.txt", header = TRUE,
                  sep = ";", nrows = 5)
classes <- sapply(tmp, class)

## Load in data

rawdata <- read.table("household_power_consumption.txt", header = TRUE,
                      sep = ";", na.strings = "?", colClasses = classes)

## Subset data to two dates

rdata <- subset(rawdata, rawdata$Date == "1/2/2007" | rawdata$Date == "2/2/2007")

## Convert date and time into Date and Time classes respectively

rdata$DateTime <- strptime(paste(rdata$Date, rdata$Time, sep = ":"), 
                           format = "%d/%m/%Y:%H:%M:%S")

## Construct and save plot

png("plot4.png")

par(mfrow = c(2,2))

plot(rdata$DateTime, rdata$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power")
lines(rdata$DateTime, rdata$Global_active_power, type = "l")

plot(rdata$DateTime, rdata$Voltage, type = "n", xlab = "datetime", ylab = "Voltage")
lines(rdata$DateTime, rdata$Voltage, type = "l")

plot(rdata$DateTime, rdata$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(rdata$DateTime, rdata$Sub_metering_1, type = "l", col = "black")
lines(rdata$DateTime, rdata$Sub_metering_2, type = "l", col = "red")
lines(rdata$DateTime, rdata$Sub_metering_3, type = "l", col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), bty = "n", lty =  c(1,1,1), 
       lwd = c(2.5, 2.5, 2.5), col = c("black", "red", "blue"))

plot(rdata$DateTime, rdata$Global_reactive_power, type = "n", xlab = "datetime", ylab = "Global_reactive_power")
lines(rdata$DateTime, rdata$Global_reactive_power, type = "l")

dev.off()
