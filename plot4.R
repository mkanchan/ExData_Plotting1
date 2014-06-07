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

par(mfrow = c(2,2))
par(cex=0.7)
with(df, {
        plot(df$DateTime,as.numeric(df$Global_active_power),
             type="l", 
             xlab="",
             ylab="Global Active Power")
        
        plot(df$DateTime,as.numeric(df$Voltage),
             type="l", 
             xlab="datetime",
             ylab="Voltage")
        
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
               bty="n",
               text.width=strwidth("Sub_metering_3______"))
        
        plot(df$DateTime,as.numeric(df$Global_reactive_power),
             type="l", 
             xlab="datetime",
             ylab="Global_reactive_power")
        
})

dev.copy(png,file="plot4.png")
dev.off()
