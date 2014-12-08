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

#create histograph for Global Active Power
par(mfrow = c(1, 1)) #necessary to get a full size graph after running plot4.R
hist(a$Global_active_power, col = "red", main="Global Active Power", 
	xlab="Global Active Power (kilowatts)")

dev.copy(png, file = "plot1.png")
dev.off()

