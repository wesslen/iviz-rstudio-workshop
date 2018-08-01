# 10% sample version

library(shiny)
source("app-prep.R")
# quanteda_options("threads" = 8)

# ui
ui <- fluidPage(
    dygraphOutput("dygraph"),
    tags$hr(), # add horizontal line
    fluidRow(
        column(sliderInput("num", "Number of words", min = 10, max = 100, value = 50, step = 5), 
               checkboxInput("retweet", "Exclude Retweets", value = FALSE),
               width = 3),
        column(plotOutput("network"), width = 9)
        )
)

# server
server <- function(input, output) {
    
    output$dygraph <- renderDygraph({
        dygraph(tweet.time,  main = "Charlotte Protest Tweet Counts (10% Sample)", group = "combine") %>%
            dyLegend(show = "onmouseover") %>%
            dyOptions(colors = RColorBrewer::brewer.pal(8, "Dark2"), includeZero = TRUE) %>%
            dyAxis("x", drawGrid = FALSE) %>%
            dyOptions(useDataTimezone = TRUE) %>%
            dyRangeSelector() %>%
            dyShading(from = "2016-09-20 21:00:00", to = "2016-09-21 03:00:00") %>%
            dyShading(from = "2016-09-21 20:00:00", to = "2016-09-22 03:00:00") 
    })

    output$network <- renderPlot({
        if (!is.null(input$dygraph_date_window)) {
            minTime <- input$dygraph_date_window[[1]]
            maxTime <- input$dygraph_date_window[[2]]
        } else {
            minTime <- min(protestData$time)
            maxTime <- max(protestData$time)
        }
        
        if (input$retweet){
            dfm <- dfmAll %>%
                dfm_subset(time >= minTime & time <= maxTime & verb == "post")
        } else {
            dfm <- dfmAll %>%
                dfm_subset(time >= minTime & time <= maxTime)
        }
        
        topFeatures <- names(topfeatures(dfm, input$num))
        
        fcm(dfm) %>%
            fcm_select(topFeatures) %>% # ensure network isn't too large
            textplot_network(min_freq = 0.1, edge_alpha = 0.8, edge_size = 1)
    })
}

# Run the application 
shinyApp(ui = ui, server = server)