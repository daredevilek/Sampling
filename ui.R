library(shiny)

shinyUI(fluidPage(theme = 'bootstrap.css',
  titlePanel("Próbkowanie i Prawdopodobieństwo"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(position = 'left',
    sidebarPanel(
      #radioButtons(inputId = 'analyseType',
       #            label = 'Wybierz typ analizy',
        #           choices = list('Prawdopodobieństwo wykrycia' = "pVal",
         #                         'Min. wielkość próby' = 'mWP',
          #                        'Graniczny poziom infekcyjności' = 'gPI')
           #              ),
      #sliderInput(inputId = "probaB",
      #            label = "Prawdopodobieństwo wykrycia",
      #            min = 0.01,
      #            max = 1.00,
      #            value = 0.75),
      sliderInput(inputId = "infR",
                  label = "Poziom infekcji",
                  min = 0,
                  max = 0.05,
                  value = 0.01,
                  step = 0.0005),
      #sliderInput(inputId = "czT",
      #            label = "wykrywalność w teście",
      #            min = 0.6,
      #            max = 1,
      #            value = 0.9),
      numericInput(inputId = 'minNumber',
                   label = 'Minimalna liczebność próby', val = 200, min = 0),
      numericInput(inputId = 'maxNumber',
                   label = 'Maksymalna liczebność próby', val = 600, max = 3600),
      
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
      #tabPanel(title = 'tabela', tableOutput('no_name_yet2')),
      tabPanel(title = "Wykres", plotOutput(outputId = 'wykres', height = '600px')))
    )
  )
))
