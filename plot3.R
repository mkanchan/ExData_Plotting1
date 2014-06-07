library(sqldf)
temp <- tempfile()
download.file("https://d396qusza40orc.cloudfront.net/exdata%2Fdata%2Fhousehold_power_consumption.zip",
              temp,
              mode="wb")
fname <- "household_power_consumption.txt"
con <- unzip(temp,fname)
df <- read.csv.sql(con, 
                   sql='select * from file where Date == "1/2/2007" 
                   or Date == "2/2/2007"', 
                   header=TRUE, 
                   sep=';')
unlink(temp)
df$DateTime <-  strptime(paste(df$Date,df$Time),"%d/%m/%Y%H:%M:%S")

plot(df$DateTime,as.numeric(df$Sub_metering_1),
     type="l", 
     xlab="",
     ylab="Energy sub metering", 
     col="black")

lines(df$DateTime,df$Sub_metering_2,type="l", col="red")

lines(df$DateTime,df$Sub_metering_3,type="l", col="blue")

legend("topright",
       legend=(c("Sub_metering_1","Sub_metering_2","Sub_metering_3")), 
       col=c("black","red","blue"), 
       lty=1,
       text.width=strwidth("Sub_metering_3______"))


dev.copy(png,file="plot3.png")
dev.off()
