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

#Formatting variables.
data$Date<-as.Date(strptime(data$Date,format = "%d/%m/%Y"))
data$Time<-as.character(data$Time)
data$Global_active_power<-as.numeric(as.character(data$Global_active_power))
data$Global_reactive_power<-as.numeric(as.character(data$Global_reactive_power))
data$Voltage<-as.numeric(as.character(data$Voltage))
data$Global_intensity<-as.numeric(as.character(data$Global_intensity))
data$Sub_metering_1<-as.numeric(as.character(data$Sub_metering_1))
data$Sub_metering_2<-as.numeric(as.character(data$Sub_metering_2))

#Subsetting data frame.
dat<-data[("2007-02-01"<=data$Date & data$Date<="2007-02-02"),1:3]
dat$dateTime<-ymd_hms(paste(dat$Date,dat$Time,sep=" ")) 

#Drawing the scatterplot.
with(dat,plot(dateTime,Global_active_power,type="l",
              ylab="Global Active Power (kilowatts)",xlab=""))

#Inserting the plot into a png archive.
dev.copy(png,file="plot2.png")
dev.off()