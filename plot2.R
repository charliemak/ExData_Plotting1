data <- read.table("household_power_consumption.txt", sep = ";", header = TRUE
                   , col.names = c("MeterDate", "MeterTime", "GlobalActivePwr"
                                   , "GlobalReactivePwr", "Voltage", "GlobalIntensity"
                                   , "Submetering1", "Submetering2", "Submetering3")
                   , nrows = 2100000, colClasses = c(rep("character",8), "numeric")
                   , comment.char = "", stringsAsFactors = FALSE
        )[which
          (read.table("household_power_consumption.txt", sep = ";", header = TRUE
                      , col.names = c("MeterDate", "MeterTime", "GlobalActivePwr"
                                      , "GlobalReactivePwr", "Voltage", "GlobalIntensity"
                                      , "Submetering1", "Submetering2", "Submetering3")
                      , nrows = 2100000, colClasses = c(rep("character",8), "numeric")
                      , comment.char = "", stringsAsFactors = FALSE)[, 1] 
            %in% c("1/2/2007","2/2/2007")), ]

data <- mutate(data, "MeterDttm" = lubridate::dmy_hms(paste(MeterDate, MeterTime)))[,c(10,3:9)]
data <- data.frame(data[1], sapply(data[, 2:8], function(x) as.numeric(x[], na.rm=TRUE)))

png(filename = "plot2.png")
plot(data$MeterDttm, data$GlobalActivePwr, xlab = "", ylab = "Global Active Power (kilowatts)", type = "l")
dev.off()