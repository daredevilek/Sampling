library(shiny)
library(pracma) # library for the function nthroot
library(plyr)
require(plotly)

#cz1 <- c(0.9) #czulosc


shinyServer(function(input, output, session) {

  #prawdopodobienstwo wykrycia
  probability1 <- function(){
    sampleN1 <- seq(input$mmNumber[1], input$mmNumber[2])
    probab1 <- 1-(1-input$infR*input$czT)^sampleN1
    list(pe1 = probab1, ne1 = sampleN1)
  }
  
  #minimalna wielkosc proby do wykrycia danego poziomu infekcyjnosci
  #z danym prawdopodobienstwem
  smp <- function(){
   infRa2 <- seq(input$mmInf[1], input$mmInf[2], 0.0005)
   sampleN2 <- (log(1-input$probaB)/log(1-infRa2))/input$czT
   saN2 <-as.data.frame(cbind(sampleN2,infRa2))
  }
  
  #poziom inekcyjnosci wykrywany przy danej liczebosci proby
  #i danym prawdopodobienstwie wykrycia
  ratei <- function() {
  samN3 <- seq(1, input$sampleN3)
  infRa3 <- ((1-(nthroot((1-input$probaB3), samN3)))*1000)/input$czT
  iR3 <- as.data.frame(cbind(infRa3, samN3))
  }
  #zmienic warunki dla wykresow
  output$wykresP <- renderPlotly({
    if(input$analyseType == "pVal"){
      plotDF <- data.frame(xvar = probability1()$ne1, yvar = probability1()$pe1)
      theGraph <- ggplot(plotDF, aes(x = xvar, y = yvar)) + 
        geom_line() +
        labs(x = 'Wielkość próby', y = 'Prawdopodbieństwo wykrycia')
      }
    
    else if(input$analyseType == "mWP"){
      plotDF <- data.frame(xvar = smp()$infRa2, yvar = smp()$sampleN2)
      theGraph <- ggplot(plotDF, aes(x = xvar, y = yvar)) + 
        geom_line() +
        labs(x = 'Częstość infekcji', y = 'Wielkość próby')
      }
    
    else{
      plotDF <- data.frame(xvar = ratei()$samN3, yvar = ratei()$infRa3)
      theGraph <- ggplot(plotDF, aes(x = xvar, y = yvar)) +
        geom_line() +
        labs(x = 'Wielkość próby', y = 'Graniczna częstość infekcji (na 1000)')
      }
      
    #theGraph <- ggplot(plotDF, aes(x = xvar, y = yvar)) + geom_line()
    ggplotly(theGraph)
    #if (input$analyseType == 'pVal') {
    #plot(probability1()$pe1~probability1()$ne1,
    #     ylim = c(0,1),
    #     xlab = 'Wielkość próby',
    #     ylab = 'Prawdopodobieństwo wykrycia',
    #     type = 'l')
    #abline(h = 0.95, col = 'red', lty = c(3))
    #}
    #if (input$analyseType == 'mWP') {
    #plot(smp()$sampleN2~smp()$infRa2,
    #     xlab = 'Poziom infekcji',
    #     ylab = 'Minimalna wielkość próby',
    #     type = 'l')
    #}
    #if (input$analyseType == 'gPI') {
    #  plot(ratei()$infRa3~ratei()$samN3,
    #       xlab = 'Liczebność próby',
    #       ylab = 'Graniczny poziom infekcji',
    #       type = 'l')
    #}
  })
})
