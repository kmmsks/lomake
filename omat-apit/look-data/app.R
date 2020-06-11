library(shiny)
library(here)
library(data.table)


prop_location <- here('data', 'proposals')

input <- lapply(list.files(path=prop_location, full.names=TRUE), fread, header = TRUE)
input <- rbindlist(input)
set.seed(1)
input[,more_info:=replicate(nrow(input), paste(sample(x = LETTERS, size = 100, replace = TRUE), collapse = ""))]

input[1, author]

for (a in input[,author]){
  for (ty in  input[,prop_type]){
    #print(paste(ty,a, sep = '-'))
    print(ty)
  }
}

input[,author,prop_type]

ui <- fluidPage(
  
  div(id = "header",
      h1("Testilomake"),
      h4("Luetaan csv-tauluja ja niita voi kommentoida."
      ),
      strong( 
        span("Leipäteksti"),
        a("Linkki", href = "http://www.google.com"),
        #HTML("&bull;"),
      )
  ),
  titlePanel("Toinen Application Title"),
  #navlistPanel('otsikko', tabPanel('taso1', 'sisalto'))
  uiOutput('mytabs')
  #
  
  
)


server = function(input, output, session){
  output$mytabs = renderUI({
    #Tabs = datInput[,author]
    #cont = 
    myTabs = apply(datInput, 1, function (x) tabPanel(x['author'], x['opinion']))
    #myTabs = mapply(tabPanel, Tabs, 'sisalto')
    do.call(navlistPanel, list(myTabs))
  })
}


shinyApp(ui = ui, server = server)


nTabs = length(myPlots); 
myTabs = lapply(1:nTabs, function(x){tabPanel(paste0("Tab ",x), renderPlot(myPlots[[x]]))}); 
do.call(tabsetPanel, myTabs)
