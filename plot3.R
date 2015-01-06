# Load data from file (assuming that file is in current directory)
# Missing values are handled using the na.string option of read.csv  
data <- read.csv("household_power_consumption.txt", 
                 sep = ";", 
                 na.strings = c("?", "NA")
)

# Add timestamp column to data frame
data$ts <- strptime(paste(data$Date, data$Time), 
                    format = "%d/%m/%Y %H:%M:%S"
)

# Subset on date range [2007-02-01,2007-02-02]
df <- subset(x = data, ts >= "2007-02-01" & ts < "2007-02-03")

# Evaluate common ylim range 
subMeterLimits <- c(
    min(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3), 
    max(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3)
    )

# --- Plot the graph

# Prepare png device
png(filename = "plot3.png", width = 480, height = 480)

# Limit overall fontsize to 80%
par(cex = 0.8)

# Plot Sub_metering_1 (black)
plot(df$ts,df$Sub_metering_1, type ="l", xlab = "", 
     ylab = "Energy sub metering", 
     ylim = subMeterLimits)

# Add to existing plot
par(new = TRUE)

# Add Sub_metering_2 (red)
plot(df$ts,df$Sub_metering_2, type ="l", xlab = "", ylab = "", 
     ylim = subMeterLimits, col = "red")

# Add to existing plot
par(new = TRUE)

# Add Sub_metering_2 (red)
plot(df$ts,df$Sub_metering_3, type ="l", xlab = "", ylab = "", 
     ylim = subMeterLimits, col = "blue")

# Add legend
legend("topright", 
       legend = c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), 
       col= c("black","red","blue"), 
       lty = 1 
       )

# Close png device
dev.off()