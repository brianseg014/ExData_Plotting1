# Read data with headers
consumption <- read.table("household_power_consumption.txt", sep=";", header=T, na.strings="?")

# Parse columns as date
consumption$Date <- as.Date(consumption$Date, format="%d/%m/%Y")

# Select information for required dates
feb <- subset(consumption, Date >= "2007-02-01" & Date <= "2007-02-02")

# Plot hist on png file by Global_active_power
png("plot1.png", width = 480, height = 480)
hist(feb$Global_active_power, col="red", xlab="Global Active Power (kilowatts)", main="Global Active Power")
dev.off()