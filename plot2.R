#
library(sqldf)
library(data.table)
#
# SQLite does not have date data type, the selection is using
# character type for the date restriction
#
sqlt <- "select * from file where Date = '1/2/2007' or Date ='2/2/2007'"
data <- read.csv.sql("household_power_consumption.txt", 
                     sql = sqlt, header=TRUE, sep=";")

# Create data set for the plot, converting date+time from character to 
# date
dt_data <- data.table(DateTime = as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S"),
                      data[,3:9])
#
# Plotting:
png("plot2.png",width=480,height=480,units="px")
#
with(dt_data, 
     plot(x=DateTime, y=Global_active_power,
          type='l', 
          ylab="Global Active Power (kilowatts)",
          xlab="")) 
dev.off()
