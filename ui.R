library(shiny)
library(pracma) # library for the function nthroot
library(plyr)
require(plotly)

shinyUI(fluidPage(theme = 'bootstrap.css',
  titlePanel("Próbkowanie i prawdopodobieństwo"),

  # Sidebar with a slider input for number of bins
  sidebarLayout(position = 'left',
    sidebarPanel(
      radioButtons(inputId = 'analyseType',
                   label = 'Wybierz typ analizy',
                   choices = list('Prawdopodobieństwo wykrycia' = "pVal",
                                  'Min. wielkość próby' = 'mWP',
                                  'Graniczny poziom infekcyjności' = 'gPI')),
      sliderInput(inputId = "czT",
                  label = "Czułość testu",
                  min = 0.6, max = 1, value = 0.9, step = 0.05),
      conditionalPanel(condition = "input.analyseType == 'mWP'", 
        sliderInput(inputId = "probaB",
            label = "Prawdopodobieństwo wykrycia",
            min = 0.01, max = 0.999, value = 0.75),
        numericInput(inputId = "minInf",
                     label = "Minimalny poziom infekcji",
                     min = 0, max = 0.05, value = 0.001),
        numericInput(inputId = "maxInf",
                     label = "Maksymalny poziom infekcji",
                     min = 0, max = 0.05, value = 0.03)),
      conditionalPanel(condition = "input.analyseType == 'pVal'", 
        sliderInput(inputId = "infR",
                    label = "Poziom infekcji",
                    min = 0, max = 0.05, value = 0.003, step = 0.0005),
        numericInput(inputId = 'minNumber',
                     label = 'Minimalna liczebność próby',
                     val = 200, min = 0),
        numericInput(inputId = 'maxNumber',
                     label = 'Maksymalna liczebność próby (max. 3600)',
                     val = 2200, max = 3600)),
      conditionalPanel(condition = "input.analyseType == 'gPI'", 
        sliderInput(inputId = "probaB3",
                    label = "Prawdopodobieństwo wykrycia",
                    min = 0.5, max = 1, value = 0.8, step = 0.005),
        sliderInput(inputId = 'sampleN3',
                     label = 'Liczebność próby',
                     val = 800, min = 0, max = 4000)),
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
      #tabPanel(title = 'tabela', tableOutput('no_name_yet2'), value = 'tabela'),
      tabPanel(title = "Wykres",
               plotlyOutput(outputId = 'wykresP', height = '600px')
      #tabPanel(title ='Wykres',
      #         plotOutput(outputId = 'wykresS', height = '600px')))
    )
  )
))))
