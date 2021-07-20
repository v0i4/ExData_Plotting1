library(sqldf)
library(dplyr)

df <- read.csv('household_power_consumption.txt', sep = ";")
col_names <- gsub("\\.", ";", names(df))
colnames(df) <- col_names

#load data
data_new <- sqldf("SELECT * 
                   FROM df 
                   WHERE df.Date= '1/2/2007' OR 
                         df.Date= '2/2/2007'")

#converts
data_new$Date <- as.Date(data_new$Date, format("%d/%m/%Y"))
data_new$Time <- strptime(data_new$Time)
data_new$Global_active_power <- as.numeric(data_new$Global_active_power)

#setup layout 1,1
par(mfcol=c(1,1))

#prepare data to plot, adding date_time column to fill x axis values
data_new <- mutate(data_new, date_time = as_datetime(paste(data_new$Date, data_new$Time, sep = " ")) )

with(data_new,
     plot(date_time,
          Global_active_power,
          type="S",
          xlab="",
          ylab="Global Active Power (kilowatts)"
          )

)

#generates PNG file:
dev.copy(png, file="plot2.png", width=480, height=480, units="px")
dev.off()



