
# tidy text https://www.tidytextmining.com/

# Make sure to install tidytext
# install.packages("tidytext")

library(tidytext)

tidy_tweets <- tweets %>% 
  unnest_tokens(word, body)

# count words

counts <- tidy_tweets %>% 
  count(word, sort = TRUE)

head(counts, n = 10)

# remove stop words

data("stop_words")
cleaned_tweets <- tidy_tweets %>%
  anti_join(stop_words) %>%
  count(word, sort = TRUE) 

head(cleaned_tweets, n = 10)

# count sentiment net scores

bing <- get_sentiments("bing")

sentiment <- tidy_tweets %>%
  inner_join(bing) %>%
  count(day = as.Date(postedTime), sentiment) %>%
  spread(sentiment, n, fill = 0) %>%
  mutate(sentiment = (positive - negative) / n())

# plot scores

ggplot(sentiment, aes(day, sentiment)) +
  geom_point() +
  geom_smooth(method = "loess", size = 1.5, span = 0.1) +
  labs(title = "Sentiment Analysis", subtitle = "Net Sentiment Score per Tweet", x = "Day", y = "Sentiment")
