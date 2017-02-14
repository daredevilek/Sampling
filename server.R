library(shiny)
library(pracma) # library for the function nthroot
library(plyr)
library(ggplot2)

cz1 <- c(0.9) #czulosc


shinyServer(function(input, output, session) {

  #prawdopodobienstwo wykrycia
# cz1 <- reactive({
# cz1 <- c(input$czT) #czulosc
# })
  pr <- function(){
    n1 <- seq(input$minNumber, input$maxNumber)
    p1 <- 1-(1-input$infR*cz1)^n1
    list(pe1 = p1, ne1 = n1)
  }
  
  #minimalna wielkosc proby do wykrycia danego poziomu infekcyjnosci
  #z danym prawdopodobienstwem
  #inf2<-seq(0.001,0.003,0.001) # liczba infekcji
  #p2<-0.75 # prawdopodobienstwo wykrycia
  #n2 = log(1-P1)/log(1-r)
  #p3<-0.8 # detection probability
  #n3 = log(1-P2)/log(1-r)
  #p4<-0.9
  #n4 = log(1-P3)/log(1-r)
  
  #poziom inekcyjnosci wykrywany przy danej liczebosci proby
  #i danym prawdopodobienstwie wykrycia
  #n5<-seq(1:1000)
  #p5<-0.8
  #upInf<-(1-(nthroot((1-p5),n5)))*1000
  #p6<-0.95
  #upInf_2<-(1-(nthroot((1-p6),n5)))*1000
  
  output$wykres <- renderPlot({
    plot(pr()$pe1~pr()$ne1,
         ylim = c(0,1),
         xlab = 'Wielkość próby',
         ylab = 'Prawdopodobieństwo wykrycia',
         type = 'l')
  })
})
