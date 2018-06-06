# Interactive Visualizations with RStudio

In this three-part workshop series, we’ll use RStudio tools like tidyverse, Shiny, and htmlwidgets to develop interactive visualizations. 

## Sponsored by 

* [UNC Charlotte Data Science Initiative](https://dsi.uncc.edu/)

## Date, Time and Location

* July X (Part 1), July X (Part 2), and July X (Part 3) 

* XX:XX pm - XX:XX pm

* XXX
 
## Instructor

* [Ryan Wesslen](http://wesslen.github.io)

## Workshop Overview

### Part 1: Intro to Shiny and tidyverse

We’ll introduce [**RStudio**](https://www.rstudio.com/products/RStudio/) along with [`tidyverse`](https://www.tidyverse.org/), a unified set of R packages for end-to-end data science. These packages include core data science workflow tools for data acquisition, processing and visualization. We’ll end with an introduction to [**Shiny**](http://shiny.rstudio.com/), an R package for building interactive web apps. Shiny apps are flexible web applications that can be embedded within web pages, dashboards, and [**RMarkdown**](https://rmarkdown.rstudio.com/) output like presentations or notebooks. 

| Day 1: Wed July XX  | Intro to tidyverse and Shiny |
| ------------------- | ------------------------------------------------------- |
| Welcome             | [PollEverywhere](https://pollev.com/ryanwesslen365) and This GitHub Page |
| Lecture             | [Introduction to Tidyverse](./slides/00-Tidyverse-webinar.pdf) |
| Hands On Tutorial   | [tidyverse code](./01-russian-trolls.R) / [HTML](http://rpubs.com/ryanwesslen/iviz-workshop1)   |
| Lecture   | [Introduction to Shiny](./slides/intro-to-shiny.pdf) |
| Hands On Tutorial   | Shiny Hello World and Deploying to shinyapps.io |
| Hands On Assignment | [Day 1 Assignment](./assignments/day1.R) |

### Part 2: Shiny and htmlwidgets

We’ll dive deeper into Shiny apps and review basic architecture, layouts, and reactions using simple, hands-on examples. We’ll also introduce [**htmlwidgets**](http://www.htmlwidgets.org/) (e.g., plotly, r2d3, leaflet), simple R packages for producing HTML-based interactive visualizations that can be extended with HTML, CSS, and JavaScript. In this part, we’ll explore basic exploratory data analysis visualizations (line, bar, scatterplots) as well as how to visualize important aspects of social media data like social networks, unstructured text, and geospatial data.

| Day 2: Wed July XX  | Shiny and htmlwidgets    |
| ------------------- | ------------------------------------------------------- |
| Refresher & Warm-up | [PollEverywhere](https://pollev.com/ryanwesslen365) and [Russian Trolls Text Search App](./02-shinyapp/app.R) |
| Lecture             | [Intermediate Shiny](./slides/02-shiny.pdf) |
| Hands On Tutorial   | [input/output code](./02-input-outputs.R) / [HTML](http://rpubs.com/ryanwesslen/iviz-workshop2)   |
| Demo / Website   | [htmlwidgets](https://www.htmlwidgets.org/) |
| Hands On Tutorial   | [htmlwidget code](./02-htmlwidgets.R) / [HTML](http://rpubs.com/ryanwesslen/iviz-workshop3)   |
| Hands On Assignment | [Day 2 Assignment](./assignments/day2.R) |

### Part 3: Advanced Shiny

We’ll consider more advanced layout templates like [shinydashboard](https://rstudio.github.io/shinydashboard/) to provide professional looking dashboard templates. We’ll also explore advanced Shiny functionality including interactions, persistent storage, and deploying apps publicly on [shinyapps.io](https://www.shinyapps.io/).


| Day 3: Wed July XX  | Advanced Shiny            |
| ------------------- | ------------------------------------------------------- |
| Warm-up             | [PollEverywhere](https://pollev.com/ryanwesslen365) |
| Lecture             | [Templates: shinydashboard and flexdashboard](./slides/03-shiny.pdf) |
| Hands On Tutorial   | [shinydashboard code](./04-templates.R) / [HTML](http://rpubs.com/ryanwesslen/iviz-workshop4)   |
| Lecture             | [Interactions, Persistent Storage, and In Production](./slides/03-shiny.pdf) |
| Present Projects | Students present their Shiny systems. |

## Instructions:

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

### Installing packages

After getting RStudio set up, it's easier if you install the R libraries first (first set take about 3.5 minutes on cloud, second take about 30 seconds).

Run the file `00-install-packages.R`.

It runs this code:

```{r}
packages <- c("tidyverse","plotly","shiny","leaflet","dygraphs","flexdashboard","ggridges",
              "xts","igraph","visNetwork","tidytext","collapsibleTree","shinydashboard")
install.packages(packages)

# for r2d3 install
packages2 <- c("devtools","digest","htmltools","htmlwidgets", "jsonlite","Rcpp","rstudioapi","yaml")
install.packages(packages2)

devtools::install_github("rstudio/r2d3")
```

## Resources

### Help! 

This page is your best source for R help: <https://wesslen.github.io/fall2017-rworkshops/help.html>

Please read if you run into R-relate problems.

### Tidyverse / Intro to R:

These resources are a best place to learn the basics. Traditionally, R was taught on the core (or "Base") R packages. More recently, tidyverse has become the modern approach to learning R.

I **highly** recommend the first book for anyone wanting to learn R (and applying Data Science).

* R for Data Science Book: <http://r4ds.had.co.nz/>
* Tidyverse: <https://www.tidyverse.org/>
* ggplot2: <http://ggplot2.tidyverse.org/>
* dplyr: <http://dplyr.tidyverse.org/>
* tidyr: <http://tidyr.tidyverse.org/>
* tidyquant: <https://business-science.github.io/tidyquant/>
* tidytext: <https://www.tidytextmining.com/>
* R Studio Community (for help): <https://community.rstudio.com/>

### DataCamp recommended courses:

Free courses (no reason why not):

* R Basics: <https://www.datacamp.com/courses/free-introduction-to-r>
* Git: <https://www.datacamp.com/courses/introduction-to-git-for-data-science>
* Intro to Python for Data Science: <https://www.datacamp.com/courses/intro-to-python-for-data-science>
* All other “open” courses: <https://www.datacamp.com/community/open-courses>

DataCamp has courses not just on R but Python, Git, and SQL.

Premium Courses (require paying after first chapter)

* Data Manipulation for R Track: <https://www.datacamp.com/tracks/data-manipulation-with-r>
* Data Visualization for R Track: <https://www.datacamp.com/tracks/data-visualization-with-r>
* Statistics with R: <https://www.datacamp.com/tracks/statistics-with-r>
* Machine Learning in R: <https://www.datacamp.com/tracks/machine-learning>

### R Studio Open Source (GitHub) Workshop Materials

R Studio::conf Workshops:

* <https://github.com/cwickham/data-science-in-tidyverse>
* <https://github.com/jcheng5/shiny-training-rstudioconf-2018>
* <https://github.com/rstudio-education/intro-shiny-rmarkdown>
* <https://github.com/AmeliaMN/IntroToR>

R Studio Webinars

* <https://github.com/rstudio/webinars>

### R Markdown / Shiny 

Visualizations are critically important to any analysis. R includes helpful packages to enable advanced HTML visualizations (e.g., JavaScript, D3, VegaLite) with only knowing R!! 

#### Shiny

Shiny is the most important tool that enables full visualization systems. These can be run "locally" (i.e., on your own computer but only you can access) or on a server to deploy on the internet (e.g., anyone can reach the site). Typically, most people do not have a server at their disposal so the fastest way to deploy a Shiny app is through R Studio's Shinyapps.io free account. 

* Shiny (Interactive Visualizations): <http://shiny.rstudio.com/>
* Gallery: <http://shiny.rstudio.com/gallery/>
* Tutorial (Basics): <http://shiny.rstudio.com/articles/basics.html>
* Tutorial (Intermediate): <http://shiny.rstudio.com/articles/app-formats.html>
* Tutorial (Deployment): <http://shiny.rstudio.com/articles/deployment-web.html>
* Where to deploy test Shiny Apps: <http://www.shinyapps.io/>

#### R Markdown

[R Markdown](http://rmarkdown.rstudio.com/) is an example of [literate programming](https://en.wikipedia.org/wiki/Literate_programming), i.e., code combined with plain language (as well as code output). The output can be an HTML, pdf, or even a Word document!

R Markdown can do nearly anything -- build a website, write a LaTeX paper for publication, even write a book! (For example, <http://r4ds.had.co.nz/> is written in R Markdown. See the [GitHub](https://github.com/hadley/r4ds).)

* Gallery: <http://rmarkdown.rstudio.com/gallery.html>
* Tutorial (Intro): <http://rmarkdown.rstudio.com/articles_intro.html>

Flexdashboard: <http://rmarkdown.rstudio.com/flexdashboard/>

* Gallery: <http://rmarkdown.rstudio.com/flexdashboard/examples.html>
* Tutorial (Intro): <http://rmarkdown.rstudio.com/flexdashboard/using.html>
* Tutorial (use with Shiny): <http://rmarkdown.rstudio.com/flexdashboard/shiny.html>

HTML Widgets (Javascript extensions in R): <http://www.htmlwidgets.org/>

* Gallery: <http://www.htmlwidgets.org/showcase_leaflet.html>