
suppressMessages(library('shiny'))
# suppressMessages(require('rCharts'))
suppressMessages(library('shinydashboard'))
suppressMessages(library('plyr'))
suppressMessages(require(RJSONIO))
#library(leaflet)
suppressMessages(library(XML))
suppressMessages(library(rvest))
suppressMessages(library(dplyr))
suppressMessages(library(tidyr))
suppressMessages(library(hexbin))
suppressMessages(library(recommenderlab))
suppressMessages(library(tm))
suppressMessages(library(SnowballC))
suppressMessages(library(wordcloud))
suppressMessages(library(data.table))


options(stringsAsFactors = F)


load("www/user_item.RData")
load("www/amzData.RData")
pal <- brewer.pal(9,"YlGnBu")[-(1:4)]


coll <- readRDS("../lib/popularcollapsed.RDS")
createwc <- function(ASIN) {
  if (ASIN %in% coll$product_productid & coll[coll$product_productid == ASIN,]$review_text != "NA"){
    revcorpus <- Corpus(VectorSource(coll[coll$product_productid == ASIN]$review_text))
    
    revcorpus <- tm_map(revcorpus, content_transformer(tolower))
    revcorpus <- tm_map(revcorpus, removePunctuation)
    revcorpus <- tm_map(revcorpus, PlainTextDocument)
    revcorpus <- tm_map(revcorpus, removeWords, stopwords('english'))
    
    # revcorpus <- tm_map(revcorpus, stemDocument)
    
    wordcloud(revcorpus, max.words = 50, random.order = FALSE,col=pal)
  }
  
}






# toGeoJSON = function(list_){
#   x = lapply(list_, function(l){
#     list(
#       type = 'Feature',
#       geometry = list(
#         type = 'Point',
#         coordinates = c(l$longitude, l$latitude)
#       ),
#       properties = l[!(names(l) %in% c('latitude', 'longitude'))]
#     )
#   })
# }

#load("www/uniqueRestau5.RData")

#factpal <- colorFactor(heat.colors(4), uniqueRestau5$SafetyScoreColor)

# pal <- colorNumeric(
#   palette = "Reds",
#   domain = uniqueRestau5$SafetyScore
# )


