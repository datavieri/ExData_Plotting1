data <- read.csv("household_power_consumption.txt", 
                 sep = ";", 
                 na.strings = c("?", "NA")
                 )

data$ts <- strptime(paste(data$Date, data$Time), 
                    format = "%d/%m/%Y %H:%M:%S"
                    )

df <- subset(x = data, ts >= "2007-02-01" & ts < "2007-02-03")

par(cex = 0.8)
png(filename = "plot2.png", width = 480, height = 480)
plot(df$ts,df$Global_active_power, 
     type ="l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)"
     )

dev.off()