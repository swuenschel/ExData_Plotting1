plot2 = function(){
  
  #subset - grep is slow so only do once and save the first values of each
  #change to using nLow[1] and nHigh[1] after debugging for use on other files
  #nLow  = grep("1/2/2007",readLines("household_power_consumption.txt")) 
  nLow = 66638
  #nHigh = grep("3/2/2007",readLines("household_power_consumption.txt")) 
  nHigh = 69518
  
  inData = read.csv("household_power_consumption.txt", skip = nLow, nrows = (nHigh-nLow), na.strings = "?", sep = ";")
  names(inData) = c("Date","Time","Global_active_power","Global_reactive_power","Voltage","Global_intensity",
                    "Sub_metering_1","Sub_metering_2","Sub_metering_3")
  inData$Date = as.Date(inData$Date,"%d/%m/%Y")
  
  png(filename = "plot2.png", width = 480, height = 480)

  plt = ts(inData$Global_active_power, frequency = 1440)
  days= c(inData$Date[1], inData$Date[length(inData$Date)/2], inData$Date[length(inData$Date)])
  tsp = attributes(plt)$tsp
  plot.ts(plt, xaxt = "n", xlab = NULL, ylab = "Global Active Power (kilowatts)")
  axis(1,at = c(tsp[1],tsp[2]-tsp[1],tsp[2]), labels = format(days,"%a"))

  dev.off()
}