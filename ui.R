library(shiny)
library(pracma) # library for the function nthroot
library(dplyr)
require(plotly)
library(DT)

shinyUI(
  navbarPage(
    'Próbkowanie i prawdopodobieństwo',
    #includeCSS('sliders.css'), 
    theme = 'bootstrap.css', inverse = T, 
    #pierwzy tab----
    tabPanel(
      'Prawdopodobieństwo wykrycia',
      sidebarLayout(
        position = 'left',
        sidebarPanel(
          #slider czulosc----
          sliderInput(
            inputId = 'czTp',
            label = 'Czułość testu',
            min = 0.60, max = 1.00, value = 0.90,step = 0.05
            ),
          #slider poziom inf----
          sliderInput(
            inputId = "infR",
            label = "Poziom infekcji",
            min = 0.000, max = 0.0500, value = 0.0030, step = 0.0005, sep = ''
            ),
          #slider n proby----
          sliderInput(
            inputId = 'mmNumber',
            label = 'Liczebność próby (min - max)',
            min = 25, max = 3600, step = 25, value = c(200, 1000)
            ),
          br()),
          #main panel----
          mainPanel(tabsetPanel(
            tabPanel(
              title = "Wykres", 
              plotlyOutput(outputId = 'wykresP', height = '600px')),
            tabPanel(
              title = 'Tabela', DT::dataTableOutput('tabelaP')
              )))
        )),
    #drugi tab----
    tabPanel(
      'Min. wielkość próby',
      sidebarLayout(
        position = 'left',
        sidebarPanel(
          #slider czulosc----
          sliderInput(
            inputId = 'czTn',
            label = 'Czułość testu',
            min = 0.60, max = 1.00, value = 0.90,step = 0.05
            ),
          #slider p wykrycia----
          sliderInput(
            inputId = 'probaB',
            label = 'Prawdopodobieństwo wykrycia',
            min = 0.01, max = 1.00, value = 0.75, step = 0.01
            ),
          #slider p inf----
          sliderInput(
            inputId = 'mmInf',
            label = 'Poziom infekcji (min - max)',
            min = 0.000, max = 0.050, value = c(0.001, 0.030), step = 0.0005, sep = ''
            ),
          br()),
          #main panel----
          mainPanel(tabsetPanel(
            tabPanel(
              title = "Wykres", 
              plotlyOutput(outputId = 'wykresN', height = '600px')),
            tabPanel(
              title = 'Tabela', DT::dataTableOutput('tabelaN')
              )))
        )),
    #trzeci tab----
    tabPanel(
      'Graniczna wielkość infekcji', 
      sidebarLayout(
        position = 'left',
        sidebarPanel(
          #slider czulosc----
          sliderInput(
            inputId = 'czTg',
            label = 'Czułość testu',
            min = 0.60, max = 1.00, value = 0.90,step = 0.05
          ),
          #Slider ProbaB3----
          sliderInput(
            inputId = "probaB3",
            label = "Prawdopodobieństwo wykrycia",
            min = 0.500, max = 1.000, value = 0.800, step = 0.005
          ),
          #slider SampleN3----
          sliderInput(
            inputId = 'sampleN3',
            label = 'Liczebność próby',
            val = 800, min = 0, max = 4000, step = 25
        ),
        br()),
        #main panel----
      mainPanel(tabsetPanel(
        tabPanel(
          title = "Wykres", 
          plotlyOutput(outputId = 'wykresG', height = '600px')),
        tabPanel(
          title = 'Tabela', DT::dataTableOutput('tabelaG')
        )))
    )),
    #footer----
    tags$div(class = 'panel-footer', style = 
                'position: fixed; display: block;
                bottom: 5px; width = 100%',  
                tags$p('Aplikacja zbudowana w', a('Shiny', href = 'http://www.rstudio.com/shiny'),
                  'dla', a('R Studio', href = 'http://www.rstudio.com') , 'na podstawie',
                  a('kodu Renke Luekhen.', href = 'https://goo.gl/FopD9R')
                ))))
    
    
    