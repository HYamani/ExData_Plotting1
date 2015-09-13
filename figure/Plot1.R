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



plot1 <- function() {
        hist(Data2$GlobalActivePower, main="Global Active Power",
             xlab="Global Active Power (kilowatts)", col ="red")
        dev.copy(png, file="plot1.png", width=480, height=480)
        dev.off()
        cat("Plot1.png has been saved in", getwd())
}
plot1()