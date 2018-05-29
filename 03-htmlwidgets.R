
# call tidyverse -- if you get an error, do you have tidyverse installed??
library(tidyverse)

# load tweets

# If you don't have the file, you can load it directly from GitHub
file <- "https://github.com/wesslen/summer-2017-social-media-workshop/raw/master/data/CharlotteTweets20Sample.csv"

tweets <- read_csv(file)

## spatial / leaflet 
## https://rstudio.github.io/leaflet/
# install.packages("leaflet")
library(leaflet)

query <- "beer"

t <- tweets %>%
  filter(stringr::str_detect(tweets$body, query)) %>%
  filter(!is.na(point_long))

leaflet(t) %>%
  addTiles() %>%
  addCircleMarkers(lng=t$point_lat, 
                   lat=t$point_long,
                   popup = t$body, 
                   stroke = FALSE, 
                   fillOpacity = 0.5, 
                   radius = 10, 
                   clusterOptions = markerClusterOptions())


## time series (dygraph)
## http://rstudio.github.io/dygraphs/index.html
# install.packages("dygraphs")

library(dygraphs); library(xts)

counts <- tweets %>%
  mutate(Date = as.Date(postedTime)) %>%
  group_by(Date, geo.type) %>%
  summarise(Count = n()) %>%
  ungroup() %>%
  spread(geo.type, Count, fill = 0, convert = T)
  
dailyCounts <- xts(
  x = counts[,-1],
  order.by = counts$Date
)

# can convert to weekly, monthly, yearly, etc
weeklyCounts <- apply.weekly(dailyCounts, colSums)

z <- dygraph(dailyCounts, main = "Charlotte Geo-located Tweets") %>% 
  dyRangeSelector() %>%
  
z %>% 
  dyEvent("2016-02-08", "Super Bowl") %>%
  dyEvent("2016-01-25", "NFC Championship")

## visNetwork http://datastorm-open.github.io/visNetwork/
# install.packages("visNetwork")

# install.packages("igraph")
library(igraph)

# regular expression -- get only tweets that have "RT @"
rts <- filter(tweets, stringr::str_detect(tweets$text, "RT @"))

names <- unique(rts$user_key)

edges <- tibble(node1 = rts$user_key, 
                node2 = gsub('.*RT @([a-zA-Z0-9_]+):? ?.*', rts$text, repl="\\1")) %>%
  filter(node1 %in% names & node2 %in% names) %>%
  group_by(node1, node2) %>%
  summarise(weights = n())

g <- graph_from_data_frame(d=edges, directed=TRUE)

library(visNetwork)

visIgraph(g) %>% 
  visInteraction(navigationButtons = TRUE)

#### Advanced

## r2d3 (https://rstudio.github.io/r2d3/)

## if running in Rstudio cloud, need to run statement before as doesn't auto install
# pck <- c("devtools", "digest", "htmltools", "htmlwidgets", "jsonlite", "Rcpp", "rstudioapi", "yaml")
# install.packages(pck)
# devtools::install_github("rstudio/r2d3")
library(r2d3)

flare <- read.csv("./d3/flare.csv")

# bubbles
r2d3(data = flare, d3_version = 4, script = "./d3/bubbles.js")

# radial tree (includes radialtree.css)
r2d3(data = flare, d3_version = 4, script = "./d3/radialtree.js")

# circlepacking (includes circlepacking.css)
r2d3(data = jsonlite::read_json("./d3/flare.json"), d3_version = 4, script = "./d3/circlepacking.js")

# streamgraph on random data
r2d3(data=c(), script = "./d3/streamgraph.js")

# many more; see https://rstudio.github.io/r2d3/articles/gallery.html

## collapsible Tree (https://adeelk93.github.io/collapsibleTree/)
# install.packages("collapsibleTree")
library(collapsibleTree)

# prep data
flare2 <- flare %>%
  mutate(id = as.character(id)) %>%
  separate(id, into = c("First","Second","Third","Fourth"))

collapsibleTree(
  flare2,
  hierarchy = c("First", "Second", "Third", "Fourth"),
  width = 800,
  zoomable = TRUE
)
