# run only first time on RStudio Cloud or locally
options(repos = "https://cran.rstudio.com/" )

pck <- c("tidyverse","plotly","shiny","leaflet","dygraphs","flexdashboard","ggridges",
         "xts","igraph","visNetwork","tidytext","collapsibleTree","shinydashboard", 
         "devtools","digest","htmltools","htmlwidgets","jsonlite","Rcpp","rstudioapi","yaml")
install.packages(pck)

devtools::install_github("rstudio/r2d3")