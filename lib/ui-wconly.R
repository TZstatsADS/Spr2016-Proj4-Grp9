


dbHeader<-dashboardHeader(title='Movie Recommendation')

dashboardPage(

    skin="red",
  
  dbHeader,

  dashboardSidebar(
    sidebarMenu(id='sidebarmenu',
                menuItem("Recommendation",tabName="recomm",icon=icon("pie-chart"))#,
                # menuItem("Restaurant Locator",tabName="locator",icon=icon("beer"))
    ),
    
    # textInput("location","Your location:",'Columbia University NY, NYC'),
    # sliderInput("distance","Max dist from your location (mi)",
    #             min = 1, max = 21, value = 1),
    
    selectInput("moviesLiked","Movies you liked:",levels(amzData$Name),'Apocalypse Now',multiple=T)#,
    # sliderInput("minReview","Minimum # of reviews on Yelp",min = 1, max = 100, value = 1),
    # sliderInput("minStar","Minimum # of stars on Yelp",min = 1, max = 5, value = 1),
    # sliderInput("minSafetyScore","Minimum safety score",min = 0, max = 1, value = 0),
    #submitButton("Submit",width='100%')
   
    
    ),
  
  
  # url<-read_html("http://www.amazon.com/exec/obidos/ASIN/B00871C0DO")
#   
#   url = htmlParse(getURLContent("http://www.amazon.com/exec/obidos/ASIN/B00871C0DO",useragent="Mozilla/5.0 (Linux; Android 5.0.2; HTC One_M8 Build/LRX22G) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/48.0.2564.48 Mobile Safari/537.36"))
#   
#   
#   
#   src=gsub('.*src=\\\"|\".*','',
#            as.character(html_nodes(url,xpath="//div[@data-key='1']//div[@class='photo-box pb-90s']")))
#   html_nodes(url,xpath="//div[@class='imgTagWrapper']")
#   
              
  dashboardBody(
    includeCSS('./www/custom.css'),
    tabItems(
      
      # tabItem(tabName = "recomm",
      #         fluidRow(
      #           column(width=12,
      #                  box(width=NULL,
      #                      title=tagList(shiny::icon("pie-chart"),"Cuisine distribution at your location"),
      #                      status='primary',
      #                      collapsible=T,
      #                      showOutput("pieChart","highcharts")
      #                  )))),
      
      tabItem(tabName='recomm',
              fluidRow(
                # column(width = 7,
                #        box(width = NULL, solidHeader = TRUE,
                #            leafletOutput("Map"))),
                column(width=5,
                       box(title = "Selected Restaurant", status = "primary",
                           width=NULL,solidHeader=T,
                           #textOutput("clickedName"),
                           br(),
                           #uiOutput('image'),
                           br()
                           # textOutput("clickedNameAddress"),
                           # textOutput("clickedNameGrade"),
                           # textOutput("clickedNameCritical"),
                           # textOutput("clickedNameRating"),
                           # textOutput("clickedNameReviewCount"),
                           # textOutput("clickedNamePriceRange"),
                           # textOutput("clickedNamePhone")
                           )
                       )
                )#,
              # fluidRow(column(width=5,
              #                 selectInput("nameId","Restaurant Id",c("",sort(uniqueRestau5$NameId)),
              #                             selected="",multiple=F,width="100%")))
              # )
      )
    ),
    
    
    imageOutput("wc")
    

  )
)

