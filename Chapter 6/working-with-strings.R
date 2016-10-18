"Hello"


str1 <- "Hello"
str1


for (i in 1:3) {
  "Hello"
}


test1 <- function(x) {
  "Hello"
  x
}
test1("World")


test2 <- function(x) {
  "Hello"
}
test2("World")


print(str1)


for (i in 1:3) {
  print(str1)
}


test3 <- function(x) {
  print("Hello")
  x
}
test3("World")


cat("Hello")


name <- "Ken"
language <- "R"
cat("Hello,", name, "- a user of", language)


cat("Hello, ", name, ", a user of ", language, ".")


cat("Hello, ", name, ", a user of ", language, ".", sep = "")


message("Hello, ", name, ", a user of ", language, ".")


for (i in 1:3) {
  cat(letters[[i]])
}


for (i in 1:3) {
  message(letters[[i]])
}


for (i in 1:3) {
  cat(letters[[i]], "\n", sep = "")
}


paste("Hello", "world")
paste("Hello", "world", sep = "-")


paste0("Hello", "world")


value1 <- cat("Hello", "world")
value1


paste(c("A", "B"), c("C", "D"))


paste(c("A", "B"), c("C", "D"),collapse = ", ")


result <- paste(c("A", "B"), c("C", "D"), collapse = "\n")
result


cat(result)


tolower("Hello")
toupper("Hello")


calc <- function(type, x, y) {
  type <- tolower(type)
  if (type == "add") {
    x + y
  } else if (type == "times") {
    x * y
  } else {
    stop("Not supported type of command")
  }
}
c(calc("add", 2, 3), calc("Add", 2, 3), calc("TIMES", 2, 3))


toupper(c("Hello", "world"))


nchar("Hello")


nchar(c("Hello", "R", "User"))


store_student <- function(name, age) {
  stopifnot(length(name) == 1, nchar(name) >= 2, 
    is.numeric(age), age > 0)
  # store the information in the database
}


store_student("James", 20)
store_student("P", 23)


store_student("  P", 23)


store_student2 <- function(name, age) {
  stopifnot(length(name) == 1, nchar(trimws(name)) >= 2, 
    is.numeric(age), age > 0)
  # store the information in the database
}


store_student2("  P", 23)


trimws(c("  Hello", "World   "), which = "left")


dates <- c("Jan 3", "Feb 10", "Nov 15") 


substr(dates, 1, 3)


substr(dates, 5, nchar(dates))


get_month_day <- function(x) {
  months <- vapply(substr(tolower(x), 1, 3), function(md) {
    switch(md, jan = 1, feb = 2, mar = 3, apr = 4, 
    may = 5, jun = 6, jul = 7, aug = 8, 
    sep = 9, oct = 10, nov = 11, dec = 12)
  }, numeric(1), USE.NAMES = FALSE)
  days <- as.numeric(substr(x, 5, nchar(x)))
  data.frame(month = months, day = days)
}
get_month_day(dates)


substr(dates, 1, 3) <- c("Feb", "Dec", "Mar")
dates


strsplit("a,bb,ccc", split = ",")


students <- strsplit(c("Tony, 26, Physics", "James, 25, Economics"), split = ", ")
students


students_matrix <- do.call(rbind, students)
colnames(students_matrix) <- c("name", "age", "major")
students_matrix


students_df <- data.frame(students_matrix, stringsAsFactors = FALSE)
students_df$age <- as.numeric(students_df$age)
students_df


strsplit(c("hello", "world"), split = "")


cat(paste("#", 1:nrow(students_df), ", name: ", students_df$name,
  ", age: ", students_df$age, ", major: ", students_df$major, sep = ""), sep = "\n")


cat(sprintf("#%d, name: %s, age: %d, major: %s", 
  1:nrow(students_df), students_df$name, students_df$age, students_df$major), sep = "\n")


