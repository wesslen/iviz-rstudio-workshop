## app.R ## see https://rstudio.github.io/shinydashboard/get_started.html
library(shinydashboard)

# load in data, these are preliminary steps
library(tidyverse)

months <- c("Jan","Feb","Mar",
            "Apr","May","Jun",
            "Jul","Aug","Sep",
            "Oct","Nov","Dec")

# read in and clean up fields
df <- read_csv("../data/cleaned-stops.csv") %>%
  mutate(Month = forcats::fct_relevel(Month, months),
         Year = as.character(Year),
         DriverRace = case_when(
           Driver_Ethnicity == "Hispanic" ~ "Hispanic",
           Driver_Race %in% c("White", "Black", "Asian") ~ Driver_Race,
           TRUE ~ "Other"
         ),
         OfficerRace = case_when(
           Officer_Race == "Hispanic/Latino" ~ "Hispanic",
           Officer_Race == "Black/African American" ~ "Black",
           Officer_Race == "White" ~ "White",
           Officer_Race == "Asian / Pacific Islander" ~ "Asian",
           TRUE ~ "Other")
  ) %>%
  select(-Driver_Ethnicity, -Driver_Race, -Officer_Race)

#### UI

ui <- dashboardPage(
  dashboardHeader(title = "Charlotte Police Stops"),
  dashboardSidebar(
    menuItem("Dashboard", tabName = "dashboard", icon = icon("dashboard"))
  ),
  dashboardBody(
    tabItems(
      # First tab content
      tabItem(tabName = "dashboard",
        # Boxes need to be put in a row (or column)
        fluidRow(
          box(
            title = "Controls",
            selectInput('reason', 
                        'Reason For Stop', 
                        c(All = ".", unique(df$Reason_for_Stop)))
          ),
          box(plotOutput("plot1", height = 250))
        )
      )
    )
  )
)

#### Server
server <- function(input, output) {
  output$plot1 <- renderPlot({
    
    # yield full df if All selected; or filter
    if(input$reason == "."){
      z <- df
    } else {
      z <- filter(df, Reason_for_Stop == input$reason)
    }
    
    z %>%
      count(Month, Year) %>%
      ggplot(aes(x = Month, y = n, color = Year, group = Year)) +
      geom_point() +
      geom_line()
  })
}

shinyApp(ui, server)