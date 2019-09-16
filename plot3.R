# Read data with headers
consumption <- read.table("household_power_consumption.txt", sep=";", header=T, na.strings="?")

# Parse columns as date, time and numeric
consumption$Date <- as.Date(consumption$Date, format="%d/%m/%Y")
consumption$Time <- strptime(consumption$Time, format="%H:%M:%S")
consumption$Sub_metering_1 = as.numeric(consumption$Sub_metering_1)
consumption$Sub_metering_2 = as.numeric(consumption$Sub_metering_2)
consumption$Sub_metering_3 = as.numeric(consumption$Sub_metering_3)

# Select information for required dates
feb <- subset(consumption, Date >= "2007-02-01" & Date <= "2007-02-02")

# Create a mixed date and time column
feb$DateTime <- strptime(paste(format(feb$Date, "%Y-%m-%d"), format(feb$Time, "%H:%M:%S")), format="%Y-%m-%d %H:%M:%S")

# Plot series to png file on each sub metering with different colors (in order black, red and blue)
png("plot3.png", width = 480, height = 480)
with(feb, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(feb, lines(DateTime, Sub_metering_1))
with(feb, lines(DateTime, Sub_metering_2, col="red"))
with(feb, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1)
dev.off()
