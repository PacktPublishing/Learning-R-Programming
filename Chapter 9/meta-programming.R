add <- function(x, y) {
  x + y
}


addn <- function(y) {
  function(x) {
    x + y
  }
}


add1 <- addn(1)
add2 <- addn(2)


add1(10)
add2(10)


add1


environment(add1)$y


environment(add2)$y


color_line <- function(col) {
  function(...) {
    plot(..., type = "l", lty = 1, col = col)
  }
}


red_line <- color_line("red")
red_line(rnorm(30), main = "Red line plot")


plot(rnorm(30), type = "l", lty = 1, col = "red",
  main = "Red line plot")


nloglik <- function(x) {
  n <- length(x)
  function(mean, sd) {
    log(2 * pi) * n / 2 + log(sd ^ 2) * n / 2 + sum((x - mean) ^ 2) / (2 * sd ^ 2)
  }
}


data <- rnorm(10000, 1, 2)


fit <- stats4::mle(nloglik(data), 
  start = list(mean = 0, sd = 1), method = "L-BFGS-B", 
  lower = c(-5, 0.01), upper = c(5, 10))


fit@coef


(fit@coef - c(1, 2)) / c(1, 2)


hist(data, freq = FALSE, ylim = c(0, 0.25))
curve(dnorm(x, 1, 2), add = TRUE, col = rgb(1, 0, 0, 0.5), lwd = 6)
curve(dnorm(x, fit@coef[["mean"]], fit@coef[["sd"]]), 
    add = TRUE, col = "blue", lwd = 2)


f1 <- function() {
  cat("[f1] executing in ")
  print(environment())
  cat("[f1] enclosed by ")
  print(parent.env(environment()))
  cat("[f1] calling from ")
  print(parent.frame())
}
f2 <- function() {
  cat("[f2] executing in ")
  print(environment())
  cat("[f2] enclosed by ")
  print(parent.env(environment()))
  cat("[f2] calling from ")
  print(parent.frame())
  p <- f1
  p()
}
f1()
f2()


f1 <- function(x, y) {
  if (x > y) {
    x + y
  } else {
    x - y
  }
}


f2 <- function(x, y) {
  op <- if (x > y) `+` else `-`
  op(x, y)
}


add <- function(x, y, z) {
  x + y + z
}
product <- function(x, y, z) {
  x * y * z
}


combine <- function(f, x, y, z) {
  f(x, y, z)
}


combine(add, 3, 4, 5)
combine(product, 3, 4, 5)


result <- list()
for (i in seq_along(x)) {
    result[[i]] <- f(x[[i]])
}
result


lapply(x, f)


lapply <- function(x, f, ...) {
  result <- list()
  for (i in seq_along(x)) {
      result[[i]] <- f(x[i], ...)
  }
}


lapply(1:3, `+`, 3)


list(1 + 3, 2 + 3, 3 + 3)


lapply(1:3, addn(3))


sapply(1:3, addn(3))


vapply(1:3, addn(3), numeric(1))


result <- list()
for (i in seq_along(x)) {
  # heavy computing task
  result[[i]] <- f(x[[i]])
}
result


result <- lapply(x, f)


result <- parallel::mclapply(x, f)


iris[iris$Sepal.Length > quantile(iris$Sepal.Length, 0.8) &
    iris$Sepal.Width > quantile(iris$Sepal.Width, 0.8) &
    iris$Petal.Length > quantile(iris$Petal.Length, 0.8) &
    iris$Petal.Width > quantile(iris$Petal.Width, 0.8), ]


subset(iris, 
  Sepal.Length > quantile(Sepal.Length, 0.8) &
    Sepal.Width > quantile(Sepal.Width, 0.8) &
    Petal.Length > quantile(Petal.Length, 0.8) &
    Petal.Width > quantile(Petal.Width, 0.8))


iris[Sepal.Length > quantile(Sepal.Length, 0.8) &
    Sepal.Width > quantile(Sepal.Width, 0.8) &
    Petal.Length > quantile(Petal.Length, 0.8) &
    Petal.Width > quantile(Petal.Width, 0.8), ]


subset(iris, 
  Sepal.Length > quantile(Sepal.Length, 0.8) &
    Sepal.Width > quantile(Sepal.Width, 0.8) &
    Petal.Length > quantile(Petal.Length, 0.8) &
    Petal.Width > quantile(Petal.Width, 0.8),
  select = c(Sepal.Length, Petal.Length, Species))


