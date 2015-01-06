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
png(filename = "plot1.png", width = 480, height = 480)

# Limit overall fontsize to 80%
par(cex = 0.8)

# Draw frequency histogram
hist(df$Global_active_power, 
     col = "red", 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)", 
     ylim = c(0,1200)) 

dev.off()