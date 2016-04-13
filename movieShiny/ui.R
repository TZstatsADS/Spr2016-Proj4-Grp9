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
    
    selectInput("moviesLiked","Movies you liked:",levels(amzData$Name),'Apocalypse Now',multiple=T),
    # sliderInput("minReview","Minimum # of reviews on Yelp",min = 1, max = 100, value = 1),
    # sliderInput("minStar","Minimum # of stars on Yelp",min = 1, max = 5, value = 1),
    # sliderInput("minSafetyScore","Minimum safety score",min = 0, max = 1, value = 0),
    submitButton("Submit",width='100%')
   
    
    ),
              
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
                column(width=4,
                       box(title = "First Recommendation", status = "primary",
                           width=NULL,solidHeader=T,
                           textOutput("Rec1Name"),
                           br(),
                           uiOutput('Rec1image'),
                           imageOutput("rec1wc")
                           )
                       ),
                column(width=4,
                       box(title = "Second Recommendation", status = "primary",
                           width=NULL,solidHeader=T,
                           textOutput("Rec2Name"),
                           br(),
                           uiOutput('Rec2image'),
                           imageOutput("rec2wc")
                       )
                ),
                column(width=4,
                       box(title = "Third Recommendation", status = "primary",
                           width=NULL,solidHeader=T,
                           textOutput("Rec3Name"),
                           br(),
                           uiOutput('Rec3image'),
                           imageOutput("rec3wc")
                       )
                )
                )#,
              # fluidRow(column(width=5,
              #                 selectInput("nameId","Restaurant Id",c("",sort(uniqueRestau5$NameId)),
              #                             selected="",multiple=F,width="100%")))
              # )
      )
    )

  )
)

