#
library(sqldf)
library(data.table)
#
sqlt <- "select * from file where Date = '1/2/2007' or Date ='2/2/2007'"
data <- read.csv.sql("household_power_consumption.txt", sql = sqlt, header=TRUE, sep=";")

dt_data <- data.table(Date=as.Date(data$Date, format="%d/%m/%Y"),
                      DateTime = as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S"),
                      data[,3:9])
 
with(dt_data, 
     plot(x=DateTime, y=Global_active_power,
          type='l', 
          ylab="Global Active Power (kilowatts)",
          xlab="")) 


