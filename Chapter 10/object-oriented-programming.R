vec1 <- c(1, 2, 3)
typeof(vec1)
class(vec1)


data1 <- data.frame(x = 1:3, y = rnorm(3))
typeof(data1)
class(data1)


head


num_vec <- c(1, 2, 3, 4, 5)
data_frame <- data.frame(x = 1:5, y = rnorm(5))


head(num_vec, 3)


head(data_frame, 3)


simple_head <- function(x, n) {
  x[1:n]
}


simple_head(num_vec, 3)


simple_head(data_frame, 3)


simple_head2 <- function(x, n) {
  if (is.data.frame(x)) {
    x[1:n,]
  } else {
    x[1:n]
  }
}


simple_head2(num_vec, 3)
simple_head2(data_frame, 3)


methods("head")


lm1 <- lm(mpg ~ cyl + vs, data = mtcars)


typeof(lm1)
class(lm1)


lm1


print(lm1)


identical(getS3method("print", "lm"), stats:::print.lm)


length(methods("print"))


summary(lm1)


lm1summary <- summary(lm1)
typeof(lm1summary)
class(lm1summary)


names(lm1summary)


coef(lm1)


coef(lm1summary)


oldpar <- par(mfrow = c(2, 2))
plot(lm1)
par(oldpar)


predict(lm1, data.frame(cyl = c(6, 8), vs = c(1, 1)))


plot(mtcars$mpg, fitted(lm1))


plot(density(residuals(lm1)), 
  main = "Density of lm1 residuals")


install.packages("rpart")


library(rpart)
tree_model <- rpart(mpg ~ cyl + vs, data = mtcars)


typeof(tree_model)
class(tree_model)


print(tree_model)


summary(tree_model)


oldpar <- par(xpd = NA)
plot(tree_model)
text(tree_model, use.n = TRUE)
par(oldpar)


predict(tree_model, data.frame(cyl = c(6, 8), vs = c(1, 1)))


coef(tree_model)


generic_head <- function(x, n) 
  UseMethod("generic_head")


generic_head.default <- function(x, n) {
  x[1:n]
}


generic_head(num_vec, 3)


generic_head(data_frame, 3)


generic_head.data.frame <- function(x, n) {
  x[1:n,]
}


generic_head(data_frame, 3)


product <- function(name, price, inventory) {
  obj <- list(name = name, 
    price = price, 
    inventory = inventory)
  class(obj) <- "product"
  obj
}


product <- function(name, price, inventory) {
  structure(list(name = name, 
    price = price, 
    inventory = inventory),
    class = "product")
}


laptop <- product("Laptop", 499, 300)


typeof(laptop)
class(laptop)


laptop


print.product <- function(x, ...) {
  cat("<product>\n")
  cat("name:", x$name, "\n")
  cat("price:", x$price, "\n")
  cat("inventory:", x$inventory, "\n")
  invisible(x)
}


laptop


laptop$name
laptop$price
laptop$inventory


cellphone <- product("Phone", 249, 12000)
products <- list(laptop, cellphone)
products


product("Basket", 150, -0.5)


product <- function(name, price, inventory) {
  stopifnot(is.character(name), length(name) == 1,
    is.numeric(price), length(price) == 1, 
    is.numeric(inventory), length(inventory) == 1, 
    price > 0, inventory >= 0)
  structure(list(name = name, 
    price = as.numeric(price), 
    inventory = as.integer(inventory)),
    class = "product")
}


product("Basket", 150, -0.5)


value <- function(x, ...) 
  UseMethod("value")

value.default <- function(x, ...) {
  stop("Value is undefined")
}

value.product <- function(x, ...) {
  x$price * x$inventory
}


value(laptop)
value(cellphone)


sapply(products, value)


laptop$price <- laptop$price * 0.85


laptop$value <- laptop$price * laptop$inventory


laptop


percent <- function(x) {
  stopifnot(is.numeric(x))
  class(x) <- c("percent", "numeric")
  x
}


pct <- percent(c(0.1, 0.05, 0.25, 0.23))
pct


as.character.percent <- function(x, ...) {
  paste0(as.numeric(x) * 100, "%")
}


as.character(pct)


format.percent <- function(x, ...) {
  as.character(x, ...)
}


format(pct)


print.percent <- function(x, ...) {
  print(format.percent(x), quote = FALSE)
}


pct


pct + 0.2
pct * 0.5


sum(pct)
mean(pct)
max(pct)
min(pct)


sum.percent <- function(...) {
  percent(NextMethod("sum"))
}
mean.percent <- function(x, ...) {
  percent(NextMethod("mean"))
}
max.percent <- function(...) {
  percent(NextMethod("max"))
}
min.percent <- function(...) {
  percent(NextMethod("max"))
}


sum(pct)
mean(pct)
max(pct)
min(pct)


c(pct, 0.12)


