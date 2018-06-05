## Interactive Visualizations with RStudio

### Instructions:

To run the code, you have two options.

### 1) RStudio Cloud

I **highly** recommend using RStudio Cloud for workshop materials. 

If you have an RStudio Cloud account, click this link (and you're done): <>

If you don't have an account yet, you can sign up for a free account [https://rstudio.cloud](https://rstudio.cloud/).

If you already have a [shinyapps.io](https://shinyapps.io) account, you can use those credentials instead. It's that easy.

### 2) Run R/RStudio Locally

You can also run the code locally. 

To do so, you will need to download [R](http://archive.linux.duke.edu/cran/) and [R Studio](https://www.rstudio.com/products/rstudio/download/) locally. 

Next, you'll need to download the GitHub repo through the Clone or Download button.

If you have Git setup on your computer, you can clone the repo into your current directory.

```{bash}
git clone https://github.com/wesslen/iviz-rstudio-workshop.git
```

If you run this option, you will need to make sure you have all the R libraries installed locally.

```{r}
pck <- c("tidyverse","plotly","shiny","leaflet","dygraphs",
         "xts","igraph","visNetwork","tidytext","collapsibleTree","shinydashboard")
install.packages(pck)

pck2 <- c("devtools", "digest", "htmltools", "htmlwidgets", 
          "jsonlite", "Rcpp", "rstudioapi", "yaml")
install.packages(pck2)
devtools::install_github("rstudio/r2d3")
```

### FYI: Installing github packages in RStudio Cloud

Unfortunately, RStudio Cloud does not automatically download dependent packags from CRAN, especially if its from a GitHub repo (it's still in alpha). 

For most times, I've found it's important to set first while using RStudio Cloud.

```{r}
options(repos = "https://cran.rstudio.com/" )
```

#### r2d3

As an example, r2d3 requires several dependency packages.

```{r}
options(repos = "https://cran.rstudio.com/" )
pck <- c("devtools", "digest", "htmltools", "htmlwidgets", "jsonlite", "Rcpp", "rstudioapi", "yaml")
install.packages(pck)
devtools::install_github("rstudio/r2d3")
```