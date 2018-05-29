## iviz-rstudio-workshop


### Installing github packages in RStudio Cloud

Unfortunately, RStudio Cloud does not automatically download dependent packags from CRAN (it's still in alpha). 

#### ggplot2 dev (needed for Plotly + ggplot2)

```{r}
devtools::install_github("hadley/assertthat")
source("https://install-github.me/r-lib/cli")

packages <- c("cli")

```