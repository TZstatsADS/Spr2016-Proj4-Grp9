dbHeader<-dashboardHeader(title='Popcorn Time')

dashboardPage(

    skin="red",
  
  dbHeader,

  dashboardSidebar(
    sidebarMenu(id='sidebarmenu',
                menuItem("Recommendation",tabName="recomm",icon=icon("pie-chart"))#,      
                ),
    
    selectInput("moviesLiked","Movies you liked:",levels(amzData$Name),'Apocalypse Now',multiple=T),
    submitButton("Submit",width='100%')
   
    
    ),
              
  dashboardBody(
    includeCSS('./www/custom.css'),
    tabItems(
      
      
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
                           br(),
                           textOutput("Rec1Rating"),
                           textOutput("Rec1Reviews"),
                           br(),
                           imageOutput("rec1wc"),
                           textOutput("Rec1BotReviewTitle"),
                           textOutput("Rec1BotReview"),
                           br(),
                           textOutput("Rec1TopReviewTitle"),
                           textOutput("Rec1TopReview")
                           )
                       ),
                column(width=4,
                       box(title = "Second Recommendation", status = "primary",
                           width=NULL,solidHeader=T,
                           textOutput("Rec2Name"),
                           br(),
                           uiOutput('Rec2image'),
                           br(),
                           textOutput("Rec2Rating"),
                           textOutput("Rec2Reviews"),
                           imageOutput("rec2wc"),
                           textOutput("Rec2BotReviewTitle"),
                           textOutput("Rec2BotReview"),
                           br(),
                           textOutput("Rec2TopReviewTitle"),
                           textOutput("Rec2TopReview")
                       )
                ),
                column(width=4,
                       box(title = "Third Recommendation", status = "primary",
                           width=NULL,solidHeader=T,
                           textOutput("Rec3Name"),
                           br(),
                           uiOutput('Rec3image'),
                           br(),
                           textOutput("Rec3Rating"),
                           textOutput("Rec3Reviews"),
                           imageOutput("rec3wc"),
                           textOutput("Rec3BotReviewTitle"),
                           textOutput("Rec3BotReview"),
                           br(),
                           textOutput("Rec3TopReviewTitle"),
                           textOutput("Rec3TopReview")
                       )
                )
                )
      )
    )

  )
)

