n <- 100
x <- rnorm(n)
y <- 2 * x + rnorm(n)
m <- lm(y ~ x)
coef(m)

toys <- data.frame(
  id = 1:3,
  name = c("Car", "Plane", "Motocycle"),
  price = c(15, 25, 14),
  share = c(0.3, 0.1, 0.2),
  stringsAsFactors = FALSE
)


toys


knitr::kable(toys)


xtable::xtable(lm(mpg ~ cyl + vs, data = mtcars))




library(formattable)
formattable(toys, 
  list(price = color_bar("lightpink"), share = percent))




library(DT)
datatable(mtcars)




set.seed(123)
x <- rnorm(1000)
y <- 2 * x + rnorm(1000)
m <- lm(y ~ x)
plot(x, y, main = "Linear regression", col = "darkgray")
abline(coef(m))


library(DiagrammeR)
grViz("
digraph rmarkdown {
  A -> B;
  B -> C;
  C -> A;
}")




library(ggvis)
mtcars %>% 
  ggvis(~mpg, ~disp, opacity := 0.6) %>% 
  layer_points(size := input_slider(1, 100, value = 50, label = "size")) %>%
  layer_smooths(span = input_slider(0.5, 1, value = 1, label = "span"))




library(dygraphs)
library(xts)
library(dplyr)
library(reshape2)
data(weather, package = "nycflights13")
temp <- weather %>%
  group_by(origin, year, month, day) %>%
  summarize(temp = mean(temp)) %>%
  ungroup() %>%
  mutate(date = as.Date(sprintf("%d-%02d-%02d", year, month, day))) %>%
  select(origin, date, temp) %>%
  dcast(date ~ origin, value.var = "temp")

temp_xts <- as.xts(temp[-1], order.by = temp[[1]])
head(temp_xts)


dygraph(temp_xts, main = "Airport Temperature") %>%
  dyRangeSelector() %>%
  dyHighlight(highlightCircleSize = 3, 
    highlightSeriesBackgroundAlpha = 0.3,
    hideOnMouseOut = FALSE)




library(shiny)

ui <- bootstrapPage(
  numericInput("n", label = "Sample size", value = 10, min = 10, max = 100),
  textOutput("mean")
)

server <- function(input, output) {
  output$mean <- renderText(mean(rnorm(input$n)))
}

app <- shinyApp(ui, server)
runApp(app)




shiny_vars <- ls(getNamespace("shiny"))
shiny_vars[grep("Input$", shiny_vars)]


shiny_vars[grep("Output$", shiny_vars)]


library(shiny)
ui <- fluidPage(
  titlePanel("Random walk"),
  sidebarLayout(
    sidebarPanel(
      numericInput("seed", "Random seed", 123),
      sliderInput("paths", "Paths", 1, 100, 1),
      sliderInput("start", "Starting value", 1, 10, 1, 1),
      sliderInput("r", "Expected return", -0.1, 0.1, 0, 0.001),
      sliderInput("sigma", "Sigma", 0.001, 1, 0.01, 0.001),
      sliderInput("periods", "Periods", 10, 1000, 200, 10)),
  mainPanel(
    plotOutput("plot", width = "100%", height = "600px")
  ))
)


shiny_vars[grep("^render", shiny_vars)]


server <- function(input, output) {
  output$plot <- renderPlot({
    set.seed(input$seed)
    mat <- sapply(seq_len(input$paths), function(i) {
      sde::GBM(input$start, input$r, input$sigma, 1, input$periods)
    })
    matplot(mat, type = "l", lty = 1,
      main = "Geometric Brownian motions")
  })
}


app <- shinyApp(ui, server)
runApp(app)






install_packages(c("shinydashboard", "cranlogs"))


library(cranlogs)
cran_top_downloads()
cran_top_downloads("last-week")


library(shiny)
library(shinydashboard)
library(formattable)
library(cranlogs)

ui <- dashboardPage(
  dashboardHeader(title = "CRAN Downloads"),
  dashboardSidebar(sidebarMenu(
    menuItem("Last week", tabName = "last_week", icon = icon("list")),
    menuItem("Last month", tabName = "last_month", icon = icon("list"))
  )),
  dashboardBody(tabItems(
    tabItem(tabName = "last_week", 
      fluidRow(tabBox(title = "Total downloads",
        tabPanel("Total", formattableOutput("last_week_table"))),
        tabBox(title = "Top downloads",
          tabPanel("Top", formattableOutput("last_week_top_table"))))),
    tabItem(tabName = "last_month", 
      fluidRow(tabBox(title = "Total downloads",
        tabPanel("Total", plotOutput("last_month_barplot"))),
        tabBox(title = "Top downloads",
          tabPanel("Top", formattableOutput("last_month_top_table")))))
  ))
)


server <- function(input, output) {
  output$last_week_table <- renderFormattable({
    data <- cran_downloads(when = "last-week")
    formattable(data, list(count = color_bar("lightblue")))
  })
  
  output$last_week_top_table <- renderFormattable({
    data <- cran_top_downloads("last-week")
    formattable(data, list(count = color_bar("lightblue"),
      package = formatter("span", style = "font-family: monospace;")))
  })
  
  output$last_month_barplot <- renderPlot({
    data <- subset(cran_downloads(when = "last-month"), count > 0)
    with(data, barplot(count, names.arg = date),
      main = "Last month downloads")
  })
  
  output$last_month_top_table <- renderFormattable({
    data <- cran_top_downloads("last-month")
    formattable(data, list(count = color_bar("lightblue"),
      package = formatter("span", style = "font-family: monospace;")))
  })
}


runApp(shinyApp(ui, server))
