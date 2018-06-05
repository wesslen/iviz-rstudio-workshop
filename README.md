## Interactive Visualizations with RStudio

### Instructions:

To run the code, you have two options.

### 1) RStudio Cloud

I **highly** recommend using RStudio Cloud for workshop materials. 

If you don't have an account yet, you can sign up for a free account [https://rstudio.cloud](https://rstudio.cloud/). If you already have a [shinyapps.io](https://shinyapps.io) account, you can use those credentials instead.

If that links doesn't work, you can create a new project from a GitHub repo, copy/paste 

```{bash}
https://github.com/wesslen/iviz-rstudio-workshop.git
```

and click enter. If you go this route, proceed to install the packages as described below.

### 2) Run R/RStudio Locally

You can also run the code locally. 

1. You will need to download [R](http://archive.linux.duke.edu/cran/) and [R Studio](https://www.rstudio.com/products/rstudio/download/) locally. 

2. You'll need to download the GitHub repo through the Clone or Download button.

If you have Git setup on your computer, you can clone the repo into your current directory.

```{bash}
git clone https://github.com/wesslen/iviz-rstudio-workshop.git
```

3. Open the file `project.Rproj` in RStudio. 

## Installing packages

After getting RStudio set up, it's easier if you install the R libraries first (first set take about 3.5 minutes on cloud, second take about 30 seconds).

Run the file `00-install-packages.R`.

It simply runs this code:

```{r}
pck <- c("tidyverse","plotly","shiny","leaflet","dygraphs","flexdashboard","ggridges",
         "xts","igraph","visNetwork","tidytext","collapsibleTree","shinydashboard",
         "devtools","digest","htmltools","htmlwidgets","jsonlite",
         "Rcpp","rstudioapi","yaml")
install.packages(pck)
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