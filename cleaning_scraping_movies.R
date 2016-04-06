library(data.table)
library(rvest)
rawMovies<-data.frame(fread("C:/Users/ygu/Desktop/columbia/moviescsv.csv"))
rawMovies<-rawMovies[rawMovies$product_productid!='',]
rawMovies$product_productid<-factor(rawMovies$product_productid)
rawMovies$review_userid<-factor(rawMovies$review_userid)
rawMovies$review_helpfulness<-factor(rawMovies$review_helpfulness)
summary(rawMovies)
dim(rawMovies) #7911696       4

movie1<-read_html(paste("http://www.amazon.com/exec/obidos/ASIN/B007FQDPL8"))
html_text(html_nodes(movie1,xpath="//span[@id='productTitle']"))
html_text(html_nodes(movie1,xpath="//div[@id='averageCustomerReviews']//span[@class='a-icon-alt']"))
html_text(html_nodes(movie1,xpath="//div[@id='averageCustomerReviews']//span[@id='acrCustomerReviewText']"))

getAmazonInfo<-function(asin){
  t(sapply(1:length(asin),function(i){
    cat(i,'\n')
    object<-read_html(paste0("http://www.amazon.com/exec/obidos/ASIN/",asin[i]))
    Title<-html_text(html_nodes(object,xpath="//span[@id='productTitle']"))
    Rating<-html_text(html_nodes(object,
                                 xpath="//div[@id='averageCustomerReviews']//span[@class='a-icon-alt']"))
    if(length(Rating)==0) Rating<-'Missing'
    Reviews<-
      html_text(html_nodes(object,
                           xpath="//div[@id='averageCustomerReviews']//span[@id='acrCustomerReviewText']"))
    if(length(Reviews)==0) Reviews<-'Missing'
    #browser()
    return(c(asin[i],Title,Rating,Reviews))
  }))
}

system.time(amzData1<-getAmazonInfo(levels(rawMovies$product_productid)[1:100])) #111.65sec 2min ; 110days
amzData1

library(reader)
movietxt1<-readLines("C:/Users/ygu/Desktop/columbia/movies/movies_000001.txt") #1013628
movietxt2<-n.readLines("C:/Users/ygu/Desktop/columbia/movies.txt",n=1000000,skip=1013628) #1013628
a<-read.table(file="C:/Users/ygu/Desktop/columbia/movies.txt",sep=':')
