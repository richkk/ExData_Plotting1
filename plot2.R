# plot2.R creates a line plot of Global Active Power for the days of of Feb 1-2, 2007
# from the "Individual household electric power consumption" Data Set. 
#
# The data set is in subdirectory "data" of the working directory.
################################
#
plot2 <- function() {
    # Read just a few lines in order to capture the column classes and then read the entire data set using the 
    # column classes in order to speed up the reading.
    preRead <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", stringsAsFactors=FALSE, nrows=3)
    classes <- sapply(preRead, class)
    df <- read.table("./data/household_power_consumption.txt", header=TRUE, sep=";", colClasses=classes, na.strings="?")
    
    #Filter dataset to just the rows for dates 2007-02-01 and 2007-02-02 
    df <- df[(df$Date == "1/2/2007" | df$Date=="2/2/2007"), ]
    
    #Using the Lubridate package, create a new column of the concatenation of Date and Time
    library(lubridate) 
    df$DateTime<- dmy_hms(paste(df[,1], df[,2]))
    
    # Plot the Global Active power to a PNG graphic device
    png(filename="plot2.png", width = 480, height = 480, units = "px")
    with(df, plot(df$DateTime, df$Global_active_power, type="l", xlab="", ylab="Global Active Power (kilowatts)"))
    dev.off()
}