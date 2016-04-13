library(XML)
library(stringr)
recom <- function(x){
  # x is a movie name
  load("keywords_clean1.RData")
  ASIN =  new.dat[which(x==new.dat[,2]),1]
  url1 = paste("http://www.amazon.com/exec/obidos/ASIN/",ASIN, sep="")
  url = htmlParse(url1,encoding="UTF-8")
  this.info = getNodeSet(url,'//meta[@name]')
  this.content2 <- xmlGetAttr(this.info[[3]], "content")
  this.movie.keywords = str_split(this.content2,",")[[1]]
  n = length(this.movie.keywords)
  ind = vector()
  for ( i in 1:n){
    for ( j in 5:12 ){
      this.index = which(this.movie.keywords[i]==dat[,j])
      ind = c(ind,this.index)
    }
  }
  ind = unique(ind)
  recom.inf = cbind(product.table[ind,],dat[ind,2])
  recom.score = recom.inf[order(recom.inf[,3]),] # order by score
  recom.popu = recom.inf[order(recom.inf[,4]),] # order by number of review
}
