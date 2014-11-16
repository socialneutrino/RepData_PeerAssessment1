#processing the data
unzip("activity.zip")
rawData <- read.csv("activity.csv")

#Total steps
total_steps <- aggregate(steps ~ date, data = rawData, sum)
hist(total_steps$steps, col = "red", main = "Histogram of total steps taken each day", xlab = "Total Steps", breaks = 50)

#Average Daily Pattern
dailyPattern <- aggregate(steps ~ interval, data = rawData, mean)
with(dailyPattern, plot(interval, steps, type = "l", ylab = "Mean steps"))

dailyPattern[which.max(dailyPattern$steps),1]

##Total number of NAs
sum(is.na(rawData))

##Imputing the mean for each interval
dataImputed <- merge(rawData, dailyPattern, by="interval")

#Replace NA's with da
for (i in seq_along(dataImputed$steps.x)) {
	if (is.na(dataImputed$steps.x[i])) dataImputed$steps.x[i] <- dataImputed$steps.y[i]
}

dataImputed <- dataImputed[,1:3]
colnames(dataImputed) <- c("interval", "steps", "date")

totalStepsImputed <- aggregate(steps ~ date, data = dataImputed, sum)
hist(totalStepsImputed$steps, col = "red", main = "Histogram of total steps taken each day", xlab = "Total Steps", breaks = 50)

#Weekday Analysis
weekendLogic <- weekdays(as.Date(dataImputed$date)) == "Saturday" | weekdays(as.Date(dataImputed$date)) == "Sunday"
weekdayData <- cbind(dataImputed, weekday = !weekendLogic)
for (i in seq_along(weekdayData$weekday)) {
	if(weekdayData$weekday[i]) weekdayData$weekday[i] <- "weekday"
	else weekdayData$weekday[i] <- "weekend"
}
weekdayData$weekday <- as.factor(weekdayData$weekday)

weekdayPattern <- aggregate(steps ~ interval + weekday, data = weekdayData, mean)
dayFig <- xyplot(steps ~ interval | weekday, data = weekdayPattern, layout = c(1, 2), type = "l", ylab = "number of steps")
print(dayFig)




