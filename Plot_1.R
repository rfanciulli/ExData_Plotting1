
# Project 1

library("data.table", lib.loc="~/R/win-library/3.2")
setwd("C:/Users/Riccardo/Rworkspace/coursera/Explorative data study/Project_1/ExData_Plotting1/figure")

# Look for the area of interest
t0 <- 66637                     # 2007/2/1 00:00:00
t1 <- t0 + 2*(24*60) +1            # 2007/2/3 00:00:00
numrows = t1 - t0 + 1

data <- fread("household_power_consumption.txt", header=TRUE, na.strings="?",nrows=2)
new_names <- colnames(data)

data <- fread("household_power_consumption.txt", header=TRUE, na.strings="?", skip=t0-1 ,nrows=numrows)
colnames(data) <- new_names

data$Date <- as.Date(data$Date, format="%d/%m/%Y")
tmp_time <- strptime(data$Time, format="%H:%M:%S")
data$Time <- strftime(tmp_time, format="%H:%M")

#windows(width=480, height=480)
png("plot1_bis.png", width=480, height=480, units="px")
hist(data$Global_active_power ,breaks=12, main="Global Active Power", col="red", xlab="Global Active Power (kilowatts)", ylab="Frequency", yaxp=c(0,1200,5))
dev.off()