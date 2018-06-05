# run for RStudio.Cloud
options(repos = "https://cran.rstudio.com/" )

# call tidyverse -- if you get an error, do you have tidyverse installed??
library(tidyverse)

# file name
file <- "./data/CharlotteTweets20Sample.csv"
tweets <- read_csv(file)

## spatial / leaflet, see https://rstudio.github.io/leaflet/
# install.packages("leaflet")
library(leaflet); library(stringr)

query <- "beer"

beerTweets <- tweets %>%
  filter(str_detect(tweets$body, query)) %>%
  filter(!is.na(point_long))

leaflet(beerTweets) %>%
  addTiles() %>%
  addCircleMarkers(lng=beerTweets$point_lat, 
                   lat=beerTweets$point_long,
                   popup = beerTweets$body, 
                   stroke = FALSE, 
                   fillOpacity = 0.5, 
                   radius = 10, 
                   clusterOptions = markerClusterOptions())

## time series (dygraph), see http://rstudio.github.io/dygraphs/index.html
# install.packages("dygraphs"); install.packages("xts")
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

dygraph(dailyCounts, main = "Charlotte Geo-located Tweets") %>% 
  dyRangeSelector() %>%
  dyEvent("2016-02-08", "Super Bowl") %>%
  dyEvent("2016-01-25", "NFC Championship")

## visNetwork http://datastorm-open.github.io/visNetwork/
# install.packages("visNetwork"); install.packages("igraph")
library(igraph)

# How to pull twitter from R (rtweet): see http://rtweet.info/
# rtweets <- rtweet::search_tweets("#rstats", n = 18000, token = twitter_token)

# read in 17,829 (incl. RT's) tweets pulled June 5, 2018 with "#rstats"
rtweets <- read_csv("./data/rtweets.csv")

# regular expression -- get only tweets that have "RT @", i.e. retweet
term <- "tidyverse"

rtweetsTerm <- rtweets %>%
  filter(str_detect(text, "RT @")) %>%
  filter(str_detect(tolower(text), term))

names <- unique(rtweetsTerm$screen_name)

edges <- tibble(node1 = rtweetsTerm$screen_name, 
                node2 = gsub('.*RT @([a-zA-Z0-9_]+):? ?.*', rtweetsTerm$text, repl="\\1")) %>%
  filter(node1 %in% names & node2 %in% names) %>%
  group_by(node1, node2) %>%
  summarise(weights = n())

g <- graph_from_data_frame(d=edges, directed=TRUE)

library(visNetwork)

degTotal <- degree(g)
V(g)$size <- 10*log(degTotal) + 10

visIgraph(g) %>% 
  visInteraction(navigationButtons = TRUE) %>%
  visEdges(arrows = list(to = list(enabled = TRUE, scaleFactor = 0.5))) %>%
  visIgraphLayout("physics" = TRUE)

### tidytext: see https://www.tidytextmining.com/
# install.packages("tidytext")
library(tidytext)

# load stop words
data("stop_words")

# remove urls, lt, amp, gt
replace_reg <- "https://t.co/[A-Za-z\\d]+|http://[A-Za-z\\d]+|&amp;|&lt;|&gt;|RT|https"

tweet_words <- filter(rtweets, is_retweet == FALSE) %>%
  mutate(text = str_replace_all(text, replace_reg, ""),
         Date = as.Date(created_at)) %>%
  unnest_tokens(word, text) %>%
  anti_join(stop_words) %>%
  count(Date, word, sort = TRUE) %>%
  ungroup() %>%
  bind_tf_idf(word, Date, n)

tweet_words %>%
  arrange(desc(tf_idf)) %>%
  mutate(word = factor(word, levels = rev(unique(word)))) %>% 
  group_by(Date) %>% 
  top_n(10) %>% 
  ungroup %>%
  ggplot(aes(word, tf_idf, fill = as.factor(Date))) +
  geom_col(show.legend = FALSE) +
  labs(x = NULL, y = "tf-idf") +
  facet_wrap(~Date, ncol = 4, scales = "free") +
  coord_flip()

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
