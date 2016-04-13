library(dplyr)
library(tidyr)
library(hexbin)
library(recommenderlab)
library(data.table)

setwd("C:/Users/lwh/Desktop/movietxt")
data<-fread('moviescsv.csv')
data_part=data            #only a part of raw data



length(table(data_part$review_userid))           #8832

length(table(data_part$product_productid))       #321

movie_name=as.character(levels(as.factor(data_part$product_productid)))

user_id=as.character(levels(as.factor(data_part$review_userid)))

user_item<-matrix(NA,nrow=length(user_id),ncol=length(movie_name))

colnames(user_item)<-movie_name
rownames(user_item)<-user_id


for (i in 1:dim(data_part)[1]){                          #fill the matrix, 112625 lines
  user=data_part$review_userid[i]
  movie=data_part$product_productid[i]
  user_item[user,movie]=data_part$review_score[i]
  print(i)
}


r <- as(user_item[c(1:10000),], "realRatingMatrix")
r_m <- normalize(r)
image(r, main = "Raw Ratings")
image(r_m, main = "Normalized Ratings")


r_b <- binarize(r, minRating=2)
as(r_b, "matrix")

rowCounts(r[4,])
as(r[1,], "list")

hist(getRatings(r), breaks=100)

hist(getRatings(normalize(r)), breaks=100)

hist(getRatings(normalize(r, method="Z-score")), breaks=100)

recommenderRegistry$get_entries(dataType = "realRatingMatrix")


r_d <- Recommender(r[1:9000], method = "POPULAR")      #train model
r_d
names(getModel(r_d))

getModel(r_d)$topN         #get mode


recom <- predict(r_d, r[9001:9002], n=5)      #make recommendation for 2 users
recom
as(recom, "list")               #show the result


recom <- predict(r_d, r[9001:9002], type="ratings")     #predict rating of 2 users
as(recom, "matrix")[,1:3568]


e <- evaluationScheme(r[1:1000], method="split", train=0.9,given=15, goodRating=3) #
 

