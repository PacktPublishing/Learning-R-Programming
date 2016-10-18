set.seed(100)

readLines("data/persons.csv")


readLines("data/persons.csv", n = 2)


persons1 <- read.csv("data/persons.csv", stringsAsFactors = FALSE)
str(persons1)


persons2 <- read.csv("data/persons.csv", 
  colClasses = c("character", "factor", "integer", "character"),
  col.names = c("name", "sex", "age", "major"))
str(persons2)


persons3 <- readr::read_csv("data/persons.csv")
str(persons3)


read.table("data/persons.txt", sep = " ")

# install.packages("readr")
readr::read_table("data/persons.txt")


some_data <- data.frame(
  id = 1:4, 
  grade = c("A", "A", "B", NA), 
  width = c(1.51, 1.52, 1.46, NA),
  check_date = as.Date(c("2016-03-05", "2016-03-06", "2016-03-10", "2016-03-11")))
some_data
write.csv(some_data, "data/some_data.csv")


cat(readLines("data/some_data.csv"), sep = "\n")


write.csv(some_data, "data/some_data.csv", 
  quote = FALSE, na = "-", row.names = FALSE)


cat(readLines("data/some_data.csv"), sep = "\n")


readr::read_csv("data/some_data.csv", na = "-")


file.remove("data/some_data.csv")



# install.packages("readxl")
readxl::read_excel("data/prices.xlsx")

# install.packages("openxlsx")
openxlsx::read.xlsx("data/prices.xlsx", detectDates = TRUE)


openxlsx::write.xlsx(mtcars, "data/mtcars.xlsx")


saveRDS(some_data, "data/some_data.rds")


some_data2 <- readRDS("data/some_data.rds")


identical(some_data, some_data2)


rows <- 200000
large_data <- data.frame(id = 1:rows, 
  x = rnorm(rows), y = rnorm(rows))
system.time(write.csv(large_data, "data/large_data.csv"))
system.time(saveRDS(large_data, "data/large_data.rds"))


fileinfo <- file.info("data/large_data.csv", "data/large_data.rds")
fileinfo[, "size", drop = FALSE]


system.time(read.csv("data/large_data.csv"))
system.time(readr::read_csv("data/large_data.csv"))


system.time(readRDS("data/large_data.rds"))


nums <- c(1.5, 2.5, NA, 3)
list1 <- list(x = c(1, 2, 3), 
  y = list(a = c("a", "b"),
    b = c(NA, 1, 2.5)))
saveRDS(nums, "data/nums.rds")
saveRDS(list1, "data/list1.rds")


readRDS("data/nums.rds")
readRDS("data/list1.rds")


save(some_data, nums, list1, file = "data/bundle1.RData")


rm(some_data, nums, list1)
load("data/bundle1.RData")


some_data
nums
list1


file.remove("data/some_data.rds", 
  "data/large_data.csv", 
  "data/large_data.rds",
  "data/nums.rds",
  "data/list1.rds",
  "data/bundle1.RData")


head(iris)
str(iris)


head(mtcars)
str(mtcars)


data("diamonds", package = "ggplot2")
dim(diamonds)


head(diamonds)


install.package(c("nycflights13", "babynames"))


plot(1:10)


x <- rnorm(100)
y <- 2 * x + rnorm(100)
plot(x, y)


plot(x, y, 
  main = "Linearly correlated random numbers",
  xlab = "x", ylab = "2x + noise",
  xlim = c(-4, 4), ylim = c(-4, 4))


plot(x, y, 
  xlim = c(-4, 4), ylim = c(-4, 4),
  xlab = "x", ylab = "2x + noise")
title("Linearly correlated random numbers")


plot(0:25, 0:25, pch = 0:25, 
  xlim = c(-1, 26), ylim = c(-1, 26),
  main = "Point styles (pch)")
text(0:25 + 1, 0:25, 0:25)


x <- rnorm(100)
y <- 2 * x + rnorm(100)
plot(x, y, pch = 16,
  main = "Scatter plot with customized point style")


plot(x, y, 
  pch = ifelse(x * y > 1, 16, 1),
  main = "Scatter plot with conditional point styles")


z <- sqrt(1 + x ^ 2) + rnorm(100)
plot(x, y, pch = 1, 
  xlim = range(x), ylim = range(y, z),
  xlab = "x", ylab = "value")
points(x, z, pch = 17)
title("Scatter plot with two series")


plot(x, y, pch = 16, col = "blue", 
  main = "Scatter plot with blue points")


plot(x, y, pch = 16, 
  col = ifelse(y >= mean(y), "red", "green"),
  main = "Scatter plot with conditional colors")


plot(x, y, col = "blue", pch = 0,
  xlim = range(x), ylim = range(y, z),
  xlab = "x", ylab = "value")
points(x, z, col = "red", pch = 1)
title("Scatter plot with two series")


t <- 1:50
y <- 3 * sin(t * pi / 60) + rnorm(t)
plot(t, y, type = "l",
  main = "Simple line plot")


lty_values <- 1:6
plot(lty_values, type = "n", axes = FALSE, ann = FALSE)
abline(h = lty_values, lty = lty_values, lwd = 2)
mtext(lty_values, side = 2, at = lty_values)
title("Line types (lty)")


plot(t, y, type = "l", lwd = 2)
abline(h = mean(y), lty = 2, col = "blue")
abline(h = range(y), lty = 3, col = "red")
abline(v = t[c(which.min(y), which.max(y))], 
  lty = 3, col = "darkgray")
title("Line plot with auxiliary lines")


p <- 40
plot(t[t <= p], y[t <= p], type = "l", 
  xlim = range(t), xlab = "t")
