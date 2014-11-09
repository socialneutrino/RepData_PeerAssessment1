#processing the data
unzip("activity.zip")
rawData <- read.csv("activity.csv")

#Total steps
total_steps <- aggregate(steps ~ date, data = rawData, sum)
hist(total_steps$steps, col = "red", main = "Histogram of total steps taken each day", xlab = "Total Steps", breaks = 50)

mean(total_steps$steps)
median(total_steps$steps)
