##read unzipped data file (specified multiple arguments to increase download speed)
data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE
                   , col.names = c("MeterDate", "MeterTime", "GlobalActivePwr"
                                   , "GlobalReactivePwr", "Voltage", "GlobalIntensity"
                                   , "Submetering1", "Submetering2", "Submetering3")
                   , nrows = 2100000, colClasses = c(rep("character",8), "numeric")
                   , comment.char = "", stringsAsFactors = FALSE
##subsetting using which() to include only rows from Feb 1-2, 2007
        )[which
          (read.table("household_power_consumption.txt", sep = ";", header = TRUE
                      , col.names = c("MeterDate", "MeterTime", "GlobalActivePwr"
                                      , "GlobalReactivePwr", "Voltage", "GlobalIntensity"
                                      , "Submetering1", "Submetering2", "Submetering3")
                      , nrows = 2100000, colClasses = c(rep("character",8), "numeric")
                      , comment.char = "", stringsAsFactors = FALSE)[, 1] 
            %in% c("1/2/2007","2/2/2007")), ]

##concatenate date and time columns for final date/time column, drop the separate date
##and time columns, and convert non-POSIXct character data to numeric
data <- mutate(data, "MeterDttm" = lubridate::dmy_hms(paste(MeterDate, MeterTime)))[,c(10,3:9)]
data <- data.frame(data[1], sapply(data[, 2:8], function(x) as.numeric(x[], na.rm=TRUE)))

##set png graphics device with file name, annote the plot, create the graphics file, 
##and reset graphics device
png(filename = "plot3.png")
plot(data$MeterDttm, data$Submetering1, type = "s", xlab = "", ylab = "Energy sub metering")
points(data$MeterDttm, data$Submetering2, type = "s", col = "red")
points(data$MeterDttm, data$Submetering3, type = "s", col = "blue")
legend(data, x = "topright", col = c("black", "red", "blue")
       , pch = "___________", legend = c(names(data[,6:8])))
dev.off()