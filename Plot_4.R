
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


## 4

# Open device
png("plot4_bis.png", width=480, height=480, units="px")

# set the layout
par(mfrow=c(2,2))

## Upper left
plot(data$Global_active_power, xaxt = "n", type = "l", xlab="", ylab="Global Active Power (kilowatts)", cex.lab=0.8, cex.axis=0.7)
day <- weekdays(data$Date)
pos_lab <- data$Time == "00:00"
px <- 1:length(pos_lab)
axis(1, day[pos_lab], at=px[pos_lab], labels=c("Thu","Fri","Sat"))

## Upper right

plot(data$Voltage, xaxt = "n", type = "l", ylab="Voltage", xlab="datetime", cex.axis=0.7)
axis(1, day[pos_lab], at=px[pos_lab], labels=c("Thu","Fri","Sat"))

## Lower left

plot(data$Global_active_power, xaxt = "n", yaxt="n", type = "n", xlab="", ylab="Energy sub metering", ylim=c(0,40), cex.lab=0.8, cex.axis=0.7)
points(data$Sub_metering_1, type="l", col="black")
points(data$Sub_metering_2, type="l", col="red")
points(data$Sub_metering_3, type="l", col="blue")
py <- 0:40
axis(1, day[pos_lab], at=p[pos_lab], labels=c("Thu","Fri","Sat"))
axis(2, py, at=py[c(1,11,21,31)], labels=py[c(1,11,21,31)])
legend("topright", lty=1, col=c("black", "red", "blue"), cex=0.6, legend=c("Sub_metering_1","Sub_metering_2","Sub_metering_3"))


## Lower right

plot(data$Global_reactive_power, xaxt = "n", type = "l", ylab="Global_reactive_power", xlab="datetime", cex.lab=0.8, cex.axis=0.7)
axis(1, day[pos_lab], at=px[pos_lab], labels=c("Thu","Fri","Sat"))

# close device&save
dev.off()

# reset layout
par(mfrow=c(1,1))