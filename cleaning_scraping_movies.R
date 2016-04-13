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

# html_text(html_nodes(read_html('http://www.amazon.com/exec/obidos/ASIN/076780046X'),
#            xpath="//span[@class='author notFaded']/a"))

#system.time(amzData1<-getAmazonInfo(levels(rawMovies$product_productid)[1:100])) #111.65sec 2min ; 110days
system.time(amzData1<-getAmazonInfo(popularMovies[1:300])) #111.65sec 2min ; 110days
system.time(amzData3<-getAmazonInfo(popularMovies[601:842])) #111.65sec 2min ; 110days
system.time(amzData3.2<-getAmazonInfo(popularMovies[844:900])) #111.65sec 2min ; 110days

amzData1
amzData1Length<-sapply(1:300,function(i)length(amzData1[[i]]))
amzData3Length<-sapply(1:242,function(i)length(amzData3[[i]]))
amzData3.2Length<-sapply(1:57,function(i)length(amzData3.2[[i]]))
amzData4Length<-sapply(1:300,function(i)length(amzData4[[i]]))
amzData10Length<-sapply(1:208,function(i)length(amzData10[[i]]))

amzData1Clean<-data.frame(matrix(unlist(amzData1[amzData1Length==4]),nrow=sum(amzData1Length==4), byrow=T))
amzData3Clean<-data.frame(matrix(unlist(amzData3[amzData3Length==4]),nrow=sum(amzData3Length==4), byrow=T))
amzData3.2Clean<-data.frame(matrix(unlist(amzData3.2[amzData3.2Length==4]),
                                   nrow=sum(amzData3.2Length==4), byrow=T))
amzData4Clean<-data.frame(matrix(unlist(amzData4[amzData4Length==4]),nrow=sum(amzData4Length==4), byrow=T))
amzData10Clean<-data.frame(matrix(unlist(amzData10[amzData10Length==4]),
                                  nrow=sum(amzData10Length==4), byrow=T))
amzData2<-data.frame(amzData2)

amzData<-rbind(amzData1Clean,amzData2,amzData3Clean,amzData3.2Clean,amzData4Clean,amzData10Clean)
names(amzData)<-c('ASIN','Name','Rating','Reviews')

save(amzData,file="C:/Users/ygu/Desktop/columbia/movieShiny/www/amzData.RData")

#cat(load("D:/amzondata10.RData"))


movietxt<-NULL
for(i in 1:72){
  cat(i,'\n')
  if(i<=9)
    movietxt<-
      c(movietxt,
        readLines(paste0("C:/Users/ygu/Desktop/columbia/movies/movies_00000",i,".txt")))
  else
    movietxt<-
      c(movietxt,
        readLines(paste0("C:/Users/ygu/Desktop/columbia/movies/movies_0000",i,".txt")))
}
# movietxt1<-readLines("C:/Users/ygu/Desktop/columbia/movies/movies_000001.txt") #1013628
# movietxt2<-readLines("C:/Users/ygu/Desktop/columbia/movies.txt") #1013628
# a<-read.table(file="C:/Users/ygu/Desktop/columbia/movies.txt",sep=':')
tail(movietxt) #38732978
length(movietxt)
movietxt[38732978:38732981]

productId=movietxt[1:4303664*9-8]
userId=movietxt[1:4303664*9-7]
helpfulness=movietxt[1:4303664*9-5]
score=movietxt[1:4303664*9-4]
time=movietxt[1:4303664*9-3]
summary=movietxt[1:4303664*9-2]
text=movietxt[1:4303664*9-1]

movieDataFrame<-cbind(productId,userId,helpfulness,score,time,summary,text)
movieDataFrame[,'productId']<-gsub('product\\/productId\\: ','',movieDataFrame[,'productId'])
movieDataFrame[,'userId']<-gsub('review\\/userId\\: ','',movieDataFrame[,'userId'])
movieDataFrame[,'helpfulness']<-gsub('review\\/helpfulness\\: ','',movieDataFrame[,'helpfulness'])
movieDataFrame[,'score']<-gsub('review\\/score\\: ','',movieDataFrame[,'score'])
movieDataFrame[,'time']<-gsub('review\\/time\\: ','',movieDataFrame[,'time'])
movieDataFrame[,'summary']<-gsub('review\\/summary\\: ','',movieDataFrame[,'summary'])
movieDataFrame[,'text']<-gsub('review\\/text\\: ','',movieDataFrame[,'text'])

save(movieDataFrame,file="D:/movieDataFrame.R")

gsub('product\\/productId\\: ','',"product/productId: B003AI2VGA")

product id
user id
profilename
helpfulness
score
time
summary
text

as.Date(as.POSIXct(1182729600, origin="1970-01-01"))
