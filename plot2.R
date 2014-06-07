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

plot(df$DateTime,as.numeric(df$Global_active_power),
     type="l", 
     xlab="",
     ylab="Global Active Power (kilowatts)")

dev.copy(png,file="plot2.png")
dev.off()
