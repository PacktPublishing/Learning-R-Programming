my_cumsum1 <- function(x) {
  y <- numeric()
  sum_x <- 0
  for (xi in x) {
    sum_x <- sum_x + xi
    y <- c(y, sum_x)
  }
  y
}

x <- rnorm(1000)

for (i in 1:1000) {
  my_cumsum1(x)
}
