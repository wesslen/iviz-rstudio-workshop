# https://rstudio.github.io/profvis/index.html

library(profvis)
library(shiny)
profvis({
  runExample(example = "06_tabsets", display.mode = "normal")
})