take_it <- function(x) {
  if (is.atomic(x)) {
    x[[1]]
  } else if (is.list(x)) {
    x$data[[x$index]]
  } else {
    stop("Not supported input type")
  }
}


take_it(c(1, 2, 3))
take_it(list(data = c("a", "b", "c"), index = 3))


take_it(mean)


take_it(list(input = c("a", "b", "c")))


NULL[[1]]
NULL[[NULL]]


take_it(list(data = c("a", "b", "c")))


c("a", "b", "c")[[NULL]]


take_it(list(index = 2))


take_it2 <- function(x) {
  if (is.atomic(x)) {
    x[[1]]
  } else if (is.list(x)) {
    if (!is.null(x$data) && is.atomic(x$data)) {
      if (is.numeric(x$index) && length(x) == 1) {
        x$data[[x$index]]    
      } else {
        stop("Invalid index")  
      }
    } else {
      stop("Invalid data")
    }
  } else {
    stop("Not supported input type")
  }
}


take_it2(list(data = c("a", "b", "c")))
take_it2(list(index = 2))


x <- c(1, 2, 3)
class(x)
typeof(x)
str(x)


x <- 1:3
class(x)
typeof(x)
str(x)


x <- c("a", "b", "c")
class(x)
typeof(x)
str(x)


x <- list(a = c(1, 2), b = c(TRUE, FALSE))
class(x)
typeof(x)
str(x)


x <- data.frame(a = c(1, 2), b = c(TRUE, FALSE))
class(x)
typeof(x)
str(x)


vec <- c(1, 2, 3, 2, 3, 4, 3, 4, 5, 4, 5, 6)
class(vec)
typeof(vec)


sample_matrix <- matrix(vec, ncol = 4)
sample_matrix
class(sample_matrix)
typeof(sample_matrix)
dim(sample_matrix)
nrow(sample_matrix)
ncol(sample_matrix)


sample_array <- array(vec, dim = c(2, 3, 2))
sample_array
class(sample_array)
typeof(sample_array)
dim(sample_array)
nrow(sample_array)
ncol(sample_array)


sample_data_frame <- data.frame(a = c(1, 2, 3), b = c(2, 3, 4))
class(sample_data_frame)
typeof(sample_data_frame)
dim(sample_data_frame)
nrow(sample_data_frame)
ncol(sample_data_frame)


sample_data <- vec
dim(sample_data) <- c(3, 4)
sample_data
class(sample_data)
typeof(sample_data)


dim(sample_data) <- c(4, 3)
sample_data


dim(sample_data) <- c(3, 2, 2)
sample_data
class(sample_data)


dim(sample_data) <- c(2, 3, 4)


sample_data_frame


for (i in 1:nrow(sample_data_frame)) {
  # sample text:
  # row #1, a: 1, b: 2
  cat("row #", i, ", ",
    "a: ", sample_data_frame[i, "a"], 
    ", b: ", sample_data_frame[i, "b"],
    "\n", sep = "")
}


test_direction <- function(x, y, z) {
  if (x < y & y < z) 1
  else if (x > y & y > z) -1
  else 0
}


test_direction(1, 2, 3)


test_direction(c(1, 2), c(2, 3), c(3, 4))


test_direction2 <- function(x, y, z) {
  if (x < y && y < z) 1
  else if (x > y && y > z) -1
  else 0
}


test_direction2(1, 2, 3)


test_direction2(c(1, 2), c(2, 3), c(3, 4))


x <- c(-2, -3, 2, 3, 1, 0, 0, 1, 2)
any(x > 1)
all(x <= 1)


test_all_direction <- function(x, y, z) {
  if (all(x < y & y < z)) 1
  else if (all(x > y & y > z)) -1
  else 0
}


test_all_direction(1, 2, 3)


test_all_direction(c(1, 2), c(2, 3), c(3, 4))


test_all_direction(c(1, 2), c(2, 4), c(3, 4))


test_any_direction <- function(x, y, z) {
  if (any(x < y & y < z)) 1
  else if (any(x > y & y > z)) -1
  else 0
}
test_all_direction2 <- function(x, y, z) {
  if (all(x < y) && all(y < z)) 1 
  else if (all(x > y) && all(y > z)) -1
  else 0
}
test_any_direction2 <- function(x, y, z) {
  if (any(x < y) && any(y < z)) 1 
  else if (any(x > y) && any(y > z)) -1
  else 0
}


