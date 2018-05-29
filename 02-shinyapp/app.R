# pre-processing (i.e., only need to run once)
library(shiny); library(plotly); library(tidyverse)

url <- "http://nodeassets.nbcnews.com/russian-twitter-trolls/tweets.csv"
tweets <- read_csv(url)

# ui

ui <- fluidPage(
  inputPanel(
    textInput("term", "Provide Text", value = "obama (example)"),
    actionButton("go", "Run")
  ),
  plotlyOutput("plot")
)

# server

server <- function(input, output) {
  
  #reactive event that runs only when the button is hit
  df <- reactiveEvent(input$go, { 
    tweets %>%
      filter(str_detect(tolower(input$term), term)) %>% # replace with input
      group_by(Date = as.Date(created_str)) %>%
      summarise(Count=n())
  })
  
  # render plotly can take a ggplot object (or plot_ly native object)
  output$plot <- renderPlotly({
    df() %>% # since reactive, need ()'s!
    ggplot(aes(x = Date, y = Count)) + 
      geom_line() +
      labs(title = paste0("Tweets filtered by `",term,"`"),
           x = "Day",
           y = "Number of Tweets")
  })
  
}

shinyApp(ui, server)