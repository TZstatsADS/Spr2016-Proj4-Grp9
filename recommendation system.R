library(dplyr)
library(tidyr)
library(hexbin)
library(recommenderlab)
library(data.table)

data<-data.frame(fread("D:/moviescsv.csv"))

data$product_productid<-gsub('\\.0','',data$product_productid)

movieReviewCount<-table(factor(data$product_productid)) #3568
popularMovies<-names(movieReviewCount)[movieReviewCount>10] #1408 remove more than 1/2 of the movies
save(popularMovies,file='C:/Users/ygu/Desktop/columbia/movieShiny/www/popularMovies.RData')

data_part=data[data$product_productid%in%amzData$ASIN,]           #only a part of raw data

#summary(factor(data$product_productid))

# length(table(data_part$review_userid))           #889177
# 
# length(table(data_part$product_productid))       #321

movie_name=as.character(levels(as.factor(data_part$product_productid)))

user_id=as.character(levels(as.factor(data_part$review_userid)))

user_item<-matrix(NA,nrow=length(user_id),ncol=length(movie_name))

colnames(user_item)<-movie_name
rownames(user_item)<-user_id


for (i in 1:nrow(data_part)){                          #fill the matrix
  user=data_part$review_userid[i]
  movie=data_part$product_productid[i]
  user_item[user,movie]=data_part$review_score[i]
  print(i)
}
#user_item 48167 ppl  962 movies

save(user_item,file='C:/Users/ygu/Desktop/columbia/movieShiny/www/user_item.RData')

r <- as(user_item, "realRatingMatrix")
r_m <- normalize(r)
#image(r, main = "Raw Ratings")
# image(r_m, main = "Normalized Ratings")


r_b <- binarize(r, minRating=2)
as(r_b, "matrix")

rowCounts(r[4,])
as(r[1,], "list")

hist(getRatings(r), breaks=100)

hist(getRatings(normalize(r)), breaks=100)

hist(getRatings(normalize(r, method="Z-score")), breaks=100)

recommenderRegistry$get_entries(dataType = "realRatingMatrix")


r_d <- Recommender(r[1:68170], method = "POPULAR")      #train model
r_d
names(getModel(r_d))
getModel(r_d)$topN


recom <- predict(r_d, r[1001], n=5)      #make recommendation for 2 users
recom
as(recom, "list")[[1]]               #show the result


recom <- predict(r_d, r[1006:1010], type="ratings")     #predict rating of 2 users
as(recom, "matrix")[,1:321]
