
# Project 1

library("data.table", lib.loc="~/R/win-library/3.2")
setwd("C:/Users/Riccardo/Rworkspace/coursera/Explorative data study/Project_1/ExData_Plotting1/figure")

# I looked for the right point once in the console using which(data$Time == "00:00:00")
t0 <- 66637                        
t1 <- t0 + 2*(24*60) +1            
numrows = t1 - t0 + 1

# Grab the col names first
data <- fread("household_power_consumption.txt", header=TRUE, na.strings="?",nrows=2)
new_names <- colnames(data)

# grab only the dates/times we want
data <- fread("household_power_consumption.txt", header=TRUE, na.strings="?", skip=t0-1 ,nrows=numrows)
# name the columns
colnames(data) <- new_names

# Take care of dates and times
data$Date <- as.Date(data$Date, format="%d/%m/%Y")
tmp_time <- strptime(data$Time, format="%H:%M:%S")
data$Time <- strftime(tmp_time, format="%H:%M")

## 2
# Open device
png("plot2_bis.png", width=480, height=480, units="px")

# plot
plot(data$Global_active_power, xaxt = "n", type = "l", xlab="", ylab="Global Active Power (kilowatts)")
day <- weekdays(data$Date)
pos_lab <- data$Time == "00:00"
p <- 1:length(pos_lab)
axis(1, day[pos_lab], at=p[pos_lab], labels=c("Thu","Fri","Sat"))

# close device&save
dev.off()
