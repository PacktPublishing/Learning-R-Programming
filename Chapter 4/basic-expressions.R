x <- 1
y <- c(1, 2, 3)
z <- list(x, y)


2 -> x1


x3 <- x2 <- x1 <- 0


x3 <- x2 <- x1 <- rnorm(1)
c(x1, x2, x3)


x2 = c(1, 2, 3)


f <- function(input, data = NULL) {
  cat("input:\n")
  print(input)
  cat("data:\n")
  print(data)
}


x <- c(1, 2, 3)
y <- c("some", "text")
f(input = x)


x = c(1, 2, 3)
y = c("some", "text")
f(input = x)


x <- c(1, 2, 3)
y <- c("some", "text")
f(input <- x)


input


f(input = x, data = y)


f(input <- x, data <- y)


f(data = y, input = x)


f(data <- y, input <- x)


data <- y
input <- x
f(y, x)


students <- data.frame()
us_population <- data.frame()
sales.2015 <- data.frame()


some data <- data.frame()
## Error: unexpected symbol in "some data"

_data <- data.frame()
## Error: unexpected input in "_"

Population(Millions) <- data.frame()
## Error in Population(Millions) <- data.frame() : 
##  object 'Millions' not found


`some data` <- c(1, 2, 3)
`_data` <- c(4, 5, 6)
`Population(Millions)` <- c(city1 = 50, city2 = 60)


`some data`
`_data`
`Population(Millions)`


`Tom's secret function` <- function(a, d) {
  (a ^ 2 - d ^ 2) / (a ^ 2 + d ^ 2) 
}


l1 <- list(`Group(A)` = rnorm(10), `Group(B)` = rnorm(10))


`Tom's secret function`(1,2)
l1$`Group(A)`


results <- data.frame(`Group(A)` = rnorm(10), `Group(B)` = rnorm(10))
results


colnames(results)


make.names(c("Population(before)", "Population(after)"))


results <- data.frame(
  ID = c(0, 1, 2, 3, 4),
  Category = c("A", "A", "A", "B", "C"),
  `Population(before)` = c(10, 12, 13, 11, 13), 
  `Population(after)` = c(12, 13, 16, 12, 12),
  stringsAsFactors = FALSE,
  check.names = FALSE)
results
colnames(results)


results$`Population(before)`


check_positive <- function(x) {
  if (x > 0) {
    return(1)
  }
}


check_positive(1)
check_positive(0)


check_sign <- function(x) {
  if (x > 0) {
    return(1)
  } else if (x < 0) {
    return(-1)
  } else {
    return(0)
  }
}


check_sign(15)
check_sign(-3.5)
check_sign(0)


say_sign <- function(x) {
  if (x > 0) {
    cat("The number is greater than 0")
  } else if (x < 0) {
    cat("The number is less than 0")
  } else {
    cat("The number is 0")
  }
}


say_sign(0)
say_sign(3)
say_sign(-9)


if (cond1) {
  # do something
}


if (cond1) {
  # do something
} else {
  # do something else
}


if (cond1) {
  expr1
} else if (cond2) {
  expr2
} else if (cond3) {
  expr3
} else {
  expr4
}


grade <- function(score) {
  if (score >= 90) {
    return("A")
  } else if (score >= 80) {
    return("B")
  } else if (score >= 70) {
    return("C")
  } else if (score >= 60) {
    return("D")
  } else {
    return("F")
  }
}

c(grade(65), grade(59), grade(87), grade(96))


grade2 <- function(score) {
  if (score >= 60) {
    return("D")
  } else if (score >= 70) {
    return("C")
  } else if (score >= 80) {
    return("B")
  } else if (score >= 90) {
    return("A")
  } else {
    return("F")
  }
}

c(grade2(65), grade2(59), grade2(87), grade2(96))


grade2 <- function(score) {
  if (score >= 60 && score < 70) {
    return("D")
  } else if (score >= 70 && score < 80) {
    return("C")
  } else if (score >= 80 && score < 90) {
    return("B")
  } else if (score >= 90) {
    return("A")
  } else {
    return("F")
  }
}

c(grade2(65), grade2(59), grade2(87), grade2(96))


check_positive <- function(x) {
  return(if (x > 0) {
    1
  })
}


check_positive <- function(x) {
  return(if (x > 0) 1)
}


check_positive <- function(x) {
  if (x > 0) 1
}


check_sign <- function(x) {
  if (x > 0) 1 else if (x < 0) -1 else 0
}


say_grade <- function(name, score) {
  grade <- if (score >= 90) "A" 
    else if (score >= 80) "B"
    else if (score >= 70) "C"
    else if (score >= 60) "D"
    else "F"
  cat("The grade of", name, "is", grade)
}

say_grade("Betty", 86)


say_grade <- function(name, score) {
  if (score >= 90) grade <- "A"
  cat("Congratulations!\n")
  else if (score >= 80) grade <- "B"
  else if (score >= 70) grade <- "C"
  else if (score >= 60) grade <- "D"
  else grade <- "F"
  cat("What a pity!\n")
  cat("The grade of", name, "is", grade)
}

