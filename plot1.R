library(sqldf)
df <- read.csv('household_power_consumption.txt', sep = ";")
col_names <- gsub("\\.", ";", names(df))
colnames(df) <- col_names

#load data
data_new <- sqldf("SELECT * 
                   FROM df 
                   WHERE df.Date= '1/2/2007' OR 
                         df.Date= '2/2/2007'")
#setup layout 1,1
par(mfcol=c(1,1))

#buid hist
hist(as.numeric(data_new$Global_active_power), 
     main = "Global Active Power", 
     xlab = "Global Active Power (kilowatts)",
     freq = TRUE,
     col = "red", 
     axis(side = 1,  at = seq(0,6,2)),
     breaks = 20,
     ylim = c(0,1200)

)

#generates png file
dev.copy(png, file="plot1.png", width=480, height=480, units="px")
dev.off()