library(shiny)
library(pracma) # library for the function nthroot
library(plyr)
library(ggplot2)

#cz1 <- c(0.9) #czulosc


shinyServer(function(input, output, session) {

  #prawdopodobienstwo wykrycia
  probability1 <- function(){
    sampleN1 <- seq(input$minNumber, input$maxNumber)
    probab1 <- 1-(1-input$infR*input$czT)^sampleN1
    list(pe1 = probab1, ne1 = sampleN1)
  }
  
  #minimalna wielkosc proby do wykrycia danego poziomu infekcyjnosci
  #z danym prawdopodobienstwem
  smp <- function(){
   infRa2 <- seq(input$minInf, input$maxInf, 0.0005)
   sampleN2 <- (log(1-input$probaB)/log(1-infRa2))/input$czT
   saN2 <-as.data.frame(cbind(sampleN2,infRa2))
  }
  
  #poziom inekcyjnosci wykrywany przy danej liczebosci proby
  #i danym prawdopodobienstwie wykrycia
  #n5<-seq(1:1000)
  #p5<-0.8
  #upInf<-(1-(nthroot((1-p5),n5)))*1000
  #p6<-0.95
  #upInf_2<-(1-(nthroot((1-p6),n5)))*1000
  
  output$wykresP <- renderPlot({
    if (input$analyseType == 'pVal') {
    plot(probability1()$pe1~probability1()$ne1,
         ylim = c(0,1),
         xlab = 'Wielkość próby',
         ylab = 'Prawdopodobieństwo wykrycia',
         type = 'l')
    abline(h = 0.95, col = 'red', lty = c(3))
    }
    #output$wykresN <- renderPlot({
    if (input$analyseType == 'mWP') {
    plot(smp()$sampleN2~smp()$infRa2,
         xlab = 'Poziom infekcji',
         ylab = 'Minimalna wielkość próby',
         type = 'l')
    }
  })
})
