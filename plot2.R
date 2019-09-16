# Read data with headers
consumption <- read.table("household_power_consumption.txt", sep=";", header=T, na.strings="?")

# Parse columns as date, time and numeric
consumption$Date <- as.Date(consumption$Date, format="%d/%m/%Y")
consumption$Time <- strptime(consumption$Time, format="%H:%M:%S")
consumption$Global_active_power <- as.numeric(consumption$Global_active_power)

# Select information for required dates
feb <- subset(consumption, Date >= "2007-02-01" & Date <= "2007-02-02")

# Create a mixed date and time column
feb$DateTime <- strptime(paste(format(feb$Date, "%Y-%m-%d"), format(feb$Time, "%H:%M:%S")), format="%Y-%m-%d %H:%M:%S")

# Plot line over day and time by Global_active_power
png("plot2.png", width = 480, height = 480)
plot(feb$DateTime, feb$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)")
dev.off()