c.percent <- function(x, ...) {
  percent(NextMethod("c"))
}


c(pct, 0.12, -0.145)


pct[1:3]
pct[[2]]


`[.percent` <- function(x, i) {
  percent(NextMethod("["))
}
`[[.percent` <- function(x, i) {
  percent(NextMethod("[["))
}


pct[1:3]
pct[[2]]


data.frame(id = 1:4, pct)


Vehicle <- function(class, name, speed) {
  obj <- new.env(parent = emptyenv())
  obj$name <- name
  obj$speed <- speed
  obj$position <- c(0, 0, 0)
  class(obj) <- c(class, "vehicle")
  obj
}


Car <- function(...) {
  Vehicle(class = "car", ...)
}
Bus <- function(...) {
  Vehicle(class = "bus", ...)
}
Airplane <- function(...) {
  Vehicle(class = "airplane", ...)
}


car <- Car("Model-A", 80)
bus <- Bus("Medium-Bus", 45)
airplane <- Airplane("Big-Plane", 800)


print.vehicle <- function(x, ...) {
  cat(sprintf("<vehicle: %s>\n", class(x)[[1]]))
  cat("name:", x$name, "\n")
  cat("speed:", x$speed, "km/h\n")
  cat("position:", paste(x$position, collapse = ", "))
}


car
bus
airplane


move <- function(vehicle, x, y, z) {
  UseMethod("move")
}
move.vehicle <- function(vehicle, movement) {
  if (length(movement) != 3) {
    stop("All three dimensions must be specified to move a vehicle")
  }
  vehicle$position <- vehicle$position + movement
  vehicle
}


move.bus <- move.car <- function(vehicle, movement) {
  if (length(movement) != 2) {
    stop("This vehicle only supports 2d movement")
  }
  movement <- c(movement, 0)
  NextMethod("move")
}


move.airplane <- function(vehicle, movement) {
  if (length(movement) == 2) {
    movement <- c(movement, 0)
  }
  NextMethod("move")
}


move(car, c(1, 2, 3))


move(car, c(1, 2))


move(airplane, c(1, 2))


move(airplane, c(20, 50, 80))


setClass("Product", 
  representation(name = "character", 
    price = "numeric", 
    inventory = "integer"))


getSlots("Product")


laptop <- new("Product", name = "Laptop-A", price = 299, inventory = 100)


laptop <- new("Product", name = "Laptop-A", price = 299, inventory = 100L)
laptop


typeof(laptop)
class(laptop)


isS4(laptop)


laptop@price * laptop@inventory


slot(laptop, "price")


laptop@price <- 289


laptop@inventory <- 200


laptop@value <- laptop@price * laptop@inventory


toy <- new("Product", name = "Toys", price = 10)
toy


setClass("Product", 
  representation(name = "character", 
    price = "numeric", 
    inventory = "integer"),
  prototype(name = "Unnamed", price = NA_real_, inventory = 0L))


toy <- new("Product", name = "Toys", price = 5)
toy


bottle <- new("Product", name = "Bottle", price = 1.5, inventory = -2L)
bottle


validate_product <- function(object) {
  errors <- c(
    if (length(object@name) != 1)  
      "Length of name should be 1" 
    else if (is.na(object@name)) 
      "name should not be missing value",
    
    if (length(object@price) != 1) 
      "Length of price should be 1"
    else if (is.na(object@price)) 
      "price should not be missing value"
    else if (object@price <= 0) 
      "price must be positive",
    
    if (length(object@inventory) != 1) 
      "Length of inventory should be 1"
    else if (is.na(object@inventory))
      "inventory should not be missing value"
    else if (object@inventory < 0) 
      "inventory must be non-negative")
  if (length(errors) == 0) TRUE else errors
}


validate_product(bottle)


setClass("Product", 
  representation(name = "character", 
    price = "numeric", 
    inventory = "integer"),
  prototype(name = "Unnamed", price = NA_real_, inventory = 0L),
  validity = validate_product)


bottle <- new("Product", name = "Bottle")


bottle <- new("Product", name = "Bottle", price = 3, inventory = -2L)


bottle <- new("Product", name = "Bottle", 
  price = 3, inventory = 100L, volume = 15)


setClass("Container", 
  representation(volume = "numeric"), 
  contains = "Product")


getSlots("Container")


bottle <- new("Container", name = "Bottle",
  price = 3, inventory = 100L, volume = 15)


bottle <- new("Container", name = "Bottle",
  price = 3, inventory = -10L, volume = 15)


bottle <- new("Container", name = "Bottle",
  price = 3, inventory = 100L, volume = -2)


validate_container <- function(object) {
  errors <- c(
    if (length(object@volume) != 1)
      "Length of volume must be 1",
    if (object@volume <= 0)
      "volume must be positive"
  )
  if (length(errors) == 0) TRUE else errors
}


setClass("Container", 
  representation(volume = "numeric"), 
  contains = "Product",
  validity = validate_container)


