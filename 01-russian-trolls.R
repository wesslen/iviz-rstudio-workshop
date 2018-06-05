# install packages
# install.packages("tidyverse")

# call (i.e., activate) tidyverse
library(tidyverse)

# load csv file
url <- "http://nodeassets.nbcnews.com/russian-twitter-trolls/tweets.csv"
tweets <- read_csv(url)

# functions in tidyverse
count(tweets, user_key)

# assignment operator
c <- count(tweets, user_key)

# piping
c2 <- tweets %>%
  count(user_key)

# group_by and summarise
c3 <- tweets %>%
  group_by(user_key) %>%
  summarise(Count=n())

# what is the difference between these three dataframes?


### What were the top tweets by retweet and favorite (likes) counts?

tweets %>%
  arrange(desc(retweet_count)) %>%
  select(user_key, created_str, text, retweet_count)

tweets %>%
  arrange(desc(favorite_count)) %>%
  select(user_key, created_str, text, favorite_count)

# ggplot
sum <- tweets %>%
  group_by(Date = as.Date(created_str)) %>%
  summarise(Count = n())

# create ggplot
ggplot(data = sum, aes(x = Date, y = Count)) +
  geom_line()

tweets %>%
  group_by(Date = as.Date(created_str)) %>%
  summarise(Count = n())

ggplot(data = sum, aes(x = Date, y = Count)) +
  geom_line() +
  geom_point() +
  labs(title = "Daily Tweet Counts by Russian Trolls",
       x = "Time (Day)",
       y = "Number of Tweets",
       caption = "Source: NBC News")

# saving as an object
m <- ggplot(data = sum, aes(x = Date, y = Count)) +
  geom_line() +
  geom_point()

# you can manually call the object
m

# you can e
m + labs(title = "Daily Tweet Counts by Russian Trolls",
         x = "Time (Day)",
         y = "Number of Tweets",
         caption = "Source: NBC News")

# use stringr for text filter -- part of the tidyverse 
library(stringr)

term <- "keithlamontscott|charlotte"

q <- tweets %>%
  filter(str_detect(tolower(tweets$text), term))

# with full pipeline
term <- "obama"

q <- tweets %>%
  filter(str_detect(tolower(tweets$text), term)) %>%
  group_by(Date = as.Date(created_str)) %>%
  summarise(Count=n()) %>%
  ggplot(aes(x = Date, y = Count)) +
  geom_line() +
  labs(title = paste0("Tweets filtered by `",term,"`"),
  x = "Day",
  y = "Number of Tweets")

q

## first html widget: plotly

# install.packages("plotly")
library(plotly)

ggplotly(q)
