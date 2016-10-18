install.packages("RSQLite")


if (file.exists("data/example.sqlite")) 
  file.remove("data/example.sqlite")


if (!dir.exists("data")) dir.create("data")


library(RSQLite)
con <- dbConnect(SQLite(), "data/example.sqlite")


example1 <- data.frame(
  id = 1:5, 
  type = c("A", "A", "B", "B", "C"),
  score = c(8, 9, 8, 10, 9), 
  stringsAsFactors = FALSE)
example1


dbWriteTable(con, "example1", example1)


dbDisconnect(con)


if (file.exists("data/datasets.sqlite")) 
  file.remove("data/datasets.sqlite")


install.packages(c("ggplot2", "nycflights13"))


data("diamonds", package = "ggplot2")
data("flights", package = "nycflights13")


con <- dbConnect(SQLite(), "data/datasets.sqlite")
dbWriteTable(con, "diamonds", diamonds, row.names = FALSE)
dbWriteTable(con, "flights", flights, row.names = FALSE)
dbDisconnect(con)


class(diamonds)
class(flights)


con <- dbConnect(SQLite(), "data/datasets.sqlite")
dbWriteTable(con, "diamonds", as.data.frame(diamonds), row.names = FALSE)
dbWriteTable(con, "flights", as.data.frame(flights), row.names = FALSE)
dbDisconnect(con)


if (file.exists("data/example2.sqlite")) 
  file.remove("data/example2.sqlite")


con <- dbConnect(SQLite(), "data/example2.sqlite")
chunk_size <- 10
id <- 0
for (i in 1:6) {
  chunk <- data.frame(id = ((i - 1L) * chunk_size):(i * chunk_size - 1L), 
    type = LETTERS[[i]],
    score = rbinom(chunk_size, 10, (10 - i) / 10),
    stringsAsFactors = FALSE)
  dbWriteTable(con, "products", chunk, 
    append = i > 1, row.names = FALSE)
}
dbDisconnect(con)


con <- dbConnect(SQLite(), "data/datasets.sqlite")


dbExistsTable(con, "diamonds")
dbExistsTable(con, "mtcars")


dbListTables(con)


dbListFields(con, "diamonds")


db_diamonds <- dbReadTable(con, "diamonds")
dbDisconnect(con)


head(db_diamonds, 3)
head(diamonds, 3)


identical(diamonds, db_diamonds)


str(db_diamonds)


str(diamonds)


con <- dbConnect(SQLite(), "data/datasets.sqlite")
dbListTables(con)


db_diamonds <- dbGetQuery(con, 
  "select * from diamonds")
head(db_diamonds, 3)


