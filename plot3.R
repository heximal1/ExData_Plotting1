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

#plot line graph with Sub_metering_1
par(mfrow = c(1, 1)) #necessary to get a full size graph after running plot4.R
library(datasets)
with(a, plot(datetime,Sub_metering_1, type="l", xlab = "", 
	ylab = "Energy sub metering", main = ""))

#add lines for Sub_metering_1 and Sub_metering_2
with(a, lines(datetime, Sub_metering_2, col = "red"))
with(a, lines(datetime, Sub_metering_3, col = "blue"))

#add legend
legend("topright", lty = 1, col = c("black","red","blue"), 
	legend = c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"))

#dev.copy(png, file = "plot3.png")
#dev.off()

