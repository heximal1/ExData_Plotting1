#download zip file
library(downloader)
download("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip", destfile="exdata_data_household_power_consumption.zip")

#create connection to zip file 
zippedfile <- unz("./exdata_data_household_power_consumption.zip",
	"household_power_consumption.txt")

# read data into 'a', ommitting ? chars, 
a <- read.delim(zippedfile, 
	header = TRUE, sep = ";", quote = "\"",
	dec = ".", fill = TRUE, comment.char = "?", stringsAsFactors = FALSE)

# create datetime, convert from chr to POSIXlt 
a$datetime <- paste(a$Date,a$Time)
a$datetime <- strptime(a$datetime, format = "%d/%m/%Y %H:%M:%S")

#convert Date from chr to date 
a$Date <- as.Date(a$Date,"%d/%m/%Y")

#subset 'a' to desired dates: 2007-02-01 and 2007-02-02
a <- a[a$Date >= "2007-02-01"  & a$Date <= "2007-02-02",]

# create 4 graphs as described in comments below.
library(datasets)
par(mfrow = c(2, 2))
with(a, {
    #plot upper left - Global_active_power
    plot(datetime,Global_active_power, type="l",
	xlab = "", ylab = "Global Active Power (kilowatts)",
	main = "")
    #plot upper right - Voltage 
	plot(datetime,Voltage, type="l", xlab = "datetime", 
	ylab = "Voltage", main = "")


    #plot lower left - Energy sub metering
    plot(datetime,Sub_metering_1, type="l", xlab = "", 
	ylab = "Energy sub metering", main = "")
    lines(datetime, Sub_metering_2, col = "red")
    lines(datetime, Sub_metering_3, col = "blue")
    legend("topright", lty = 1, col = c("black","red","blue"), 
	legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

    #plot lower right - Global_reactive_power
	plot(datetime,Global_reactive_power, type="l", xlab = "datetime", 
	ylab = "Global_reactive_power", main = "")
})

#dev.copy(png, file = "plot4.png")
#dev.off()

