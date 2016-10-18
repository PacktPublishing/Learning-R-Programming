install.packages("rvest")


library(rvest)
single_table_page <- read_html("data/single-table.html")
single_table_page


html_table(single_table_page)


html_table(html_node(single_table_page, "table"))


single_table_page %>%
  html_node("table") %>%
  html_table()


products_page <- read_html("data/products.html")
products_page %>%
  html_nodes(".product-list li .name")


products_page %>%
  html_nodes(".product-list li .name") %>%
  html_text()


products_page %>%
  html_nodes(".product-list li .price") %>%
  html_text()


product_items <- products_page %>%
  html_nodes(".product-list li")
products <- data.frame(
  name = product_items %>%
    html_nodes(".name") %>%
    html_text(),
  price = product_items %>%
    html_nodes(".price") %>%
    html_text() %>%
    gsub("$", "", ., fixed = TRUE) %>%
    as.numeric(),
  stringsAsFactors = FALSE
)
products




page <- read_html("data/new-products.html")


page %>% html_nodes(xpath = "//p")


page %>% html_nodes(xpath = "//li[@class]")


page %>% html_nodes(xpath = "//div[@id='list']/ul/li")


page %>% html_nodes(xpath = "//div[@id='list']//li/span[@class='name']")


page %>%
  html_nodes(xpath = "//li[@class='selected']/span[@class='name']")


page %>% html_nodes(xpath = "//div[p]")


page %>% 
  html_nodes(xpath = "//span[@class='info-value' and text()='Good']")


page %>%
  html_nodes(xpath = "//li[div/ul/li[1]/span[@class='info-value' and text()='Good']]/span[@class='name']")


page %>%
  html_nodes(xpath = "//li[div/ul/li[2]/span[@class='info-value' and text()>3]]/span[@class='name']")








page <- read_html("https://cran.rstudio.com/web/packages/available_packages_by_name.html")
pkg_table <- page %>%
  html_node("table") %>% 
  html_table(fill = TRUE)
head(pkg_table, 5)


pkg_table <- pkg_table[complete.cases(pkg_table), ]
colnames(pkg_table) <- c("name", "title")
head(pkg_table, 3)




page <- read_html("https://finance.yahoo.com/quote/MSFT")
page %>%
  html_node("div#quote-header-info > section > span") %>%
  html_text() %>%
  as.numeric()






page %>%
  html_node("#key-statistics table") %>%
  html_table()


get_price <- function(symbol) {
  page <- read_html(sprintf("https://finance.yahoo.com/quote/%s", symbol))
  list(symbol = symbol,
    company = page %>% 
      html_node("div#quote-header-info > div:nth-child(1) > h6") %>%
      html_text(),
    price = page %>% 
      html_node("div#quote-header-info > section > span:nth-child(1)") %>%
      html_text() %>%
      as.numeric())
}


get_price("AAPL")




page <- read_html("https://stackoverflow.com/questions/tagged/r?sort=votes&pageSize=5")
questions <- page %>% 
  html_node("#questions")




questions %>%
  html_nodes(".summary h3") %>%
  html_text()


questions %>%
  html_nodes(".question-hyperlink") %>%
  html_text()




questions %>%
  html_nodes(".question-summary .vote-count-post") %>%
  html_text() %>%
  as.integer()


questions %>%
  html_nodes(".question-summary .status strong") %>%
  html_text() %>%
  as.integer()


questions %>%
  html_nodes(".question-summary .tags") %>%
  lapply(function(node) {
    node %>%
      html_nodes(".post-tag") %>%
      html_text()
  }) %>%
  str




questions %>%
  html_nodes(".question-hyperlink") %>%
  html_attr("href") %>%
  lapply(function(link) {
    paste0("https://stackoverflow.com", link) %>%
      read_html() %>%
      html_node("#qinfo") %>%
      html_table() %>%
      setNames(c("item", "value"))
  })
