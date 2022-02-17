library(lubridate)
library(dplyr)

#Reads the table and and cleans the "?"s
t <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, 
                na.strings = "?")

#Converts the character Date to POSIXlt and then formats as character in the 
#new order "%Y-%m-%d"
t$Date <- format(strptime(t$Date, "%d/%m/%Y"), "%Y-%m-%d")

#Creates a new column "dt" that combines date and time
t <- mutate(t, dt = with(t, ymd(Date) + hms(Time)))

#Creates subset of date range being looked at
t <- subset(t, Date == "2007-02-01" | Date == "2007-02-02")

#Creates png file
png(filename = "plot2.png", width = 480, height = 480)

#Creates plot
with(t, plot(dt, Global_active_power, type = "l", xlab = "", 
             ylab = "Global Active Power (kilowatts)"))

dev.off() #Closes device