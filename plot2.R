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

png("plot2.png")
plot(rdata$DateTime, rdata$Global_active_power, type = "n", xlab = "", ylab = "Global Active Power (kilowatts)")
lines(rdata$DateTime, rdata$Global_active_power, type = "l")
dev.off()
