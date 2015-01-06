# Load data from file (assuming that file is in current directory)
# Missing values are handled using the na.string option of read.csv  
data <- read.csv("household_power_consumption.txt", 
                 sep = ";", 
                 na.strings = c("?", "NA")
)

# Add timestamp column
data$ts <- strptime(paste(data$Date, data$Time), 
                    format = "%d/%m/%Y %H:%M:%S"
)

# Subset on date range [2007-02-01,2007-02-02]
df <- subset(x = data, ts >= "2007-02-01" & ts < "2007-02-03")

# Evaluate common ylim range for sub metering (Plot 2.1)
subMeterLimits <- c(
    min(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3), 
    max(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3)
)

# --- Plot the four graphs

# Prepare png device
png(filename = "plot4.png", width = 480, height = 480)

# Set layout to a 2x2 matrix
par(mfrow=c(2,2))

# Limit overall fontsize
par(cex = 0.8)

# Plot 1.1 - Global Active Power
plot(df$ts,df$Global_active_power, type ="l", xlab = "", ylab = "Global Active Power")

# Plot 1.2 - Voltage
plot(df$ts,df$Voltage, type ="l", xlab = "datetime", ylab = "Voltage")

# Plot 2.1 - Sub Metering
plot(df$ts,df$Sub_metering_1, type ="l", xlab = "", 
       ylab = "Energy sub metering", 
       ylim = subMeterLimits)
par(new = TRUE)
plot(df$ts,df$Sub_metering_2, type ="l", xlab = "", ylab = "", 
       ylim = subMeterLimits, col = "red")
par(new = TRUE)
plot(df$ts,df$Sub_metering_3, type ="l", xlab = "", ylab = "", 
       ylim = subMeterLimits, col = "blue")
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col= c("black","red","blue"), 
       lty = 1, bty = "n" 
)

# Plot 2.2 - Global Reactive Power
plot(df$ts,df$Global_reactive_power, type ="l", xlab = "datetime", ylab = "Global_reactive_power")

# Close png device
dev.off()