lines(t[t >= p], y[t >= p], lty = 2)
title("Simple line plot with two periods")


plot(y, type = "l")
points(y, pch = 16)
title("Lines with points")


plot(y, pch = 16)
lines(y)
title("Lines with points")


x <- 1:30
y <- 2 * x + 6 * rnorm(30)
z <- 3 * sqrt(x) + 8 * rnorm(30)

plot(x, y, type = "l", 
  ylim = range(y, z), col = "black")
points(y, pch = 15)
lines(z, lty = 2, col = "blue")
points(z, pch = 16, col = "blue")
title("Plot of two series")
legend("topleft", 
  legend = c("y", "z"),
  col = c("black", "blue"),
  lty = c(1, 2), pch = c(15, 16), cex = 0.8, 
  x.intersp = 0.5, y.intersp = 0.8)


plot(x, y, type = "s",
  main = "A simple step plot")


barplot(1:10, names.arg = LETTERS[1:10])


ints <- 1:10
names(ints) <- LETTERS[1:10]
barplot(ints)

# install.packages("nycflights13")
data("flights", package = "nycflights13")
carriers <- table(flights$carrier)
carriers


sorted_carriers <- sort(carriers, decreasing = TRUE)
sorted_carriers


barplot(head(sorted_carriers, 8), 
  ylim = c(0, max(sorted_carriers) * 1.1),
  xlab = "Carrier", ylab = "Flights",
  main = "Top 8 carriers with the most flights in record")


grades <- c(A = 2, B = 10, C = 12, D = 8)
pie(grades, main = "Grades", radius = 1)


random_normal <- rnorm(10000)
hist(random_normal)


hist(random_normal, probability = TRUE, col = "lightgray")
curve(dnorm, add = TRUE, lwd = 2, col = "blue")


flight_speed <- flights$distance / flights$air_time
hist(flight_speed, main = "Histogram of flight speed")


plot(density(flight_speed, from = 2, na.rm = TRUE),
  main = "Empirical distribution of flight speed")
abline(v = mean(flight_speed, na.rm = TRUE), 
  col = "blue", lty = 2)


hist(flight_speed, 
  probability = TRUE, ylim = c(0, 0.5),
  main = "Histogram and empirical distribution of flight speed",
  border = "gray", col = "lightgray")
lines(density(flight_speed, from = 2, na.rm = TRUE),
  col = "darkgray", lwd = 2)
abline(v = mean(flight_speed, na.rm = TRUE), 
  col = "blue", lty = 2)


x <- rnorm(1000)
boxplot(x)




boxplot(distance / air_time ~ carrier, data = flights,
  main = "Box plot of flight speed by carrier")


f <- function(x) 3 + 2 * x
x <- rnorm(100)
y <- f(x) + 0.5 * rnorm(100)


model1 <- lm(y ~ x)
model1


coef(model1)


summary(model1)


plot(x, y, main = "A simple linear regression")
abline(coef(model1), col = "blue")


predict(model1, list(x = c(-1, 0.5)), se.fit = TRUE)


data("flights", package = "nycflights13")
plot(air_time ~ distance, data = flights, 
  pch = ".",
  main = "flight speed plot")


rows <- nrow(flights)
rows_id <- 1:rows
sample_id <- sample(rows_id, rows * 0.75, replace = FALSE)
flights_train <- flights[sample_id,]
flights_test <- flights[setdiff(rows_id, sample_id), ]


model2 <- lm(air_time ~ distance, data = flights_train)
predict2_train <- predict(model2, flights_train)
error2_train <- flights_train$air_time - predict2_train


evaluate_error <- function(x) {
  c(abs_err = mean(abs(x), na.rm = TRUE),
    std_dev = sd(x, na.rm = TRUE))
}


evaluate_error(error2_train)


predict2_test <- predict(model2, flights_test)
error2_test <- flights_test$air_time - predict2_test
evaluate_error(error2_test)


model3 <- lm(air_time ~ carrier + distance + month + dep_time,
  data = flights_train)
predict3_train <- predict(model3, flights_train)
error3_train <- flights_train$air_time - predict3_train
evaluate_error(error3_train)


predict3_test <- predict(model3, flights_test)
error3_test <- flights_test$air_time - predict3_test
evaluate_error(error3_test)


plot(density(error2_test, na.rm = TRUE),
  main = "Empirical distributions of out-of-sample errors")
lines(density(error3_test, na.rm = TRUE), lty = 2)
legend("topright", legend = c("model2", "model3"),
  lty = c(1, 2), cex = 0.8,
  x.intersp = 0.6, y.intersp = 0.6)

# install.packages("party")
airct <- party::ctree(Ozone ~ ., 
  data = subset(airquality, !is.na(Ozone)), 
  controls = party::ctree_control(maxsurrogate = 3))
plot(airct, main = "Regression tree of air quality")


model4 <- party::ctree(air_time ~ distance + month + dep_time, 
  data = subset(flights_train, !is.na(air_time)))
predict4_train <- predict(model4, flights_train)
error4_train <- flights_train$air_time - predict4_train[, 1]
evaluate_error(error4_train)


predict4_test <- predict(model4, flights_test)
error4_test <- flights_test$air_time - predict4_test[, 1]
evaluate_error(error4_test)


plot(density(error3_test, na.rm = TRUE), 
  ylim = range(0, 0.06),
  main = "Empirical distributions of out-of-sample errors")
lines(density(error4_test, na.rm = TRUE), lty = 2)
legend("topright", legend = c("model3", "model4"),
  lty = c(1, 2), cex = 0.8,
  x.intersp = 0.6, y.intersp = 0.6)
