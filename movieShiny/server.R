options(shiny.maxRequestSize=50*1024^2)

shinyServer(function(input, output, session) {

    Data<-reactive({
      
      asinSelected<-amzData$ASIN[amzData$Name%in%input$moviesLiked]
      
      # user_itemNew<-rbind(user_item,NA)
      # 
      # browser()
      # 
      # user_itemNew[48003,as.character(asinSelected)]<-5
      # 
      # r <- as(user_itemNew, "realRatingMatrix")
      # r_m <- normalize(r)
      # r_b <- binarize(r_m, minRating=2)
      # # as(r_b, "matrix")
      # # recommenderRegistry$get_entries(dataType = "realRatingMatrix")
      # 
      # r_d <- Recommender(r_b[1:48002], method = "POPULAR")      #train model
      # recom <- predict(r_d, r_b[48003], n=3)      #make recommendation for 2 users
      # return(as(recom,"list")[[1]])
      
      users<-unique(data_part$review_userid[data_part$product_productid%in%asinSelected])
      movies<-data_part$product_productid[data_part$review_userid%in%users&data_part$review_score>=4]
      
      newMovies<-movies[!movies%in%asinSelected]
      # print(names(rev(sort(table(newMovies))))[1:3])
      return(names(rev(sort(table(newMovies))))[1:3])
      
      
      #new_user_item<-
      # result<-list()
      # result[[1]]<-uniqueRestau5[uniqueRestau5$Cuisine%in%input$cuisine&
      #                              uniqueRestau5$businesses.review_count>=input$minReview&
      #                              uniqueRestau5$businesses.rating>=input$minStar&
      #                              uniqueRestau5$SafetyScore>=input$minSafetyScore,]
      # if(!is.null(input$location)){
      #   url = paste0('http://maps.google.com/maps/api/geocode/xml?address=',input$location,'&sensor=false')
      #   doc = xmlTreeParse(url) 
      #   root = xmlRoot(doc) 
      #   lat = xmlValue(root[['result']][['geometry']][['location']][['lat']]) 
      #   long = xmlValue(root[['result']][['geometry']][['location']][['lng']])
      #   result[[2]]<-c(lat,long)
      #   subdata<-uniqueRestau5[uniqueRestau5$businesses.review_count>=input$minReview&
      #                            uniqueRestau5$businesses.rating>=input$minStar&
      #                            uniqueRestau5$SafetyScore>=input$minSafetyScore,]
      #   #browser()
      #   subdata2<-subdata[sqrt((subdata$longitude-as.numeric(long))^2+
      #                            (subdata$latitude-as.numeric(lat))^2)*59.38<=input$distance,]
      #   result[[1]]<-subdata2[subdata2$Cuisine%in%input$cuisine,]
      #   result[[3]]<-subdata2
      # }
      # #browser()
      # return(result)
    })
    
    # yelpData<-reactive({
    #   if(is.null(input$Map_marker_click))
    #     return(NULL)
    #   else{
    #     data<-Data()[[1]]
    #     query<-gsub(' ','\\+',data$businesses.name[data$NameId==input$Map_marker_click$id])
    #     location<-gsub(' ','\\+',data$DbaBoro[data$NameId==input$Map_marker_click$id])
    #     url<-read_html(paste0("http://www.yelp.com/search?find_desc=",query,"&find_loc=",location))
    #     
    #     src=gsub('.*src=\\\"|\".*','',
    #              as.character(html_nodes(url,xpath="//div[@data-key='1']//div[@class='photo-box pb-90s']")))
    #     price<-html_text(
    #       html_nodes(url,xpath="//div[@data-key='1']//span[@class='business-attribute price-range']"))
    #     return(list(src,price))
    #   }
    # })
    # 
    # output$pieChart <- renderChart2({
    #   data<-Data()[[3]]
    #   #browser()
    #   aggData<-aggregate(data$Cuisine,list(data$Cuisine),FUN=length)
    #   names(aggData)<-c('Cuisine','Count')
    #   aggData<-aggData[rev(order(aggData$Count)),]
    #   
    #   aggData2<-aggData[1:8,]
    #   aggData2$Cuisine[8]<-'Other'
    #   aggData2$Count[8]<-sum(aggData$Count[8:nrow(aggData)])
    #   aggData2$Perc<-round(aggData2$Count/sum(aggData2$Count),2)
    #   
    #   a<-Highcharts$new()
    #   a$data(x=aggData2$Cuisine,y=aggData2$Perc,type="pie",name='Accounts for')#name of cuisine
    #   a$set(dom='pieChart')
    #   #a$show("inline", include_assets = FALSE)
    #   return(a)
    # })
    # 
    # output$Map <- renderLeaflet({
    #   #browser()
    #   leaflet() %>% addProviderTiles("Stamen.TonerLite") %>% 
    #     setView(lng=Data()[[2]][2], lat=Data()[[2]][1], zoom=13) %>%
    #     addCircleMarkers(data=Data()[[1]],radius=~businesses.rating*2,fillColor=~pal(SafetyScore), 
    #                      stroke=FALSE, fillOpacity=0.5,layerId=~NameId)  %>% 
    #     addCircleMarkers(Data()[[2]][2],Data()[[2]][1],radius=10,color="blue",fillColor="orange",
    #                      fillOpacity=1,opacity=1,stroke=TRUE,layerId="Selected")
    # })
    # 
    # observeEvent(input$Map_marker_click, {
    #   #browser()
    #   p <- input$Map_marker_click
    #   if(!is.null(p$id)){
    #     if(is.null(input$nameId)) updateSelectInput(session, "nameId", selected=p$id)
    #     if(!is.null(input$nameId) && input$nameId!=p$id) updateSelectInput(session,"nameId",selected=p$id)
    #   }
    # })
    # 
    output$Rec1Name<-renderText({
      
      data<-Data()[1]
      name<-gsub('\\[.*|[[:punct:]]','',as.character(amzData$Name[amzData$ASIN==data]))
      return(name)
      
    })
    
    output$Rec1image = renderUI({
      data<-Data()[1]
      #browser()
      name<-gsub('\\[.*|[[:punct:]]','',as.character(amzData$Name[amzData$ASIN==data]))
      # omdb.entry=search_by_title(name)
      # result<-data.frame(find_by_id(omdb.entry$imdbID[1], include_tomatoes=T))
      url<-read_html(paste0('http://www.rottentomatoes.com/search/?search=',gsub(' ','+',name)))
      
      if(length(gsub('.*src=\\\"|\".*','',
                     html_nodes(url,xpath="//div[@id='movie-image-section']//img"))!=0))
        src<-gsub('.*src=\\\"|\".*','',html_nodes(url,xpath="//div[@id='movie-image-section']//img"))
      else{
        newSub<-gsub('.*href="|\\/">.*','',
                     html_nodes(url,xpath="//div[@class='nomargin media-heading bold']/a"))
        url2<-read_html(paste0('http://www.rottentomatoes.com/',newSub[1]))
        
        src<-gsub('.*src=\\\"|\".*','',html_nodes(url2,xpath="//div[@id='movie-image-section']//img"))
      }

      return(tags$img(src=src))
    })
    
    output$rec1wc <- renderPlot({
      # print(input$moviesLiked)
      
      ASIN <- Data()[1]
      # print(movieName)
      #       for(i in movieName) {
      #         print( i)
      # print(amzData[amzData$Name == movieName,])
      # ASIN <- amzData[amzData$Name == movieName,]$ASIN
      # print(as.character(ASIN))
      createwc(as.character(ASIN))
      # }
      
    })
    
    
    output$Rec2Name<-renderText({
      
      data<-Data()[2]
      name<-gsub('\\[.*|[[:punct:]]','',as.character(amzData$Name[amzData$ASIN==data]))
      return(name)
      
    })
    
    output$Rec2image = renderUI({
      data<-Data()[2]
      #browser()
      name<-gsub('\\[.*|[[:punct:]]','',as.character(amzData$Name[amzData$ASIN==data]))
      # omdb.entry=search_by_title(name)
      # result<-data.frame(find_by_id(omdb.entry$imdbID[1], include_tomatoes=T))
      url<-read_html(paste0('http://www.rottentomatoes.com/search/?search=',gsub(' ','+',name)))
      
      if(length(gsub('.*src=\\\"|\".*','',
                     html_nodes(url,xpath="//div[@id='movie-image-section']//img"))!=0))
        src<-gsub('.*src=\\\"|\".*','',html_nodes(url,xpath="//div[@id='movie-image-section']//img"))
      else{
        newSub<-gsub('.*href="|\\/">.*','',
                     html_nodes(url,xpath="//div[@class='nomargin media-heading bold']/a"))
        url2<-read_html(paste0('http://www.rottentomatoes.com/',newSub[1]))
        
        src<-gsub('.*src=\\\"|\".*','',html_nodes(url2,xpath="//div[@id='movie-image-section']//img"))
      }
      return(tags$img(src=src))
    })
    
    output$rec2wc <- renderPlot({
      # print(input$moviesLiked)
      
      ASIN <- Data()[2]
      # print(movieName)
      #       for(i in movieName) {
      #         print( i)
      # print(amzData[amzData$Name == movieName,])
      # ASIN <- amzData[amzData$Name == movieName,]$ASIN
      # print(as.character(ASIN))
      createwc(as.character(ASIN))
      # }
      
    })
    
    output$Rec3Name<-renderText({
      
      data<-Data()[3]
      name<-gsub('\\[.*|[[:punct:]]','',as.character(amzData$Name[amzData$ASIN==data]))
      return(name)
      
    })
    
    output$Rec3image = renderUI({
      data<-Data()[3]
      #browser()
      name<-gsub('\\[.*|[[:punct:]]','',as.character(amzData$Name[amzData$ASIN==data]))
      # omdb.entry=search_by_title(name)
      # result<-data.frame(find_by_id(omdb.entry$imdbID[1], include_tomatoes=T))
      url<-read_html(paste0('http://www.rottentomatoes.com/search/?search=',gsub(' ','+',name)))
      if(length(gsub('.*src=\\\"|\".*','',
                     html_nodes(url,xpath="//div[@id='movie-image-section']//img"))!=0))
        src<-gsub('.*src=\\\"|\".*','',html_nodes(url,xpath="//div[@id='movie-image-section']//img"))
      else{
        newSub<-gsub('.*href="|\\/">.*','',
                     html_nodes(url,xpath="//div[@class='nomargin media-heading bold']/a"))
        url2<-read_html(paste0('http://www.rottentomatoes.com/',newSub[1]))
        
        src<-gsub('.*src=\\\"|\".*','',html_nodes(url2,xpath="//div[@id='movie-image-section']//img"))
      }
      return(tags$img(src=src))
    })
    
    output$rec3wc <- renderPlot({
      # print(input$moviesLiked)
      
      ASIN <- Data()[3]
      # print(movieName)
      #       for(i in movieName) {
      #         print( i)
      # print(amzData[amzData$Name == movieName,])
      # ASIN <- amzData[amzData$Name == movieName,]$ASIN
      # print(as.character(ASIN))
      createwc(as.character(ASIN))
      # }
      
    })
    
    
    # 
    # output$clickedNameAddress<-renderText({
    #   #browser()
    #   if(is.null(input$Map_marker_click))
    #     return(NULL)
    #   else{
    #     data<-Data()[[1]]
    #     return(paste0('Address: ',data$DbaBoro[data$NameId==input$Map_marker_click$id]))
    #   }
    # })
    # 
    # output$clickedNameGrade<-renderText({
    #   #browser()
    #   if(is.null(input$Map_marker_click))
    #     return(NULL)
    #   else{
    #     data<-Data()[[1]]
    #     return(paste0('Grade: ',as.character(data$GRADE[data$NameId==input$Map_marker_click$id])))
    #   }
    # })
    # 
    # output$clickedNameCritical<-renderText({
    #   #browser()
    #   if(is.null(input$Map_marker_click))
    #     return(NULL)
    #   else{
    #     data<-Data()[[1]]
    #     return(paste0(data$CriticalInspection[data$NameId==input$Map_marker_click$id],
    #                   ' critical(s) out of ',data$TotalInspection[data$NameId==input$Map_marker_click$id],
    #                   ' inspections'))
    #   }
    # })
    # 
    # output$clickedNameRating<-renderText({
    #   #browser()
    #   if(is.null(input$Map_marker_click))
    #     return(NULL)
    #   else{
    #     data<-Data()[[1]]
    #     return(paste0(data$businesses.rating[data$NameId==input$Map_marker_click$id],
    #                   ' stars out of 5 on Yelp'))
    #   }
    # })
    # 
    # output$clickedNameReviewCount<-renderText({
    #   #browser()
    #   if(is.null(input$Map_marker_click))
    #     return(NULL)
    #   else{
    #     data<-Data()[[1]]
    #     return(paste0(data$businesses.review_count[data$NameId==input$Map_marker_click$id],
    #                   ' reveiews on Yelp'))
    #   }
    # })
    # 
    # output$clickedNamePriceRange<-renderText({
    #   #browser()
    #   if(is.null(input$Map_marker_click))
    #     return(NULL)
    #   else{
    #     price<-yelpData()[[2]]
    #     return(paste0('Price range: ',price))
    #   }
    # })
    # 
    # output$clickedNamePhone<-renderText({
    #   #browser()
    #   if(is.null(input$Map_marker_click))
    #     return(NULL)
    #   else{
    #     data<-Data()[[1]]
    #     if(nchar(as.character(data$PHONE[data$NameId==input$Map_marker_click$id]))==10){
    #       phone<-data$PHONE[data$NameId==input$Map_marker_click$id]
    #       return(paste0('Phone #: (',substr(phone,1,3),')',substr(phone,4,6),'-',substr(phone,7,10)))
    #     }
    #     else
    #       return(paste0('Phone #: ',data$PHONE[data$NameId==input$Map_marker_click$id]))
    #   }
    # })


  })