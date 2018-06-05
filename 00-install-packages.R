# options(repos = "https://cran.rstudio.com/" )

# run only first time on RStudio Cloud or locally
# function to efficiently install packages
ipak <- function(pkg){
  new.pkg <- pkg[!(pkg %in% installed.packages()[, "Package"])]
  if (length(new.pkg)) 
    install.packages(new.pkg, dependencies = TRUE)
  sapply(pkg, require, character.only = TRUE)
}

packages <- c("tidyverse","plotly","shiny","leaflet","dygraphs","flexdashboard","ggridges",
              "xts","igraph","visNetwork","tidytext","collapsibleTree","shinydashboard",
              "devtools","digest","htmltools","htmlwidgets", "jsonlite","Rcpp","rstudioapi","yaml")

ipak(packages)

devtools::install_github("rstudio/r2d3")