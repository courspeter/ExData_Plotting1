# settings
dir <- "data"
url <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
zipfile <- "exdata_data_household_power_consumption.zip"
datafile <- "household_power_consumption.txt"
dateBegin <- as.Date("2007-02-01")
dateEnd <- as.Date("2007-02-02")

# get the data file
wd <- getwd()
if (!dir.exists(dir)) dir.create(dir)
setwd(dir)
if (!file.exists(zipfile)) download.file(url, zipfile)
if (!file.exists(datafile)) unzip(zipfile, files = datafile)
setwd(wd)

# read the data
data <- read.csv(paste(dir, datafile, sep="/"), sep=";", na.strings="?")
data$Date <- as.Date(data$Date, "%d/%m/%Y")
data$Time <- strptime(paste(data$Date, data$Time), format="%Y-%m-%d %H:%M:%S")
data <- data[data$Date >= dateBegin & data$Date <= dateEnd, ]

# plot
png(filename="plot2.png")
plot(data$Time, data$Global_active_power, type="n", main="", xlab="", ylab="Global Active Power (kilowatts)")
lines(data$Time, data$Global_active_power)
dev.off()
