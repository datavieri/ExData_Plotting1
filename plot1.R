data <- read.csv("household_power_consumption.txt", 
                 sep = ";", 
                 na.strings = c("?", "NA")
                 )

data$ts <- strptime(paste(data$Date, data$Time), 
                    format = "%d/%m/%Y %H:%M:%S"
                    )

df <- subset(x = data, ts >= "2007-02-01" & ts < "2007-02-03")

par(cex = 0.8)
png(filename = "plot1.png", width = 480, height = 480)
hist(df$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylim = c(0,1200))

dev.off()