
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

## 3
# Open device
png("plot3_bis.png", width=480, height=480, units="px")

# plot
plot(data$Global_active_power, xaxt = "n", yaxt="n", type = "n", xlab="", ylab="Energy sub metering", ylim=c(0,40))
points(data$Sub_metering_1, type="l", col="black")
points(data$Sub_metering_2, type="l", col="red")
points(data$Sub_metering_3, type="l", col="blue")
day <- weekdays(data$Date)
pos_lab <- data$Time == "00:00"
p <- 1:length(pos_lab)
py <- 0:40
axis(1, day[pos_lab], at=p[pos_lab], labels=c("Thu","Fri","Sat"))
axis(2, py, at=py[c(1,11,21,31)], labels=py[c(1,11,21,31)])
legend("topright", lty=1, cex = 1, col=c("black", "red", "blue"), legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))

# close device&save
dev.off()