# code with errors
say_grade <- function(name, score) {
  if (score >= 90) grade <- "A"
  cat("Congratulations!\n")
  else if (score >= 80) grade <- "B"
  else if (score >= 70) grade <- "C"
  else if (score >= 60) grade <- "D"
  else grade <- "F"
  cat("What a pity!\n")
  cat("The grade of", name, "is", grade)
}


say_grade <- function(name, score) {
  if (score >= 90) {
    grade <- "A"
    cat("Congratulations!\n")
  } else if (score >= 80) {
    grade <- "B"
  }
  else if (score >= 70) {
    grade <- "C"
  }
  else if (score >= 60) {
    grade <- "D"
  } else {
    grade <- "F"
    cat("What a pity!\n")
  }
  
  cat("The grade of", name, "is", grade)
}

say_grade("James", 93)


check_positive(c(1, -1, 0))


num <- c(1, 2, 3)
if (num > 2) {
  cat("num > 2!")
}


any(c(TRUE, FALSE, FALSE))
any(c(FALSE, FALSE))


if (any(num > 2)) {
  cat("num > 2!")
}


if (all(num > 2)) {
  cat("num > 2!")
} else {
  cat("Not all values are greater than 2!")
}


check <- function(x) {
  if (all(x > 0)) {
    cat("All input values are positive!")
  } else {
    cat("Some values are not positive!")
  }
}


check(c(1, 2, 3))
check(c(1, 2, NA, -1))
check(c(1, 2, NA))


ifelse(c(TRUE, FALSE, FALSE), c(1, 2, 3), c(4, 5, 6))


check_positive2 <- function(x) {
  ifelse(x, 1, 0)
}


ifelse(TRUE, c(1,2), c(2,3))


if (TRUE) c(1,2) else c(2,3)


ifelse(c(TRUE, FALSE), c(1, 2), c("a", "b"))


switch(1, "x", "y")
switch(2, "x", "y")


switch(3, "x", "y")


switch("a", a = 1, b = 2)
switch("b", a = 1, b = 2)


switch("c", a = 1, b = 2)


switch("c", a = 1, b = 2, 3)


switch_test <- function(x) {
  switch(x, 
    a = c(1, 2, 3), 
    b = list(x = 0, y = 1), 
    c = {
      cat("You choose c!\n")
      list(name = "c", value = "something")
    })
}

switch_test("a")
switch_test("b")
switch_test("c")


for (var in vector) {
  expr
}


var <- vector[[1]]
expr
var <- vector[[2]]
expr
var <- vector[[n]]
expr


for (i in 1:3) {
  cat("The value of i is", i, "\n")
}


for (word in c("hello","new", "world")) {
  cat("The current word is", word, "\n")
}


loop_list <- list(
  a = c(1, 2, 3), 
  b = c("a", "b", "c", "d"))

for (item in loop_list) {
  cat("item:\n  length:", length(item), 
    "\n  class: ", class(item), "\n")
}


df <- data.frame(
  x = c(1, 2, 3), 
  y = c("A", "B", "C"), 
  stringsAsFactors = FALSE)

for (col in df) {
  str(col)
}


for (i in 1:nrow(df)) {
  row <- df[i,]
  cat("row", i, "\n")
  str(row)
  cat("\n")
}


s <- 0
for (i in 1:100) {
  s <- s + i
}
s


set.seed(123)
x <- numeric(1000)
for (t in 1:(length(x) - 1)) {
  x[[t + 1]] <- x[[t]] + rnorm(1, 0, 0.1)
}
plot(x, type = "s", main = "Random walk", xlab = "t")


sum100 <- sum(1:100)
random_walk <- cumsum(rnorm(1000, 0, 0.1))


for (i in 1:5) {
  if (i == 3) break
  cat("message ", i, "\n")
}


m <- integer()
for (i in 1000:1100) {
  if ((i ^ 2) %% 11 == (i ^ 3) %% 17) {
    m <- c(m, i)
  }
}
m


for (i in 1000:1100) {
  if ((i ^ 2) %% 11 == (i ^ 3) %% 17) break
}
i


for (i in 1:5) {
  if (i == 3) next
  cat("message ", i, "\n")
}


x <- c("a", "b", "c")
combx <- character()
for (c1 in x) {
  for (c2 in x) {
    combx <- c(combx, paste(c1, c2, sep = ",", collapse = ""))
  }
}
combx


combx2 <- character()
for (c1 in x) {
  for (c2 in x) {
    if (c1 == c2) next
    combx2 <- c(combx2, paste(c1, c2, sep = ",", collapse = ""))
  }
}
combx2


if (c1 != c2) {
  combx2 <- c(combx2, paste(c1, c2, sep = ",", collapse = ""))
}


combn(c("a", "b", "c"), 2)


expand.grid(n = c(1, 2, 3), x = c("a", "b"))


x <- 0
while (x <= 5) {
  cat(x, " ", sep = "")
  x <- x + 1
}


x <- 0
while (TRUE) {
  x <- x + 1
  if (x == 4) break
  else if (x == 2) next
  else cat(x, '\n')
}


res <- dbSendQuery(con, "SELECT * FROM table1 WHERE type = 1")
while (!dbHasCompleted(res)) {
  chunk <- dbFetch(res, 10000)
  process(chunk)
}


x <- 0
repeat {
  x <- x + 1
  if (x == 4) break
  else if (x == 2) next
  else cat(x, '\n')
}

