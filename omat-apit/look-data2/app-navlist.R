

## https://www.statworx.com/at/blog/dynamic-ui-elements-in-shiny/


library(shiny)
library(shinydashboard)
library(glue)



prop_location <- here('data', 'proposals')

datInput <- lapply(list.files(path=prop_location, full.names=TRUE), fread, header = TRUE)
datInput <- rbindlist(datInput)
set.seed(1)
datInput[,more_info:=replicate(nrow(input), paste(sample(x = LETTERS, size = 100, replace = TRUE), collapse = ""))]


ui <- dashboardPage(
  dashboardHeader(),
  
  dashboardSidebar(
    sliderInput(inputId = "slider", label = NULL, min = 1, max = 5, value = 3, step = 1)
  ),
  
  dashboardBody(
    fluidRow(
      box(width = 12,
          p(mainPanel(width = 12,
                      #column(width = 6, uiOutput("reference")),
                      column(width = 12, uiOutput("comparison"))
          )
          )
      )
    )
  )
)


server <- function(input, output) {
  
  output$reference <- renderUI({
    tabsetPanel(
      tabPanel(
        "Reference",
        h3("Reference Content"))
    )
  })
  
  output$comparison <- renderUI({
    req(input$slider)
    
    myTabs <- lapply(1: nrow(datInput), function(i) {
      
      tabPanel(title = datInput[i, author],
               h3(datInput[i, opinion])
      )
    })
    do.call(tabsetPanel, myTabs)
  })
}

shinyApp(ui = ui, server = server)

###

ui <- fluidPage(
  
  fluidRow(
    box(width = 12,
        p(mainPanel(width = 12,
                    column(width = 6, uiOutput("reference")),
                    column(width = 6, uiOutput("comparison"))
        )
        )
    )
  )
)

ui <- fluidPage(
  titlePanel('Otsikko_blaa'),
  fluidRow(
    column(width = 10, uiOutput("comparison"))
  )
)


server <- function(input, output) {
  
  output$reference <- renderUI({
    tabsetPanel(
      tabPanel(
        "Reference",
        h3("Reference Content"))
    )
  })
  
  output$comparison <- renderUI({
    #req(input$slider)
    
    myTabs <- lapply(1: nrow(datInput), function(i) {
      
      tabPanel(title = paste(datInput[i, author],datInput[i, opinion], sep = ' : ' ),
               h2(paste0("Author: ",datInput[i, author])),
               h2(paste0("Author's opinioin is: ",datInput[i, opinion])),
               h3(paste0('Synopsis: ', datInput[i, synopsis])),
               div(paste0('More info: ', datInput[i, more_info]))
      )
    })
    do.call(navlistPanel, myTabs)
  })
}


shinyApp(ui = ui, server = server)
#













###

textInputFUN <- function(uid) {
  fluidRow(
    column(6,
           textInput(paste0("par_", uid), label = paste0("par_", uid))
    ),
    column(6,
           textInput(paste0("par_", uid+1), label = paste0("par_", uid+1))
    )
  )
}

input_rows <- 15
input_ids <- seq(1, input_rows*2, by = 2)

shinyApp(
  ui = fluidPage(
    sidebarLayout(
      sidebarPanel(
        lapply(seq_len(input_rows), function(x) {
          textInputFUN(uid = input_ids[x])
        })
      ),
      mainPanel(
        verbatimTextOutput("test")
      )
    )
  ),
  server = function(input, output, session) {
    output$test <- renderPrint({
      sapply(paste0("par_", seq_len(input_rows*2)), function(x) input[[x]])
    })
  }
)
