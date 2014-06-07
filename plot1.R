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
hist(df$Global_active_power,
     col="red",
     xlab="Global Active Power (kilowatts)",
     ylab="Frequency", 
     main="Global Active Power")
dev.copy(png,file="plot1.png")
dev.off()
