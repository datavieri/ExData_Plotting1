data <- read.csv("household_power_consumption.txt", 
                 sep = ";", 
                 na.strings = c("?", "NA")
                 )

data$ts <- strptime(paste(data$Date, data$Time), 
                    format = "%d/%m/%Y %H:%M:%S"
                    )

df <- subset(x = data, ts >= "2007-02-01" & ts < "2007-02-03")

subMeterLimits <- c(
    min(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3), 
    max(df$Sub_metering_1, df$Sub_metering_2, df$Sub_metering_3)
    )

par(cex = 0.8)
png(filename = "plot3.png", width = 480, height = 480)

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
       lty = 1 
       )

dev.off()