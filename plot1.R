plot1 = function(){
  
  #subset - grep is slow so only do once and save the first values of each
  #change to using nLow[1] and nHigh[1] after debugging for use on other files
  #nLow  = grep("1/2/2007",readLines("household_power_consumption.txt")) 
  nLow = 66638
  #nHigh = grep("3/2/2007",readLines("household_power_consumption.txt")) 
  nHigh = 69518

  inData = read.csv("household_power_consumption.txt", skip = nLow, nrows = (nHigh-nLow), na.strings = "?", sep = ";")
  names(inData) = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity",
                    "Sub_metering_1","Sub_metering_2","Sub_metering_3")
  
  png(filename = "plot1.png", width = 480, height = 480)
  hist(inData$Global_active_power,col = "red",xlab = "Global Active Power (kilowatts)", ylab = "Frequency", 
       main = "Global Active Power", ylim = c(0,1201))
  dev.off()
}