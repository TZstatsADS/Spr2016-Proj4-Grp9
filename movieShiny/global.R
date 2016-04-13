
library('shiny')
require('rCharts')
library('shinydashboard')
library('plyr')
require(RJSONIO)
#library(leaflet)
library(XML)
library(rvest)
library(dplyr)
library(tidyr)
library(hexbin)
library(recommenderlab)

options(stringsAsFactors = F)


load("www/user_item.RData")
load("www/amzData.RData")



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


