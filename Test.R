install.packages("wordcloud")
library(wordcloud)

word <- c("인천광역시","서울시","금정동")
frequency <- c(1000,500,30)

wordcloud(word,frequency,colors=rainbow(length(word)))
