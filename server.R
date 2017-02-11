library(shiny)
library(pracma) # library for the function nthroot


shinyServer(function(input, output, session) {

  #prawdopodobienstwo wykrycia
  n1 <- c(400,600,800) # wielkosc probki
  cz1 <- c() #czulosc
  inf1 < -c()/cz # infekcje
  p1 <- 1-(1-r1*a)^N
  
  #minimalna wielkosc proby do wykrycia danego poziomu infekcyjnosci
  #z danym prawdopodobienstwem
  inf2<-seq(0.001,0.003,0.001) # liczba infekcji
  p2<-0.75 # prawdopodobienstwo wykrycia
  n2 = log(1-P1)/log(1-r)
  p3<-0.8 # detection probability
  n3 = log(1-P2)/log(1-r)
  p4<-0.9
  n4 = log(1-P3)/log(1-r)
  
  #poziom inekcyjnosci wykrywany przy danej liczebosci proby
  #i danym prawdopodobienstwie wykrycia
  n5<-seq(1:1000)
  p5<-0.8
  upInf<-(1-(nthroot((1-p5),n5)))*1000
  p6<-0.95
  upInf_2<-(1-(nthroot((1-p6),n5)))*1000
  
  output$distPlot <- renderPlot({

    # generate bins based on input$bins from ui.R
    #x    <- faithful[, 2]
    #bins <- seq(min(x), max(x), length.out = input$bins + 1)

    # draw the histogram with the specified number of bins
    #hist(x, breaks = bins, col = 'darkgray', border = 'white')

  })

})