bottle <- new("Container", name = "Bottle",
  price = 3, inventory = 100L, volume = -2)
bottle <- new("Container", name = "Bottle",
  price = 3, inventory = -5L, volume = 10)


setClass("Shape")
setClass("Polygon", 
  representation(sides = "integer"), 
  contains = "Shape")
setClass("Triangle", 
  representation(a = "numeric", b = "numeric", c = "numeric"), 
  prototype(a = 1, b = 1, c = 1, sides = 3L),
  contains = "Polygon")
setClass("Rectangle",
  representation(a = "numeric", b = "numeric"),
  prototype(a = 1, b = 1, sides = 4L),
  contains = "Polygon")
setClass("Circle",
  representation(r = "numeric"),
  prototype(r = 1, sides = Inf),
  contains = "Shape")


setGeneric("area", function(object) {
  standardGeneric("area")
}, valueClass = "numeric")


setMethod("area", signature("Triangle"), function(object) {
  a <- object@a
  b <- object@b
  c <- object@c
  s <- (a + b + c) / 2
  sqrt(s * (s - a) * (s - b) * (s - c))
})


setMethod("area", signature("Rectangle"), function(object) {
  object@a * object@b
})
setMethod("area", signature("Circle"), function(object) {
  pi * object@r ^ 2
})


triangle <- new("Triangle", a = 3, b = 4, c = 5)
area(triangle)


circle <- new("Circle", r = 3)
area(circle)


setClass("Object", representation(height = "numeric"))
setClass("Cylinder", contains = "Object")
setClass("Cone", contains = "Object")


setGeneric("volume", 
  function(shape, object) standardGeneric("volume"))


setMethod("volume", signature("Rectangle", "Cylinder"), 
  function(shape, object) {
    shape@a * shape@b * object@height
  })
setMethod("volume", signature("Rectangle", "Cone"),
  function(shape, object) {
    shape@a * shape@b * object@height / 3
  })


rectangle <- new("Rectangle", a = 2, b = 3)
cylinder <- new("Cylinder", height = 3)
volume(rectangle, cylinder)


setMethod("volume", signature("Shape", "Cylinder"), 
  function(shape, object) {
    area(shape) * object@height
  })
setMethod("volume", signature("Shape", "Cone"),
  function(shape, object) {
    area(shape) * object@height / 3
  })


circle <- new("Circle", r = 2)
cone <- new("Cone", height = 3)
volume(circle, cone)


setMethod("volume", signature("Shape", "numeric"),
  function(shape, object) {
    area(shape) * object
  })


volume(rectangle, 3)


setMethod("*", signature("Shape", "Object"), 
  function(e1, e2) {
    volume(e1, e2)
  })


rectangle * cone


lengthen <- function(object, factor) {
  object@height <- object@height * factor
  object
}


cylinder
lengthen(cylinder, 2)
cylinder


Vehicle <- setRefClass("Vehicle", 
  fields = list(position = "numeric", distance = "numeric"))


car <- Vehicle$new(position = 0, distance = 0)


car$position


move <- function(vehicle, movement) {
  vehicle$position <- vehicle$position + movement
  vehicle$distance <- vehicle$distance + abs(movement)
}


move(car, 10)
car


Vehicle <- setRefClass("Vehicle", 
  fields = list(position = "numeric", distance = "numeric"),
  methods = list(move = function(x) {
    stopifnot(is.numeric(x))
    position <<- position + x
    distance <<- distance + abs(x)
  }))


bus <- Vehicle(position = 0, distance = 0)
bus$move(5)
bus


install.packages("R6")


library(R6)
Vehicle <- R6Class("Vehicle", 
  public = list(
    name = NA,
    model = NA,
    initialize = function(name, model) {
      if (!missing(name)) self$name <- name
      if (!missing(model)) self$model <- model
    },
    move = function(movement) {
      private$start()
      private$position <- private$position + movement
      private$stop()
    },
    get_position = function() {
      private$position
    }
  ),
  private = list(
    position = 0,
    speed = 0,
    start = function() {
      cat(self$name, "is starting\n")
      private$speed <- 50
    },
    stop = function() {
      cat(self$name, "is stopping\n")
      private$speed <- 0
    }
  ))


car <- Vehicle$new(name = "Car", model = "A")
car


car$move(10)
car$get_position()


MeteredVehicle <- R6Class("MeteredVehicle",
  inherit = Vehicle,
  public = list(
    move = function(movement) {
      super$move(movement)
      private$distance <<- private$distance + abs(movement)
    },
    get_distance = function() {
      private$distance
    }
  ),
  private = list(
    distance = 0
  ))


bus <- MeteredVehicle$new(name = "Bus", model = "B")
bus


bus$move(10)
bus$get_position()
bus$get_distance()


bus$move(-5)
bus$get_position()
bus$get_distance()
