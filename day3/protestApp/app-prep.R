# Project 1: Charlotte Protest
library(tidyverse); library(lubridate); library(xts); library(dygraphs); library(quanteda)

# 10% sample
protestData <- readRDS("protestData.RData") %>%
  mutate(time = paste0(substr(postedTime, 1, 16), "00 EDT")) %>% # convert to hourly
  mutate(time = ymd_hms(time)) %>%
  select(time, verb, postedTime, body)

# get daily counts
counts <- protestData %>% 
  count(Date = as.Date(postedTime), Type = verb) %>%
  mutate(n = n * 10) # adjust for sampling

# dygraphs

counts <- protestData %>%
  select(time, Type = verb) %>% # keep only columns
  count(time, Type) %>% # count by terms
  mutate(n = n * 10) %>% # adjust for 10% sample
  spread(key = Type, value = n, fill = 0) # pivot to xts format
  
tweet.time <- xts(
  x = counts[,-1],
  order.by = counts$time,
  tz = "EDT"
)

# quanteda

# create dfm
stopWords <- c("rt","http","t.co","https","amp", "t.c")

myCorpus <- corpus(protestData$body)
docvars(myCorpus, "time") <- protestData$time # used to filter
docvars(myCorpus, "verb") <- protestData$verb # used to filter

dfmAll <- corpus(myCorpus) %>%
  dfm(remove_punct = TRUE,
      remove_url = TRUE,
      remove = c(stopwords("English"), stopWords))