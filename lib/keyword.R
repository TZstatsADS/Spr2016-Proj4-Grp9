library(stringr)
library(XML)
library(rvest)
dat = mat.or.vec(962,12)
dat[,1:4]=as.matrix(amzData)
new.dat = dat
for ( i in 1: 962 ) {
  cat(i,'\n')
  this.movie.id = new.dat[i,1]
  this.url1 = paste("http://www.amazon.com/exec/obidos/ASIN/",this.movie.id, sep="")
  try(this.url <- htmlParse(this.url1,encoding="UTF-8"))
  try(this.info <- getNodeSet(this.url,'//meta[@name]'))
  if( length(this.info)==1){
    new.dat[i, 5:12] = rep(NA,8)
  }else{
    this.content2 <- xmlGetAttr(this.info[[3]], "content")
    this.movie.keywords <- str_split(this.content2,",")[[1]]
    new.dat[i,5:8] = this.movie.keywords[1:4]
    m = length(this.movie.keywords)
    if ( m >= 10 ){
      new.dat[i,9:12] = this.movie.keywords[(m-3):m]
    }else{
      new.dat[i,9:12] = this.movie.keywords[5:8]
    }
  }
  save(new.dat,file="output/keywords_clean1.RData")
}



 getNodeSet(this.url,'//div[@class="content"]')

 movie1<-read_html(this.url1)
 html_text(html_nodes(movie1,xpath="//span[@id='productTitle']"))
 html_text(html_nodes(movie1,xpath="//div[@id='averageCustomerReviews']//span[@class='a-icon-alt']"))
 