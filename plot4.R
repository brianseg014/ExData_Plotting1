# Read data with headers
consumption <- read.table("household_power_consumption.txt", sep=";", header=T, na.strings="?")

# Parse columns as date, time and numeric
consumption$Date <- as.Date(consumption$Date, format="%d/%m/%Y")
consumption$Time <- strptime(consumption$Time, format="%H:%M:%S")
consumption$Global_active_power <- as.numeric(consumption$Global_active_power)
consumption$Global_reactive_power <- as.numeric(consumption$Global_reactive_power)
consumption$Voltage = as.numeric(consumption$Voltage)
consumption$Sub_metering_1 = as.numeric(consumption$Sub_metering_1)
consumption$Sub_metering_2 = as.numeric(consumption$Sub_metering_2)
consumption$Sub_metering_3 = as.numeric(consumption$Sub_metering_3)

# Select information for required dates
feb <- subset(consumption, Date >= "2007-02-01" & Date <= "2007-02-02")

# Create a mixed date and time column
feb$DateTime <- strptime(paste(format(feb$Date, "%Y-%m-%d"), format(feb$Time, "%H:%M:%S")), format="%Y-%m-%d %H:%M:%S")

# Plot 4 charts to png file
png("plot4.png", width = 480, height = 480)
par(mfrow=c(2,2))
plot(feb$DateTime, feb$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
plot(feb$DateTime, feb$Voltage, type="l", xlab="datetime", ylab="Voltage")
with(feb, plot(DateTime, Sub_metering_1, type="n", xlab="", ylab="Energy sub metering"))
with(feb, lines(DateTime, Sub_metering_1))
with(feb, lines(DateTime, Sub_metering_2, col="red"))
with(feb, lines(DateTime, Sub_metering_3, col="blue"))
legend("topright", col=c("black", "red", "blue"), legend=c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=1, cex=0.7, bty="n")
plot(feb$DateTime, feb$Global_reactive_power, type="l", xlab="datetime", ylab="Global_reactive_power")
dev.off()