library(dplyr)
library(lubridate)
### Downloading and unzipping the file, if the unzipped file does not exist
fileurl<-"https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
if(!file.exists("./household_power_consumption.txt"))
{download.file(fileurl,destfile = "./electricityconsumption.zip",method = "curl")
  unzip("./electricityconsumption.zip")}
### Reading all data
colclasses<-c("character","character","numeric","numeric","numeric","numeric","numeric","numeric","numeric")
if(!exists("edata"))
{edata<-read.table("./household_power_consumption.txt",header=TRUE,sep=";",na.strings="?",colClasses = colclasses)
edata<-tbl_df(edata)
### Converting Date and Time to date
edata$Date<-dmy(edata$Date)
edata$Time<-hms(edata$Time)
datetime<-edata$Date+edata$Time 
edata<-cbind(datetime,edata)}
### Selecting data for 2007-02-01 and 2007-02-02
if(!exists("edata2"))
{edata2<-filter(edata,Date=="2007-02-01"|Date=="2007-02-02")}
head(edata2)

### Plot 2
png(filename = "plot2.png",width = 480,height = 480,units = "px",bg="transparent")
par(mfcol = c(1, 1),mar=c(4,4,2,2))
plot(edata2$datetime,edata2$Global_active_power,
     type = "l",
     xlab ="", ylab = "Global active power (kilowatts)")
dev.off()