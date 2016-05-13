##======================================================================
##Use setwd()to set the working directory

##Download file
if(!file.exists("./explor")){dir.create("./explor")}
fileUrl <- "https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip"
download.file(fileUrl,destfile="./explor/PowerConsumption.zip",method="auto")

##Unzip DataSet to /explor directory
unzip(zipfile="./explor/PowerConsumption.zip",exdir="./explor")

##======================================================================

##Read the data from the /explor directory, where the file was unzipped
file <- "./explor/household_power_consumption.txt"
data <- read.table(file,
                   header = TRUE, 
                   sep = ";", 
                   colClasses=c("character", "character", rep("numeric",7)),
                   na="?")
## Convert date and time variables
data$Time <- strptime(paste(data$Date, data$Time), "%d/%m/%Y %H:%M:%S")
data$Date <- as.Date(data$Date, "%d/%m/%Y")

##  Use only data from the dates 2007-02-01 and 2007-02-02
selection <- as.Date(c("2007-02-01", "2007-02-02"), "%Y-%m-%d")
data <- subset(data, Date %in% selection)

##Plot1
plot1 <- function() {
  hist(data$Global_active_power, 
       main = paste("Global Active Power"), 
       col="red", 
       xlab="Global Active Power (kilowatts)")
  dev.copy(png, file="./explor/plot1.png", width=480, height=480)
  dev.off()
  }
plot1()
