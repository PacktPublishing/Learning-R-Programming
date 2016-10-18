
getwd()


"Hello\nWorld"


cat("Hello\nWorld")


cat("The string with '\\' is translated")


filename <- "d:\data\test.csv"
## Error: '\d' is an unrecognized escape in character string starting ""d:\d"


filename <- "d:\\data\\test.csv"


absolute_filename <- "d:/data/test.csv"
relative_filename <- "data/test.csv"


objects()


e <- new.env()
objects(pos = e)


x <- c(1, 2, 3)
y <- c("a", "b", "c")
z <- list(m = 1:5, n = c("x", "y", "z"))


objects()


with(e, {
  x <- c(1, 2, 3)
  y <- c("a", "b", "c")
  z <- list(m = 1:5, n = c("x", "y", "z"))
  objects()
})


ls()


with(e, ls())


x
str(x)


str(1:30)


z


str(z)


nested_list <- list(m = 1:15, n = list("a", c(1, 2, 3)), 
  p = list(x = 1:10, y = c("a", "b")), 
  q = list(x = 0:9, y = c("c", "d")))


with(e, nested_list <- nested_list)


nested_list


str(nested_list)


ls.str()


ls.str(pos = e)


ls.str(mode = "list")


ls.str(e, mode = "list")


ls.str(pattern = "^\\w$")


ls.str(e, pattern = "^\\w$")


ls.str(pattern = "^\\w$", mode = "list")


ls.str(e, pattern = "^\\w$", mode = "list")


ls()


with(e, ls())


rm(x)
ls()


with(e, {
  rm(x)
  ls()
})


rm(y, z)
ls()


with(e, {
  rm(y, z)
  ls()
})


rm(x)


with(e, rm(x))


p <- 1:10
q <- seq(1, 20, 5)
v <- c("p", "q")
rm(list = v)


with(e, {
  p <- 1:10
  q <- seq(1, 20, 5)
  v <- c("p", "q")
  rm(list = v)
  ls()
})


rm(list = ls())
ls()


with(e, {
  rm(list = ls())
  ls()
})




123.12345678


0.10000002
0.10000002 - 0.1


1234567.12345678


getOption("digits")
1e10 + 0.5
options(digits = 15)
1e10 + 0.5


options(digits = 7)
1e10 + 0.5


getOption("warn")


as.numeric("hello")


options(warn = -1)
as.numeric("hello")


f <- function(x, y) {
  as.numeric(x) + as.numeric(y)
}


options(warn = 0)
f("hello", "world")


options(warn = 1)
f("hello", "world")


options(warn = 2)
f("hello", "world")


options(warn = 0)




install.packages("ggplot2")




install.packages(c("ggplot2", "shiny", "knitr", "dplyr", "data.table"))


update.packages()


install.packages("devtools")


devtools::install_github("hadley/ggplot2")


install.packages("ggplot2")


library(moments)
skewness(x)


moments::skewness(x)


sessionInfo()


moments::skewness(c(1, 2, 3, 2, 1))
sessionInfo()


library(moments)
sessionInfo()
skewness(c(1, 2, 3, 2, 1))


search()


unloadNamespace("moments")


loaded <- require(moments)
loaded


if (!require(moments)) {
  install.packages("moments")
  library(moments)
}


require(moments)


require(testPkg)


library(testPkg)


library(dplyr)


fun1 <- package1::some_function
fun2 <- pacakge2::some_function


unloadNamespace("moments")


skewness(c(1, 2, 3, 2, 1))


moments::skewness(c(1, 2, 3, 2, 1))


pkgs <- installed.packages()
colnames(pkgs)


c("moments", "testPkg") %in% installed.packages()[, "Package"]


installed.packages()["moments", "Version"]


packageVersion("moments")


packageVersion("moments") >= package_version("0.14")


packageVersion("moments") >= "0.14"


