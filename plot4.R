library(lubridate)

#Creating working directory.
setwd("~/")
if(!dir.exists("DataProyect")){
     dir.create("DataProyect")
     url<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
     download.file(url,destfile="~/DataProyect/data.zip")     
     unzip("~/DataProyect/data.zip")
}
#Reading data.
setwd("~/DataProyect")
data<-read.table("household_power_consumption.txt",sep=";",header = TRUE)

#Formatting variables
data$Date<-as.Date(strptime(data$Date,format = "%d/%m/%Y"))
data$Time<-as.character(data$Time)
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power<-as.numeric(as.character(data$Global_reactive_power))
data$Voltage<-as.numeric(as.character(data$Voltage))
data$Global_intensity<-as.numeric(as.character(data$Global_intensity))
data$Sub_metering_1<-as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2<-as.numeric(as.character(data$Sub_metering_2))

#Subsetting data frame.
dat<-data[("2007-02-01"<=data$Date & data$Date<="2007-02-02"),]
dat$dateTime<-ymd_hms(paste(dat$Date,dat$Time,sep=" ")) 

#Drawing the set of plots.
windows()
par(mfrow=c(2,2),mar=c(4,4,2,2))
with(dat,plot(dateTime,Global_active_power,type="l",
              ylab="Global Active Power",xlab=""))
with(dat,plot(dateTime,Voltage,type="l",xlab="datetime",ylab="Voltage"))
with(dat,plot(dateTime,Sub_metering_1,type="l",
              ylab="Energy sub metering",xlab=""))
lines(dat$dateTime,dat$Sub_metering_2,col="red")
lines(dat$dateTime,dat$Sub_metering_3,col="blue")
legend("topright",c("Sub_metering_1","Sub_metering_2","Sub_metering_3"),
       col=c("black","red","blue"),bty="o",lty=1)
with(dat,plot(dateTime,Global_reactive_power,type="l",xlab="datetime",
              ylab="Global_reactive_power"))

#Inserting the plots into a png archive.
dev.copy(png,file="plot4.png")
dev.off()
