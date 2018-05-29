# pre-processing (i.e., only need to run once)
library(shiny); library(plotly); library(tidyverse); library(stringr)

url <- "http://nodeassets.nbcnews.com/russian-twitter-trolls/tweets.csv"
tweets <- read_csv(url)

# ui
ui <- fluidPage(
  
  titlePanel("Russian Trolls Keyword Search"),
  
  sidebarLayout(
    sidebarPanel(
      textInput("term", "Provide Text", placeholder = "obama (example)"),
      actionButton("go", "Run")
    ),
    
    mainPanel(
      plotlyOutput("plot"),
      verbatimTextOutput("hover"),
      verbatimTextOutput("click"),
      verbatimTextOutput("brush")
    )
  )
)  


# server

server <- function(input, output) {
  
  #reactive event that runs only when the button is hit
  df <- eventReactive(input$go, { 
    tweets %>%
      filter(str_detect(tolower(tweets$text), input$term)) %>% # replace with input
      group_by(Date = as.Date(created_str)) %>%
      summarise(Count=n())
  })
  
  # render plotly can take a ggplot object (or plot_ly native object)
  output$plot <- renderPlotly({
    df() %>% # since reactive, need ()'s!
    ggplot(aes(x = Date, y = Count)) + 
      geom_line() +
      labs(title = paste0("Tweets filtered by `",input$term,"`"),
           x = "Day",
           y = "Number of Tweets")
  })
  
  output$hover <- renderPrint({
    d <- event_data("plotly_hover")
    if (is.null(d)) "Hover events appear here (unhover to clear)" else d
  })
  
  output$click <- renderPrint({
    d <- event_data("plotly_click")
    if (is.null(d)) "Click events appear here (unhover to clear)" else d
  })
  
  output$brush <- renderPrint({
    d <- event_data("plotly_brush")
    if (is.null(d)) "Brush events appear here (unhover to clear)" else d
  })
  
}

shinyApp(ui, server)

# shinyApp(ui, server, options = list(display.mode = "showcase"))