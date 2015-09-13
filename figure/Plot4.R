setwd("~/Desktop/rhyam/ExData")
if(!file.exists('Data.zip')){
        url<-"http://archive.ics.uci.edu/ml/machine-learning-databases/00235/household_power_consumption.zip"
        
        download.file(url,destfile = "Data.zip")
}
unzip("Data.zip")
Data<- read.table("household_power_consumption.txt", header=TRUE, sep=";")
Data$DateTime <- paste(Data$Date, Data$Time)
Data$DateTime<-strptime(Data$DateTime, "%d/%m/%Y %H:%M:%S")
Beg<-which(Data$DateTime==strptime("2007-02-01", "%Y-%m-%d"))
End<-which(Data$DateTime==strptime("2007-02-02 23:59:00", "%Y-%m-%d %H:%M:%S"))

Data2 <- Data[Beg:End,]
Data2$GlobalActivePower<-as.numeric(as.character(Data2$Global_active_power))
Data2$GlobalReactivePower<-as.numeric(as.character(Data2$Global_reactive_power))
Data2$Voltage<-as.numeric(as.character(Data2$Voltage))
Data2$Sub_metering_1<-as.numeric(as.character(Data2$Sub_metering_1))
Data2$Sub_metering_2<-as.numeric(as.character(Data2$Sub_metering_2))
Data2$Sub_metering_3<-as.numeric(as.character(Data2$Sub_metering_3))

plot4 <- function() {
        par(mfrow=c(2,2))
        plot(Data2$DateTime,Data2$GlobalActivePower,type='l',xlab="",ylab="Global Active Power")
        plot(Data2$DateTime,Data2$Voltage,type='l',xlab="datetime",ylab="Voltage")
        plot(Data2$DateTime,Data2$Sub_metering_1,type='l',xlab="",ylab="Energy sub metering")
        lines(Data2$DateTime,Data2$Sub_metering_2,col="red")
        lines(Data2$DateTime,Data2$Sub_metering_3,col="blue")
        legend('topright', c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), lty=c(1,1,1),
               col=c("black","red","blue"))
        
        plot(Data2$DateTime,Data2$Global_reactive_power,type='l',xlab="datetime",ylab="Global_reactive_power")
        dev.copy(png, file="plot4.png", width=480, height=480)
        dev.off()
        cat("plot4.png has been saved in", getwd())
}
plot4()