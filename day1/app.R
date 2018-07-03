# let's deploy this to shinyapps.io: click the blue button in the top right of this box

# exercise 1: add a new slider that sets the number of breaks for the rnorm() function
# exercise 2: add a textInput() that sets the name of the plot
# exercise 3: add a actionButton() that updates the name of the plot (part 2) only when clicking; see ?observeEvent

library(shiny)

ui <- fluidPage(
  
  sidebarLayout(
    
    sidebarPanel(
      sliderInput(inputId = "num",
                  label = "Choose a number",
                  value = 25, min = 1, max = 100)
    ),
    
    mainPanel(
      plotOutput("hist")
    )
  ) 
)

server <- function(input, output) {
  
  output$hist <- renderPlot({
    title <- "100 random normal values"
    hist(rnorm(input$num), breaks = input$num, 
         main = title)
  })
  
}

shinyApp(ui = ui, server = server)