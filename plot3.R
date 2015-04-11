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

png("plot3.png")
plot(rdata$DateTime, rdata$Sub_metering_1, type = "n", xlab = "", ylab = "Energy sub metering")
lines(rdata$DateTime, rdata$Sub_metering_1, type = "l", col = "black")
lines(rdata$DateTime, rdata$Sub_metering_2, type = "l", col = "red")
lines(rdata$DateTime, rdata$Sub_metering_3, type = "l", col = "blue")

legend("topright", legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty =  c(1,1,1), 
                        lwd = c(1, 1, 1), col = c("black", "red", "blue"))
dev.off()
