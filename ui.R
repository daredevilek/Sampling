library(shiny)

shinyUI(fluidPage(theme = 'bootstrap.css',
  titlePanel("Próbkowanie i Prawdopodobieństwo"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(position = 'left',
    sidebarPanel(
      sliderInput("bins",
                  "Number of bins:",
                  min = 1,
                  max = 50,
                  value = 30),
    br(),
    p('Aplikacja zbudowana w', 
      a('Shiny', href = 'http://www.rstudio.com/shiny'), 'dla', 
      a('R Studio', href = 'http://www.rstudio.com')),
    p('na podstawie', a('kodu Renke Luekhen.', 
                        href = 'https://rstudio-pubs-static.s3.amazonaws.com/98526_15da936c6bab41c6bc4ccd0fbbf2cfb1.html'))
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
      tabPanel('Tabela'),
      plotOutput("distPlot"))
    )
  )
))
