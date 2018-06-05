# options(repos = "https://cran.rstudio.com/" )
packages <- c("tidyverse","plotly","shiny","leaflet","dygraphs","flexdashboard","ggridges",
              "xts","igraph","visNetwork","tidytext","collapsibleTree","shinydashboard")

install.packages(packages)

packages2 <- c("devtools","digest","htmltools","htmlwidgets", "jsonlite","Rcpp","rstudioapi","yaml")

install.packages(packages2)

devtools::install_github("rstudio/r2d3")