sprintf("The length of the line is approximately %.1fmm", 12.295)


sprintf("The ratio is %d%%", 10)


sprintf("%s, %d years old, majors in %s and loves %s.",  
  "James", 25, "Physics", "Physics")


# install.packages("pystr")
library(pystr)
pystr_format("{1}, {2} years old, majors in {3} and loves {3}.",
  "James", 25, "Physics", "Physics")


pystr_format("{name}, {age} years old, majors in {major} and loves {major}.", 
  name = "James", age = 25, major = "Physics")


Sys.Date()


Sys.time()


current_date <- Sys.Date()
as.numeric(current_date)


current_time <- Sys.time()
as.numeric(current_time)


as.Date(1000, "1970-01-01")


my_date <- as.Date("2016-02-10")
my_date


my_date + 3
my_date + 80
my_date - 65


date1 <- as.Date("2014-09-28")
date2 <- as.Date("2015-10-20")
date2 - date1


as.numeric(date2 - date1)


my_time <- as.POSIXlt("2016-02-10 10:25:31")
my_time


my_time + 10
my_time + 12345
my_time - 1234567


as.Date("2015.07.25")


as.Date("2015.07.25", format = "%Y.%m.%d")


as.POSIXlt("7/25/2015 09:30:25", format = "%m/%d/%Y %H:%M:%S")


strptime("7/25/2015 09:30:25", "%m/%d/%Y %H:%M:%S")


as.Date(c("2015-05-01", "2016-02-12"))


as.Date("2015-01-01") + 0:2


strptime("7/25/2015 09:30:25", "%m/%d/%Y %H:%M:%S") + 1:3


as.Date("20150610", format = "%Y%m%d")


strptime("20150610093215", "%Y%m%d%H%M%S")


datetimes <- data.frame(
  date = c(20150601, 20150603),
  time = c(92325, 150621))


dt_text <- paste0(datetimes$date, datetimes$time)
dt_text
strptime(dt_text, "%Y%m%d%H%M%S")


dt_text2 <- paste0(datetimes$date, sprintf("%06d", datetimes$time))
dt_text2
strptime(dt_text2, "%Y%m%d%H%M%S")


my_date


date_text <- as.character(my_date)
date_text


date_text + 1


as.character(my_date, format = "%Y.%m.%d")


format(my_date, "%Y.%m.%d")


my_time
format(my_time, "date: %Y-%m-%d, time: %H:%M:%S")


read.csv("data/messages.txt", header = FALSE)


fruits <- readLines("data/fruits.txt")
fruits
matches <- grep("^\\w+:\\s\\d+$", fruits)
matches


fruits[matches]


grep("\\d", c("abc", "a12", "123", "1"))
grep("^\\d$", c("abc", "a12", "123", "1"))


library(stringr)
matches <- str_match(fruits, "^(\\w+):\\s(\\d+)$")
matches


# transform to data frame
fruits_df <- data.frame(na.omit(matches[, -1]), stringsAsFactors = FALSE)
# add a header
colnames(fruits_df) <- c("fruit","quantity")
# convert type of quantity from character to integer
fruits_df$quantity <- as.integer(fruits_df$quantity)


fruits_df


telephone <- readLines("data/telephone.txt")
telephone


telephone[grep("^\\d{3}-\\d{5}$", telephone)]
telephone[grep("^\\d{4}-\\d{4}$", telephone)]


telephone[!grepl("^\\d{3}-\\d{5}$", telephone) & !grepl("^\\d{4}-\\d{4}$", telephone)]


messages <- readLines("data/messages.txt")


pattern <- "^(\\d+-\\d+-\\d+),(\\d+:\\d+:\\d+),(\\w+),(\\w+),\\s*(.+)$"
matches <- str_match(messages, pattern)
messages_df <- data.frame(matches[, -1])
colnames(messages_df) <- c("Date", "Time", "Sender", "Receiver", "Message")


messages_df
