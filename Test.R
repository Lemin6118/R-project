install.packages("wordcloud")
library(wordcloud)

word <- c("내집","서울시","금정동")
frequency <- c(1000,500,30)

wordcloud(word,frequency,colors=rainbow(length(word)))

# 3주차 ##########################################

foo <- c(100,200,300)
foo