db_diamonds <- dbGetQuery(con, 
  "select carat, cut, color, clarity, depth, price 
  from diamonds")
head(db_diamonds, 3)


dbGetQuery(con, "select distinct cut from diamonds")


dbGetQuery(con, "select distinct clarity from diamonds")[[1]]


db_diamonds <- dbGetQuery(con, 
  "select carat, price, clarity as clarity_level from diamonds")
head(db_diamonds, 3)


db_diamonds <- dbGetQuery(con,
  "select carat, price, x * y * z as size from diamonds")
head(db_diamonds, 3)


db_diamonds <- dbGetQuery(con,
  "select carat, price, x * y * z as size,
  price / size as value_density
  from diamonds")


db_diamonds <- dbGetQuery(con,
  "select *, price / size as value_density from
  (select carat, price, x * y * z as size from diamonds)")
head(db_diamonds, 3)


good_diamonds <- dbGetQuery(con, 
  "select carat, cut, price from diamonds where cut = 'Good'")
head(good_diamonds, 3)


nrow(good_diamonds) / nrow(diamonds)


good_e_diamonds <- dbGetQuery(con, 
  "select carat, cut, color, price from diamonds 
  where cut = 'Good' and color = 'E'")
head(good_e_diamonds, 3)
nrow(good_e_diamonds) / nrow(diamonds)


color_ef_diamonds <- dbGetQuery(con,
  "select carat, cut, color, price from diamonds
  where color in ('E','F')")
nrow(color_ef_diamonds)


table(diamonds$color)


some_price_diamonds <- dbGetQuery(con,
  "select carat, cut, color, price from diamonds
  where price between 5000 and 5500")
nrow(some_price_diamonds) / nrow(diamonds)


good_cut_diamonds <- dbGetQuery(con, 
  "select carat, cut, color, price from diamonds
  where cut like '%Good'")
nrow(good_cut_diamonds) / nrow(diamonds)


cheapest_diamonds <- dbGetQuery(con,
  "select carat, price from diamonds
  order by price")


head(cheapest_diamonds)


most_expensive_diamonds <- dbGetQuery(con,
  "select carat, price from diamonds
  order by price desc")
head(most_expensive_diamonds)


cheapest_diamonds <- dbGetQuery(con, 
  "select carat, price from diamonds
  order by price, carat desc")
head(cheapest_diamonds)


dense_diamonds <- dbGetQuery(con,
  "select carat, price, x * y * z as size from diamonds
  order by carat / size desc")
head(dense_diamonds)


head(dbGetQuery(con, 
  "select carat, price from diamonds
   where cut = 'Ideal' and clarity = 'IF' and color = 'J'
   order by price"))


dbGetQuery(con, 
  "select carat, price from diamonds
  order by carat desc limit 3")


dbGetQuery(con,
  "select color, count(*) as number from diamonds
  group by color")


table(diamonds$color)


dbGetQuery(con,
  "select clarity, avg(price) as avg_price 
   from diamonds
   group by clarity 
   order by avg_price desc")


dbGetQuery(con,
  "select price, max(carat) as max_carat 
   from diamonds
   group by price
   order by price
   limit 5")


dbGetQuery(con,
  "select clarity, 
     min(price) as min_price, 
     max(price) as max_price,
     avg(price) as avg_price
   from diamonds
   group by clarity 
   order by avg_price desc")


dbGetQuery(con,
  "select clarity,
     sum(price * carat) / sum(carat) as wprice
   from diamonds
   group by clarity 
   order by wprice desc")


dbGetQuery(con,
  "select clarity, color,
     avg(price) as avg_price
   from diamonds
   group by clarity, color 
   order by avg_price desc 
   limit 5")


diamond_selector <- data.frame(
  cut = c("Ideal", "Good", "Fair"),
  color = c("E", "I", "D"),
  clarity = c("VS1", "I1", "IF"),
  stringsAsFactors = FALSE
)
diamond_selector


dbWriteTable(con, "diamond_selector", diamond_selector, 
  row.names = FALSE, overwrite = TRUE)


subset_diamonds <- dbGetQuery(con, 
  "select cut, color, clarity, carat, price
   from diamonds
   join diamond_selector using (cut, color, clarity)")
head(subset_diamonds)


nrow(subset_diamonds) / nrow(diamonds)


dbDisconnect(con)


con <- dbConnect(SQLite(), "data/datasets.sqlite")
res <- dbSendQuery(con, 
  "select carat, cut, color, price from diamonds
  where cut = 'Ideal' and color = 'E'")
while (!dbHasCompleted(res)) {
  chunk <- dbFetch(res, 800)
  cat(nrow(chunk), "records fetched\n")
  # do something with chunk
}
dbClearResult(res)
dbDisconnect(con)


file.remove("data/products.sqlite")


set.seed(123)
con <- dbConnect(SQLite(), "data/products.sqlite")
chunk_size <- 10
for (i in 1:6) {
  cat("Processing chunk", i, "\n")
  if (runif(1) <= 0.2) stop("Data error")
  chunk <- data.frame(id = ((i - 1L) * chunk_size):(i * chunk_size - 1L), 
    type = LETTERS[[i]],
    score = rbinom(chunk_size, 10, (10 - i) / 10),
    stringsAsFactors = FALSE)
  dbWriteTable(con, "products", chunk, 
    append = i > 1, row.names = FALSE)
}


dbGetQuery(con, "select COUNT(*) from products")
dbDisconnect(con)


set.seed(123)
file.remove("data/products.sqlite")
con <- dbConnect(SQLite(), "data/products.sqlite")
chunk_size <- 10
dbBegin(con)
res <- tryCatch({
  for (i in 1:6) {
    cat("Processing chunk", i, "\n")
    if (runif(1) <= 0.2) stop("Data error")
    chunk <- data.frame(id = ((i - 1L) * chunk_size):(i * chunk_size - 1L), 
      type = LETTERS[[i]],
      score = rbinom(chunk_size, 10, (10 - i) / 10),
      stringsAsFactors = FALSE)
    dbWriteTable(con, "products", chunk, 
      append = i > 1, row.names = FALSE)
  }
  dbCommit(con)
}, error = function(e) {
  warning("An error occurs: ", e, "\nRolling back", immediate. = TRUE)
  dbRollback(con)
})


dbGetQuery(con, "select COUNT(*) from products")
dbDisconnect(con)


file.remove("data/bank.sqlite")


create_bank <- function(dbfile) {
  if (file.exists(dbfile)) file.remove(dbfile)
  con <- dbConnect(SQLite(), dbfile)
  dbSendQuery(con, 
    "create table accounts 
    (name text primary key, balance real)")
  dbSendQuery(con,
    "create table transactions 
    (time text, account_from text, account_to text, value real)")
  con
}


create_account <- function(con, name, balance) {
  dbSendQuery(con, 
    sprintf("insert into accounts (name, balance) values ('%s',%.2f)", name, balance))
  TRUE
}


transfer <- function(con, from, to, value) {
  get_account <- function(name) {
    account <- dbGetQuery(con, 
      sprintf("select * from accounts where name = '%s'", name))
    if (nrow(account) == 0) stop(sprintf("Account '%s' does not exist", name))
    account
  }
  account_from <- get_account(from)
  account_to <- get_account(to)
  if (account_from$balance < value) {
    stop(sprintf("Insufficient money to transfer from '%s'", from))
  } else {
    dbSendQuery(con, 
      sprintf("update accounts set balance = %.2f where name = '%s'",
        account_from$balance - value, from))
    dbSendQuery(con,
      sprintf("update accounts set balance = %.2f where name = '%s'",
        account_to$balance + value, to))
    dbSendQuery(con,
      sprintf("insert into transactions (time, account_from, account_to, value) values
        ('%s', '%s', '%s', %.2f)", format(Sys.time(), "%Y-%m-%d %H:%M:%S"),
        from, to, value))
  }
  TRUE
}


safe_transfer <- function(con, ...) {
  dbBegin(con)
  tryCatch({
    transfer(con, ...)
    dbCommit(con)
  }, error = function(e) {
    message("An error occurs in the transaction. Rollback...")
    dbRollback(con)
    stop(e)
  })
}


get_balance <- function(con, name) {
  res <- dbGetQuery(con, 
    sprintf("select balance from accounts where name = '%s'", name))
  res$balance
}
get_transactions <- function(con, from, to) {
  dbGetQuery(con,
    sprintf("select * from transactions 
      where account_from = '%s' and account_to = '%s'", from, to))
}


con <- create_bank("data/bank.sqlite")
create_account(con, "David", 5000)
create_account(con, "Jenny", 6500)
get_balance(con, "David")
get_balance(con, "Jenny")


safe_transfer(con, "David", "Jenny", 1500)
get_balance(con, "David")
get_balance(con, "Jenny")


safe_transfer(con, "David", "Jenny", 6500)
get_balance(con, "David")
get_balance(con, "Jenny")


get_transactions(con, "David", "Jenny")


dbDisconnect(con)


chunk_rw <- function(input, output, table, chunk_size = 10000) {
  first_row <- read.csv(input, nrows = 1, header = TRUE)
  header <- colnames(first_row)
  n <- 0
  con <- dbConnect(SQLite(), output)
  on.exit(dbDisconnect(con))
  while (TRUE) {
    df <- read.csv(input, 
      skip = 1 + n * chunk_size, nrows = chunk_size, 
      header = FALSE, col.names = header,
      stringsAsFactors = FALSE)
    if (nrow(df) == 0) break;
    dbWriteTable(con, table, df, row.names = FALSE, append = n > 0)
    n <- n + 1
    cat(sprintf("%d records written\n", nrow(df)))
  }
}


file.remove("data/diamonds.csv", "data/diamonds.sqlite")


write.csv(diamonds, "data/diamonds.csv", quote = FALSE, row.names = FALSE)
chunk_rw("data/diamonds.csv", "data/diamonds.sqlite", "diamonds")


batch_rw <- function(dir, output, table, overwrite = TRUE) {
  files <- list.files(dir, "\\.csv$", full.names = TRUE)
  con <- dbConnect(SQLite(), output)
  on.exit(dbDisconnect(con))
  exist <- dbExistsTable(con, table)
  if (exist) {
    if (overwrite) dbRemoveTable(con, table)
    else stop(sprintf("Table '%s' already exists", table))
  }
  exist <- FALSE
  for (file in files) {
    cat(file, "... ")
    df <- read.csv(file, header = TRUE, stringsAsFactors = FALSE)
    dbWriteTable(con, table, df, row.names = FALSE, 
      append = exist)
    exist <- TRUE
    cat("done\n")
  }
}


file.remove("data/groups.sqlite")


batch_rw("data/groups", "data/groups.sqlite", "groups")


con <- dbConnect(SQLite(), "data/groups.sqlite")
dbReadTable(con, "groups")
dbDisconnect(con)


install.packages("mongolite")


library(mongolite)
m <- mongo("products", "test", "mongodb://localhost")


m$count()


m$insert('
{
  "code": "A0000001",
  "name": "Product-A",
  "type": "Type-I",
  "price": 29.5,
  "amount": 500,
  "comments": [
    {
      "user": "david",
      "score": 8,
      "text": "This is a good product"
    },
    {
      "user": "jenny",
      "score": 5,
      "text": "Just so so"
    }
  ]
}')


m$count()


m$insert(list(
  code = "A0000002",
  name = "Product-B",
  type = "Type-II",
  price = 59.9,
  amount = 200L,
  comments = list(
    list(user = "tom", score = 6L,
      text = "Just fine"),
    list(user = "mike", score = 9L,
      text = "great product!")
  )
), auto_unbox = TRUE)


m$count()


products <- m$find()
str(products)


iter <- m$iterate()
products <- iter$batch(2)
str(products)


m$find('{ "code": "A0000001" }', 
  '{ "_id": 0, "name": 1, "price": 1, "amount": 1 }')


m$find('{ "price": { "$gte": 40 } }',
  '{ "_id": 0, "name": 1, "price": 1, "amount": 1 }')


m$find('{ "comments.score": 9 }', 
  '{ "_id": 0, "code": 1, "name": 1}')


m$find('{ "comments.score": { "$lt": 6 }}',
  '{ "_id": 0, "code": 1, "name": 1}')


m$drop()


m <- mongo("students", "test", "mongodb://localhost")


m$count()


students <- data.frame(
  name = c("David", "Jenny", "Sara", "John"),
  age = c(25, 23, 26, 23),
  major = c("Statistics", "Physics", "Computer Science", "Statistics"),
  projects = c(2, 1, 3, 1),
  stringsAsFactors = FALSE
)
students


m$insert(students)


m$count()


m$find()


m$find('{ "name": "Jenny" }')


m$find('{ "projects": { "$gte": 2 }}')


m$find('{ "projects": { "$gte": 2 }}', 
  '{ "_id": 0, "name": 1, "major": 1 }')


m$find('{ "projects": { "$gte": 2 }}', 
  fields = '{ "_id": 0, "name": 1, "age": 1 }',
  sort = '{ "age": -1 }')


m$find('{ "projects": { "$gte": 2 }}', 
  fields = '{ "_id": 0, "name": 1, "age": 1 }',
  sort = '{ "age": -1 }',
  limit = 1)


m$distinct("major")


m$distinct("major", '{ "projects": { "$gte": 2 } }')


m$update('{ "name": "Jenny" }', '{ "$set": { "age": 24 } }')
m$find()


m$index('{ "name": 1 }')


m$find('{ "name": "Sara" }')


m$find('{ "name": "Jane" }')


m$drop()


set.seed(123)
m <- mongo("simulation", "test")
sim_data <- expand.grid(
  type = c("A", "B", "C", "D", "E"), 
  category = c("P-1", "P-2", "P-3"),
  group = 1:20000, 
  stringsAsFactors = FALSE)
head(sim_data)


sim_data$score1 <- rnorm(nrow(sim_data), 10, 3)
sim_data$test1 <- rbinom(nrow(sim_data), 100, 0.8)


head(sim_data)


m$insert(sim_data)


system.time(rec <- m$find('{ "type": "C", "category": "P-3", "group": 87 }'))
rec


system.time({
  recs <- m$find('{ "type": { "$in": ["B", "D"]  }, 
    "category": { "$in": ["P-1", "P-2"] }, 
    "group": { "$gte": 25, "$lte": 75 } }')
})


head(recs)


system.time(recs2 <- m$find('{ "score1": { "$gte": 20 } }'))


head(recs2)


m$index('{ "type": 1, "category": 1, "group": 1 }')


system.time({
  rec <- m$find('{ "type": "C", "category": "P-3", "group": 87 }')
})


system.time({
  recs <- m$find('{ "type": { "$in": ["B", "D"]  }, 
    "category": { "$in": ["P-1", "P-2"] }, 
    "group": { "$gte": 25, "$lte": 75 } }')
})


system.time({
  recs2 <- m$find('{ "score1": { "$gte": 20 } }')
})


m$aggregate('[
  { "$group": { 
      "_id": "$type", 
      "count": { "$sum": 1 },
      "avg_score": { "$avg": "$score1" },
      "min_test": { "$min": "$test1" },
      "max_test": { "$max": "$test1" }
    }
  }
]')


m$aggregate('[
  { "$group": { 
      "_id": { "type": "$type", "category": "$category" }, 
      "count": { "$sum": 1 },
      "avg_score": { "$avg": "$score1" },
      "min_test": { "$min": "$test1" },
      "max_test": { "$max": "$test1" }
    }
  }
]')


m$aggregate('[
  { "$group": { 
      "_id": { "type": "$type", "category": "$category" }, 
      "count": { "$sum": 1 },
      "avg_score": { "$avg": "$score1" },
      "min_test": { "$min": "$test1" },
      "max_test": { "$max": "$test1" }
    }
  }, 
  {
    "$sort": { "_id.type": 1, "avg_score": -1 }
  }
]')


m$aggregate('[
  { "$group": { 
      "_id": { "type": "$type", "category": "$category" }, 
      "count": { "$sum": 1 },
      "avg_score": { "$avg": "$score1" },
      "min_test": { "$min": "$test1" },
      "max_test": { "$max": "$test1" }
    }
  }, 
  {
    "$sort": { "avg_score": -1 }
  }, 
  {
    "$limit": 3
  }, 
  {
    "$project": { 
      "_id.type": 1, 
      "_id.category": 1, 
      "avg_score": 1, 
      "test_range": { "$subtract": ["$max_test", "$min_test"] }
    }
  }
]')


bins <- m$mapreduce(
  map = 'function() {
    emit(Math.floor(this.score1 / 2.5) * 2.5, 1);
  }',
  reduce = 'function(id, counts) {
    return Array.sum(counts);
  }'
)


bins


with(bins, barplot(value / sum(value), names.arg = `_id`,
  main = "Histogram of scores", 
  xlab = "score1", ylab = "Percentage"))


m$drop()


install.packages("rredis")


library(rredis)
redisConnect()


library(rredis)
redisConnect(nodelay = FALSE)
redisCmd("flushall")


redisSet("num1", 100)


redisGet("num1")


redisSet("vec1", 1:5)
redisGet("vec1")


redisSet("mtcars_head", head(mtcars, 3))
redisGet("mtcars_head")


redisGet("something")


redisExists("something")
redisExists("num1")


redisDelete("num1")
redisExists("num1")


redisHSet("fruits", "apple", 5)
redisHSet("fruits", "pear", 2)
redisHSet("fruits", "banana", 9)


redisHGet("fruits", "banana")


redisHGetAll("fruits")


redisHKeys("fruits")


redisHVals("fruits")


redisHLen("fruits")


redisHMGet("fruits", c("apple", "banana"))


redisHMSet("fruits", list(apple = 4, pear = 1))


redisHGetAll("fruits")


for (qi in 1:3) {
  redisRPush("queue", qi)  
}


redisLLen("queue")


redisLPop("queue")
redisLPop("queue")
redisLPop("queue")
redisLPop("queue")


redisClose()


