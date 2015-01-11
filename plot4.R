#
library(sqldf)
library(data.table)
#
sqlt <- "select * from file where Date = '1/2/2007' or Date ='2/2/2007'"
data <- read.csv.sql("household_power_consumption.txt", sql = sqlt, header=TRUE, sep=";")

dt_data <- data.table(DateTime = as.POSIXct(paste(data$Date, data$Time), format="%d/%m/%Y %H:%M:%S"),data[,3:9])
 


par(mfrow = c(2, 2))
par(mar=c(3, 4, 4, 1))
with(dt_data, 
     plot(x=DateTime, y=Global_active_power,
          type='l',
          ylab="Global active power",
          xlab=""))    

with(dt_data, 
     plot(x=DateTime, y=Voltage,
          type='l',
          ylab="Voltage",
          xlab="datetime"))    



with(dt_data, 
     plot(x=DateTime, y=Sub_metering_1+Sub_metering_2+Sub_metering_3,
          type='n',
          ylim=c(0,40),
          ylab="Energy sub metering",
          xlab=""))    

with(dt_data,lines(DateTime,Sub_metering_1,col="black"))
with(dt_data,lines(DateTime,Sub_metering_2,col="blue"))
with(dt_data,lines(DateTime,Sub_metering_3,col="red"))
legend("topright",lty=c(1,1), col = c("black","blue", "red"), legend = colnames(dt_data)[6:8], cex=0.8,xjust=0,bty = "n")


with(dt_data, 
     plot(x=DateTime, y=Global_reactive_power,
          type='l',
          ylab="Global_reactive_power",
          xlab="datetime"))    
