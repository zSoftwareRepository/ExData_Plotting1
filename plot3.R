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
 
# Plotting:
png("plot3.png",width=480,height=480,units="px")

with(dt_data, 
     plot(x=DateTime, y=Sub_metering_1+Sub_metering_2+Sub_metering_3,
          type='n',
          ylim=c(0,40),
          ylab="Energy sub metering",
          xlab=""))    

with(dt_data,lines(DateTime,Sub_metering_1,col="black"))
with(dt_data,lines(DateTime,Sub_metering_2,col="blue"))
with(dt_data,lines(DateTime,Sub_metering_3,col="red"))

legend("topright",lty=c(1,1), col = c("black","blue", "red"), 
       legend = colnames(dt_data)[6:8], cex=0.8,xjust=0,seg.len = 3)

dev.off()