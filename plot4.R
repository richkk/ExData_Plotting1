# plot4.R creates 4 plots for the days of of Feb 1-2, 2007 from the "Individual household electric power consumption" 
# Data Set. The data set is in subdirectory "data" of the working directory.
#
#  1. A line plot of the Global Active Power
#  2. A line plot of the Voltage
#  3. A line plot of the 3 Energy sub metering
#  4. A line plot of the Global Reactive Power 
#####################################################
#
plot4 <- function() {
    # Read just a few lines in order to capture the column classes and then read the entire data set using the 
    # column classes in order to speed up the reading.
    preRead <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, nrows=3)
    classes <- sapply(preRead, class)
    df <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", colClasses=classes, na.strings="?")
    
    #Filter dataset to just the rows for dates 2007-02-01 and 2007-02-02 
    df <- df[(df$Date == "1/2/2007" | df$Date=="2/2/2007"), ]
    
    #Using the Lubridate package, create a new column of the concatenation of Date and Time
    library(lubridate) 
    df$datetime<- dmy_hms(paste(df[,1], df[,2]))
    
    # Plot the 4 plots to a PNG graphic device
    png(filename="plot4.png", width = 480, height = 480, units = "px")
    
    # Lay it out so it is 2x2, and set the margins to allow better use of the canvas.
    par(mfrow=c(2,2))
    #par(mar=c(2,2,2,2))
    
    ###########################    
    # Plot 1. A line plot of Global Active Power
    ###########################
    with(df, plot(df$datetime, df$Global_active_power, type="l", xlab="", ylab="Global Active Power"))
    
    ###########################    
    # Plot 2. A line plot of the Voltage
    ###########################
    with(df, plot(df$datetime, df$Voltage, type="l", xlab="datetime", ylab="Voltage"))
    
    ###########################    
    # Plot 3. A line plot of the 3 Energy sub metering
    ###########################
    # Plot 1st line. This plot sets the y-axis's label, limits and the tick marks. 
    with(df, plot( df$datetime, df$Sub_metering_1, type="l", xlab="", ylab="Energy sub metering", ylim=c(0,40), yaxp=c(0,30,3)))
    
    # Plot 2nd sub metering line in red. Do not annotate the axes.
    par(new=TRUE) # do NOT clean the frame for the next plot line
    with(df, plot( df$datetime, df$Sub_metering_2, type="l", axes=F, ann=F, col="red", ylim=c(0,40)))
    
    # Plot 3rd sub metering line in blue. Do not annotate the axes.
    par(new=TRUE) # do NOT clean the frame for the next plot line
    with(df, plot( df$datetime, df$Sub_metering_3, type="l", axes=F, ann=F, col="blue", ylim=c(0,40)))
    
    #Add a legend to upper right for the 3 lines.
    legend("topright", legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"), lty=1, col=c("black", "red", "blue"), bty="n")
    
    ###########################    
    # Plot 4. A line plot of the Global Reactive Power
    ###########################
    with(df, plot( df$datetime, df$Global_reactive_power, xlab="datetime", ylab="Global_reactive_power", type="l"))

    dev.off()
}