test0 <- function(x, y) {
  if (x > 0) x else y
}


test0(1)


test0(-1)


test0(1, stop("Stop now"))


test0(-1, stop("Stop now"))


system.time(rnorm(10000000))


system.time(1)


system.time(test0(1, rnorm(10000000)))


test1 <- function(x, y = stop("Stop now")) {
  if (x > 0) x else y
}


test1(1)


test1(-1)


test2 <- function(x, n = floor(length(x) / 2)) {
  x[1:n]
}


test2(1:10)


test2(1:10, 3)


test3 <- function(x, n = floor(length(m) / 2)) {
  x[1:n]
}


test3(1:10)


m <- c(1, 2, 3)
test3(1:10)


test4 <- function(x, y = p) {
  p <- x + 1
  c(x, y)
}


test4(1)


check_input <- function(x) {
  switch(x, 
    y = message("yes"), 
    n = message("no"),
    stop("Invalid input"))
}


check_input("y")


check_input("n")


check_input("what")


x1 <- c(1, 2, 3)


x2 <- x1


x1[1] <- 0
x1
x2


x1 <- c(1, 2, 3)
x2 <- x1


tracemem(x1)
tracemem(x2)


x1[1] <- 0


untracemem(x1)
untracemem(x2)


modify_first <- function(x) {
  x[1] <- 0
  x
}


v1 <- c(1, 2, 3)
modify_first(v1)
v1


v2 <- list(x = 1, y = 2)
modify_first(v2)
v2


v1[1] <- 0
v1


v2[1] <- 0
v2


v3 <- 1:5
v3 <- modify_first(v3)
v3


change_names <- function(x) {
  if (is.data.frame(x)) {
    rownames(x) <- NULL
    if (ncol(x) <= length(LETTERS)) {
      colnames(x) <- LETTERS[1:ncol(x)]
    } else {
      stop("Too many columns to rename")
    }
  } else {
    stop("x must be a data frame")
  }
  x
}


small_df <- data.frame(
  id = 1:3, 
  width = runif(3, 5, 10), 
  height = runif(3, 5, 10))
small_df


change_names(small_df)


small_df


x <- 0
modify_x <- function(value) {
  x <<- value
}


modify_x(3)
x


count <- 0
lapply(1:3, function(x) {
  result <- 1:x
  count <<- count + length(result)
  result
})
count


nested_list <- list(
  a = c(1, 2, 3), 
  b = list(
    x = c("a", "b", "c"), 
    y = list(
      z = c(TRUE, FALSE), 
      w = c(2, 3, 4))
  )
)
str(nested_list)


flat_list <- list()
i <- 1


res <- rapply(nested_list, function(x) {
  flat_list[[i]] <<- x
  i <<- i + 1
})


res


names(flat_list) <- names(res)
str(flat_list)


start_num <- 1
end_num <- 10
fun1 <- function(x) {
  c(start_num, x, end_num)
}


fun1(c(4, 5, 6))


rm(start_num, end_num)
fun1(c(4, 5, 6))


rm(fun1, start_num, end_num)
fun1 <- function(x) {
  c(start_num, x, end_num)
}


fun1(c(4, 5, 6))


start_num <- 1
end_num <- 10
fun1(c(4, 5, 6))


p <- 0
fun2 <- function(x) {
  p <- 1
  x + p
}


fun2(1)


f1 <- function(x) {
  x + p
}
g1 <- function(x) {
  p <- 1
  f1(x)
}


g1(0)


p <- 1
g1(0)


m <- 1
f2 <- function(x) {
  m <<- 2
  x
}
g2 <- function(x) {
  m <- 1
  f2(x)
  cat(sprintf("[g2] m: %d\n", m))
}


g2(1)


m


f <- function(x) {
  p <- 1
  q <- 2
  cat(sprintf("1. [f1] p: %d, q: %d\n", p, q))
  f2 <- function(x) {
    p <- 3
    cat(sprintf("2. [f2] p: %d, q: %d\n", p, q))
    c(x = x, p = p, q = q)
  }
  cat(sprintf("3. [f1] p: %d, q: %d\n", p, q))
  f2(x)
}


f(0)


g <- function(x) {
  p <- 1
  q <- 2
  cat(sprintf("1. [f1] p: %d, q: %d\n", p, q))
  g2 <- function(x) {
    p <<- 3
    p <- 2
    cat(sprintf("2. [f2] p: %d, q: %d\n", p, q))
    c(x = x, p = p, q = q)
  }
  cat(sprintf("3. [f1] p: %d, q: %d\n", p, q))
  result <- g2(x)
  cat(sprintf("4. [f1] p: %d, q: %d\n", p, q))
  result
}


g(0)


e1 <- new.env()


e1


e1$x <- 1
e1[["x"]]


e1[1:3]


e1[[1]]


exists("x", e1)


get("x", e1)


ls(e1)


e1$y
e1[["y"]]


get("y", e1)


exists("y", e1)


e2 <- new.env(parent = e1)


e2
e1


parent.env(e2)


e2$y <- 2


ls(e2)


e2$y
e2[["y"]]
exists("y", e2)
get("y", e2)


e2$x
e2[["x"]]


exists("x", e2)
get("x", e1)


exists("x", e2, inherits = FALSE)


get("x", e2, inherits = FALSE)


ls(e1)
e3 <- e1


e3$y
e1$y <- 2
e3$y


modify <- function(e) {
  e$z <- 10
}


list1 <- list(x = 1, y = 2)
list1$z
modify(list1)
list1$z


e1$z
modify(e1)
e1$z


environment()


global <- environment()
global$some_obj <- 1


some_obj


globalenv()


baseenv()


parents <- function(env) {
  while (TRUE) {
    name <- environmentName(env)
    txt <- if (nzchar(name)) name else format(env)
    cat(txt, "\n")
    env <- parent.env(env)
  }
}


parents(globalenv())


search()


median(c(1, 2, 1 + 3))


simple_fun <- function() {
  cat("Executing environment: ")
  print(environment())
  cat("Enclosing environment: ")
  print(parent.env(environment()))
}


simple_fun()
simple_fun()
simple_fun()


environment(simple_fun)


f1 <- function() {
  cat("[f1] Executing in ")
  print(environment())
  cat("[f1] Enclosed by ")
  print(parent.env(environment()))
  cat("[f1] Calling from ")
  print(parent.frame())
  
  f2 <- function() {
    cat("[f2] Executing in ")
    print(environment())
    cat("[f2] Enclosed by ")
    print(parent.env(environment()))
    cat("[f2] Calling from ")
    print(parent.frame())
  }
  
  f3 <- function() {
    cat("[f3] Executing in ")
    print(environment())
    cat("[f3] Enclosed by ")
    print(parent.env(environment()))
    cat("[f3] Calling from ")
    print(parent.frame())
    f2()
  }
  
  f3()
}


f1()
