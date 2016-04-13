library(tm)
library(SnowballC)
library(wordcloud)
library(data.table)
setwd("C:/Users/husam/Downloads/project4-team-9/lib")
# load("C:/Users/husam/Downloads/popularMovies.RData")
# load("amzData.RData")
# popularMovies <- as.character(amzData$ASIN)
# allrev <- read.csv('reviews.csv',stringsAsFactors = FALSE)
# allrevs <- fread('reviews.csv')
# setkey(allrevs,product_productid)
# allrevs2 <- allrevs[popularMovies]
# coll <- readRDS("collapsedReviews.RDS")
# coll <- allrevs2[, list(review_text = paste(review_text,collapse=' ')),
                 # by=product_productid]
coll <- readRDS("popularcollapsed.RDS")
createwc <- function(ASIN) {
  if (ASIN %in% coll$product_productid & coll[coll$product_productid == ASIN]$review_text != "NA"){
    revcorpus <- Corpus(VectorSource(coll[coll$product_productid == ASIN]$review_text))
    
    revcorpus <- tm_map(revcorpus, content_transformer(tolower))
    revcorpus <- tm_map(revcorpus, removePunctuation)
    revcorpus <- tm_map(revcorpus, PlainTextDocument)
    revcorpus <- tm_map(revcorpus, removeWords, stopwords('english'))
    
    revcorpus <- tm_map(revcorpus, stemDocument)
    
    wordcloud(revcorpus, max.words = 50, random.order = FALSE)
  }
  
}


