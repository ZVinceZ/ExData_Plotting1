#Reads the table and and cleans the "?"s
t <- read.table("./household_power_consumption.txt", sep = ";", header = TRUE, 
                na.strings = "?")

#Converts the character Date to POSIXlt and then formats as character in the 
#new order "%Y-%m-%d"
t$Date <- format(strptime(t$Date, "%d/%m/%Y"), "%Y-%m-%d")

#Creates png file
png(filename = "plot1.png", width = 480, height = 480)

#Creates histogram
hist(subset(t, Date == "2007-02-01" | Date == "2007-02-02")$Global_active_power, 
     main = "Global Active Power", xlab = "Global Active Power (kilowatts)", 
     col = "red")

dev.off() #Closes device