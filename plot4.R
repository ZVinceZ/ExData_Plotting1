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
png(filename = "plot4.png", width = 480, height = 480)

#Set up the multiple base plots
par(mfcol = c(2, 2))

#Creates first plot in top left
with(t, plot(dt, Global_active_power, type = "l", xlab = "", 
             ylab = "Global Active Power"))

#Creates second plot in bottom left
with(t, plot(dt, Sub_metering_1, type = "l", xlab = "", 
             ylab = "Energy sub metering"))
with(t, lines(dt, Sub_metering_2, col = "red"))
with(t, lines(dt, Sub_metering_3, col = "blue"))
legend("topright", col = c("black", "red", "blue"), lty = 1,
       legend = c("Sub_metering_1", "Sub_metering_2", "Sub_metering_3"), 
       bty = "n")

#Creates third plot in top right
with(t, plot(dt, Voltage, type = "l", xlab = "datetime", ylab = "Voltage"))

#Creates fourth plot in bottom right
with(t, plot(dt, Global_reactive_power, type = "l", xlab = "datetime", 
             ylab = "Global_reactive_power"))

dev.off() #Closes device