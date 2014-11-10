for (i in seq_along(di$steps.x)) {
	if (is.na(di$steps.x[i])) steps.x[i] <- steps.y[i]
}