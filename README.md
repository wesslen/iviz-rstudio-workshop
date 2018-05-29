## Interactive Visualizations with RStudio

### RStudio Cloud

I recommend using RStudio Cloud for workshop materials. 

You can sign up for a free account [https://rstudio.cloud](https://rstudio.cloud/).

Note, if you already have a [shinyapps.io](https://shinyapps.io) account, you can use those credentials.

Alternatively, you can download [R](http://archive.linux.duke.edu/cran/) and [R Studio](https://www.rstudio.com/products/rstudio/download/) locally. Then you can download the GitHub repo through the Clone or Download button.

If you have Git setup on your computer, you can type the following to install in your current directory.

```{bash}
git clone https://github.com/wesslen/iviz-rstudio-workshop.git
```

### Instructions

To get started, log onto RStudio Cloud, then click the arrow on the "New Project" and select "New Project from Git Repo."

Then, enter this GitHub repo's path (https://github.com/wesslen/iviz-rstudio-workshop) and click enter. You're now ready to go! (It's that easy.)

### Installing github packages in RStudio Cloud

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
