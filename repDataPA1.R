#processing the data
unzip("activity.zip")
rawData <- read.csv("activity.csv")

#Total steps
total_steps <- aggregate(steps ~ date, data = rawData, sum)
hist(total_steps$steps, col = "red", main = "Histogram of total steps taken each day", xlab = "Total Steps", breaks = 50)

dailyPattern <- aggregate(steps ~ interval, data = rawData, mean)
with(dailyPattern, plot(interval, steps, type = "l", ylab = "Mean steps"))