x
abs(x) >= 1.5
which(abs(x) >= 1.5)


x[x >= 1.5]


x[x >= 100]


x <- c(-2, -3, NA, 2, 3, 1, NA, 0, 1, NA, 2)


x + 2


x > 2


x
any(x > 2)
any(x < -2)
any(x < -3)


any(c(TRUE, FALSE, NA))
any(c(FALSE, FALSE, NA))
any(c(FALSE, FALSE))


any(x < -3, na.rm = TRUE)


x
all(x > -3)
all(x >= -3)
all(x < 4)


all(c(TRUE, FALSE, NA))
all(c(TRUE, TRUE, NA))
all(c(TRUE, TRUE))


all(x >= -3, na.rm = TRUE)


x
x[x >= 0]


which(x >= 0)


x[which(x >= 0)]


if (2) 3
if (0) 0 else 1


if ("a") 1 else 2


sqrt(-1)


1 / 0


log(0)


is.finite(1 / 0)
is.infinite(log(0))


1 / 0 < 0
1 / 0 > 0
log(0) < 0
log(0) > 0


is.pos.infinite <- function(x) {
  is.infinite(x) & x > 0
}
is.neg.infinite <- function(x) {
  is.infinite(x) & x < 0
}
is.pos.infinite(1/0)
is.neg.infinite(log(0))


log(-1)


pi


sin(pi)


max(c(1, 2, 3))


max(c(1, 2, 3),
     c(2, 1, 2),
     c(1, 3, 4))
min(c(1, 2, 3),
     c(2, 1, 2),
     c(1, 3, 4))


pmax(c(1, 2, 3),
     c(2, 1, 2),
     c(1, 3, 4))


x <- list(c(1, 2, 3),
          c(2, 1, 2),
          c(1, 3, 4))
c(max(x[[1]][[1]], x[[2]][[1]], x[[3]][[1]]),
  max(x[[1]][[2]], x[[2]][[2]], x[[3]][[2]]),
  max(x[[1]][[3]], x[[2]][[3]], x[[3]][[3]]))


pmin(c(1, 2, 3),
     c(2, 1, 2),
     c(1, 3, 4))


spread <- function(x) {
  if (x < -5) -5
  else if (x > 5) 5
  else x
}


spread(1)
spread(seq(-8, 8))


spread2 <- function(x) {
  pmin(5, pmax(-5, x))
}
spread2(seq(-8, 8))


spread3 <- function(x) {
  ifelse(x < -5, -5, ifelse(x > 5, 5, x))
}
spread3(seq(-8, 8))


curve(spread2, -8, 8, xlab = "x", ylab = "spread", main = "spread")


polyroot(c(-2, 1, 1))


Re(polyroot(c(-2, 1, 1)))


polyroot(c(1, 0, 1))


r <- polyroot(c(-1, -2, -1, 1))
r


r ^ 3 - r ^ 2 - 2 * r - 1


round(r ^ 3 - r ^ 2 - 2 * r - 1, 8)


curve(x ^ 2 - exp(x), -2, 1, 
  main = quote(x ^ 2 - e ^ x),
  xlab = "x", ylab = "y")
abline(h = 0, col = "red", lty = 2)


uniroot(function(x) x ^ 2 - exp(x), c(-2, 1))


curve(exp(x) - 3 * exp(-x ^ 2 + x) + 1, -2, 2, 
  main = quote(e ^ x - 3 * e ^ (-x ^ 2 + x) + 1),
  xlab = "x", ylab = "y")
abline(h = 0, col = "red", lty = 2)


f <- function(x) exp(x) - 3 * exp(-x ^ 2 + x) + 1
uniroot(f, c(-2, 2))


uniroot(f, c(-2, 0))$root
uniroot(f, c(0, 2))$root


curve(x ^ 2 - 2 * x + 4 * cos(x ^ 2) - 3, -5, 5, 
  main = quote(x ^ 2 - 2 * x + 4 * cos(x ^ 2) - 3),
  xlab = "x", ylab = "y")
