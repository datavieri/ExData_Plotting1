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

# --- Plot the graph

# Prepare png device
png(filename = "plot2.png", width = 480, height = 480)

par(cex = 0.8)

plot(df$ts,df$Global_active_power, 
     type ="l", 
     xlab = "", 
     ylab = "Global Active Power (kilowatts)"
     )

# Close device
dev.off()