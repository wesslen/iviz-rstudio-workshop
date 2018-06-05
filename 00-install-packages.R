# run only first time on RStudio Cloud or locally
options(repos = "https://cran.rstudio.com/" )

pck1 <- c("tidyverse","plotly","shiny","leaflet","dygraphs","flexdashboard","ggridges",
          "xts","igraph","visNetwork","tidytext","collapsibleTree","shinydashboard")

install.packages(pck1)

pck2 <- c("devtools","digest","htmltools","htmlwidgets",
          "jsonlite","Rcpp","rstudioapi","yaml")

install.packages(pck2)

devtools::install_github("rstudio/r2d3")