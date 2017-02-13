library(shiny)

shinyUI(fluidPage(theme = 'bootstrap.css',
  titlePanel("Próbkowanie i Prawdopodobieństwo"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(position = 'left',
    sidebarPanel(
      radioButtons(inputId = 'analyseType',
                   label = 'Wybierz typ analizy',
                   choices = list('Prawdopodobieństwo wykrycia' = "pVal",
                                  'Min. wielkość próby' = 'mWP',
                                  'Graniczny poziom infekcyjności' = 'gPI')
                         ),
      sliderInput(inputId = "probaB",
                  label = "Prawdopodobieństwo wykrycia",
                  min = 0.01,
                  max = 1.00,
                  value = 0.75),
      sliderInput(inputId = "infR",
                  label = "Poziom infekcji",
                  min = 0.0001,
                  max = 0.50,
                  value = 0.01),
      numericInput(InputId = 'minNumber',
                   label = 'Minimalna liczebność próby', min = 200),
      numericInput(InputId = 'maxNumber',
                   label = 'Maksymalna liczebność próby', max = 4000),
      
    br(),
    p('Aplikacja zbudowana w', 
      a('Shiny', href = 'http://www.rstudio.com/shiny'), 'dla', 
      a('R Studio', href = 'http://www.rstudio.com')),
    p('na podstawie', a('kodu Renke Luekhen.', 
                        href = 'https://goo.gl/FopD9R'))
    ),

    # Show a plot of the generated distribution
    mainPanel(
      tabsetPanel(
      tabPanel('Tabela'),
      plotOutput("distPlot"))
    )
  )
))
