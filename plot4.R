plot4 = function(){
  
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
  
  png(filename = "plot4.png", width = 480, height = 480)
  
  #set up the time series
  pltg = ts(inData$Global_active_power, frequency = 1440)
  pltrg = ts(inData$Global_reactive_power, frequency = 1440)
  pltv = ts(inData$Voltage, frequency = 1440)
  plt1 = ts(inData$Sub_metering_1, frequency = 1440)
  plt2 = ts(inData$Sub_metering_2, frequency = 1440)
  plt3 = ts(inData$Sub_metering_3, frequency = 1440)
  
  #set up the day info for the x-axis
  days= c(inData$Date[1], inData$Date[length(inData$Date)/2], inData$Date[length(inData$Date)])
  tsp = attributes(plt1)$tsp
  
  #divide into panels
  par(mfrow = c(2,2), mar = c(4,4,1,1), oma = c(0,0,0,0))
  
  #plot
  plot.ts(pltg, xaxt = "n", xlab = NULL, ylab = "Global Active Power")
  axis(1,at = c(tsp[1],tsp[2]-tsp[1],tsp[2]), labels = format(days,"%a"))
  
  plot.ts(pltv, xaxt = "n", xlab = "datetime", ylab = "Voltage")
  axis(1,at = c(tsp[1],tsp[2]-tsp[1],tsp[2]), labels = format(days,"%a"))
  
  plot.ts(plt1, xaxt = "n", xlab = NULL, ylab = "Energy sub-metering")
  lines(plt2,  col = "red")
  lines(plt3,  col = "blue")
  axis(1,at = c(tsp[1],tsp[2]-tsp[1],tsp[2]), labels = format(days,"%a"))
  legend("topright", c("Sub_metering_1", "Sub_metering_2","Sub_metering_3"),
         lty=c(1,1,1), col = c("black", "red","blue"), cex = 1,y.intersp = 1.25, text.width = 1.)
  
  plot.ts(pltrg, xaxt = "n", xlab = "datetime", ylab = "Global_reactive_power")
  axis(1,at = c(tsp[1],tsp[2]-tsp[1],tsp[2]), labels = format(days,"%a"))
  
  dev.off()
}