rnorm(5)


call1 <- quote(rnorm(5))
call1


typeof(call1)
class(call1)


name1 <- quote(rnorm)
name1
typeof(name1)
class(name1)


quote(pvar)
quote(xfun(a = 1:n))


as.list(call1)


call1[[1]]
typeof(call1[[1]])
class(call1[[1]])


call1[[2]]
typeof(call1[[2]])
class(call1[[2]])


num1 <- 100
num2 <- quote(100)


num1
num2


identical(num1, num2)


call2 <- quote(c("a", "b"))
call2


as.list(call2)


str(as.list(call2))


call3 <- quote(1 + 1)
call3


is.call(call3)
str(as.list(call3))


call4 <- quote(sqrt(1 + x ^ 2))
call4


pryr::call_tree(call4)


call1
call1[[1]] <- quote(runif)
call1


call1[[3]] <- -1
names(call1)[[3]] <- "min"
call1


fun1 <- function(x) {
  quote(x)
}


fun1(rnorm(5))


fun2 <- function(x) {
  substitute(x)
}
fun2(rnorm(5))


substitute(x + y + x ^ 2, list(x = 1))


substitute(f(x + f(y)), list(f = quote(sin)))


call1 <- quote(rnorm(5, mean = 3))
call1


call2 <- call("rnorm", 5,  mean = 3)
call2


call3 <- as.call(list(quote(rnorm), 5, mean = 3))
call3


identical(call1, call2)
identical(call2, call3)


sin(1)


call1 <- quote(sin(1))
call1
eval(call1)


call2 <- quote(sin(x))
call2


eval(call2)


sin(x)


eval(call2, list(x = 1))


e1 <- new.env()
e1$x <- 1
eval(call2, e1)


call3 <- quote(x ^ 2 + y ^ 2)
call3


eval(call3)


eval(call3, list(x = 2))


eval(call3, list(x = 2, y = 3))


e1 <- new.env()
e1$x <- 2
eval(call3, e1)


e2 <- new.env(parent = e1)
e2$y <- 3
eval(call3, e2)


pryr::call_tree(call3)


e3 <- new.env()
e3$y <- 3
eval(call3, list(x = 2), e3)


eval(quote(z <- x + y + 1), list(x = 1), e3)
e3$z


eval(quote(z <- y + 1), e3)
e3$z


eval(quote(1 + 1), list(`+` = `-`))


x <- 1:10
x[3:(length(x) - 5)]


qs <- function(x, range) {
  range <- substitute(range)
  selector <- eval(range, list(. = length(x)))
  x[selector]
}


qs(x, 3:(. - 5))


qs(x, . - 1)


trim_margin <- function(x, n) {
  qs(x, (n + 1):(. - n - 1))
}


trim_margin(x, 3)


eval


qs <- function(x, range) {
  range <- substitute(range)
  selector <- eval(range, list(. = length(x)), parent.frame())
  x[selector]
}


trim_margin(x, 3)


formula1 <- z ~ x ^ 2 + y ^ 2


typeof(formula1)
class(formula1)


str(as.list(formula1))


is.call(formula1)
length(formula1)


formula1[[2]]
formula1[[3]]


environment(formula1)


formula2 <- ~ x + y
str(as.list(formula2))


length(formula2)
formula2[[2]]


qs2 <- function(x, range) {
  selector <- if (inherits(range, "formula")) {
    eval(range[[2]], list(. = length(x)), environment(range))
  } else range
  x[selector]
}


qs2(1:10, ~ 3:(. - 2))


qs2(1:10, 3)


trim_margin2 <- function(x, n) {
  qs2(x, ~ (n + 1):(. - n - 1))
}


trim_margin2(x, 3)


subset2 <- function(x, subset = TRUE, select = TRUE) {
  enclos <- parent.frame()
  subset <- substitute(subset)
  select <- substitute(select)
  row_selector <- eval(subset, x, enclos)
  col_envir <- as.list(seq_along(x))
  names(col_envir) <- colnames(x)
  col_selector <- eval(select, col_envir, enclos)
  x[row_selector, col_selector]
}


subset2(mtcars, mpg >= quantile(mpg, 0.9), c(mpg, cyl, qsec))


subset2(mtcars, mpg >= quantile(mpg, 0.9), mpg:drat)