abline(h = 0, col = "red", lty = 2)


uniroot(function(x) x ^ 2 - 2 * x + 4 * cos(x ^ 2) - 3, c(0, 1))$root


D(quote(x ^ 2), "x")


D(quote(sin(x) * cos(x * y)), "x")


z <- D(quote(sin(x) * cos(x * y)), "x")
z
eval(z, list(x = 1, y = 2))


result <- integrate(function(x) sin(x), 0, pi / 2)
result


str(result)


sample(1:6, size = 5)


sample(1:6, size = 5, replace = TRUE)


sample(letters, size = 3)


sample(list(a = 1, b = c(2, 3), c = c(3, 4, 5)), size = 2)


grades <- sample(c("A", "B", "C"), size = 20, replace = TRUE, 
  prob = c(0.25, 0.5, 0.25))
grades


table(grades)


runif(5)


runif(5, min = -1, max = 1)


withr::with_par(list(mfrow = c(1, 2)), {
  x <- runif(1000)
  plot(x, main = "runif(1000)")
  hist(x, main = "Histogram of runif(1000)")
})


rnorm(5)


rnorm(5, mean = 2, sd = 0.5)


withr::with_par(list(mfrow = c(1, 2)), {
  x <- rnorm(1000)
  plot(x, main = "rnorm(1000)")
  hist(x, main = "Histogram of rnorm(1000)")
})


x <- rnorm(50)


mean(x)


sum(x) / length(x)


mean(x, trim = 0.05)


median(x)


sd(x)


var(x)


c(min = min(x), max = max(x))


range(x)


quantile(x)


quantile(x, probs = seq(0, 1, 0.1))


summary(x)


df <- data.frame(score = round(rnorm(100, 80, 10)),
  grade = sample(letters[1:3], 100, replace = TRUE))
summary(df)


y <- 2 * x + 0.5 * rnorm(length(x))


cov(x, y)


cor(x, y)


z <- runif(length(x))
m1 <- cbind(x, y, z)
cov(m1)


cor(m1)


len <- c(3, 4, 5)
# first, create a list in the environment.
x <- list()
# then use `for` to generate the random vector for each length
for (i in 1:3) {
  x[[i]] <- rnorm(len[i])
}
x


lapply(len, rnorm)


students <- list(
  a1 = list(name = "James", age = 25, 
    gender = "M", interest = c("reading", "writing")),
  a2 = list(name = "Jenny", age = 23, 
    gender = "F", interest = c("cooking")),
  a3 = list(name = "David", age = 24, 
    gender = "M", interest = c("running", "basketball")))


sprintf("Hello, %s! Your number is %d.", "Tom", 3)


lapply(students, function(s) {
  type <- switch(s$gender, "M" = "man", "F" = "woman")
  interest <- paste(s$interest, collapse = ", ")
  sprintf("%s, %d year-old %s, loves %s.", s$name, s$age, type, interest)
})


sapply(1:10, function(i) i ^ 2)


sapply(1:10, function(i) c(i, i ^ 2))


x <- list(c(1, 2), c(2, 3), c(1, 3))


sapply(x, function(x) x ^ 2)


x1 <- list(c(1, 2), c(2, 3), c(1, 3, 3))


sapply(x1, function(x) x ^ 2)


vapply(x1, function(x) x ^ 2, numeric(2))


vapply(x, function(x) x ^ 2, numeric(2))


mapply(function(a, b, c) a * b + b * c + a * c, 
  a = c(1, 2, 3), b = c(5, 6, 7), c = c(-1, -2, -3))


df <- data.frame(x = c(1, 2, 3), y = c(3, 4, 5))
df
mapply(function(xi, yi) c(xi, yi, xi + yi), df$x, df$y)


Map(function(xi, yi) c(xi, yi, xi + yi), df$x, df$y)


mat <- matrix(c(1, 2, 3, 4), nrow = 2)
mat
apply(mat, 1, sum)


apply(mat, 2, sum)


mat2 <- matrix(1:16, nrow = 4)
mat2


apply(mat2, 2, function(col) c(min = min(col), max = max(col)))


apply(mat2, 1, function(col) c(min = min(col), max = max(col)))


