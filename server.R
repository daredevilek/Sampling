library(shiny)
library(pracma) # library for the function nthroot
library(plyr)
require(plotly)
library(DT)

iA <- seq(0.001,0.040,0.0005)
s2 <- (log(1-0.085)/log(1-iA))/0.9
#tableSMP <- datatable(data.frame(iA,s2))

shinyServer(function(input, output, session) {

  #prawdopodobienstwo wykrycia
  probability1 <- function(){
    sampleN1 <- seq(input$mmNumber[1], input$mmNumber[2])
    probab1 <- 1-(1-input$infR*input$czTp)^sampleN1
    probabDF <- as.data.frame(cbind('p'= probab1, 'N' = sampleN1))
    tablePR <- DT::datatable(data.frame( 'N' = sampleN1, 'p'= probab1),
                             class = 'stripe hover dt-head-center order-column',
                             rownames = F, style = 'bootstrap')
    list(tabP = tablePR, prDF = probabDF)
    #list(pe1 = probab1, ne1 = sampleN1)
  }
  
  #minimalna wielkosc proby do wykrycia danego poziomu infekcyjnosci
  #z danym prawdopodobienstwem
  smp <- function(){
   infRa2 <- seq(input$mmInf[1], input$mmInf[2], 0.0005)
   sampleN2 <- (log(1-input$probaB)/log(1-infRa2))/input$czTn
   saN2 <- as.data.frame(cbind('N' = sampleN2, 'infekcje' = infRa2))
   tableSMP <- DT::datatable(data.frame('Częstość infekcji' = infRa2, 'N' = sampleN2),
                             class = 'stripe hover dt-head-center order-column',
                             rownames = F, style = 'bootstrap')
   list(tabN = tableSMP, saN = saN2)
   }
  
  #poziom inekcyjnosci wykrywany przy danej liczebosci proby
  #i danym prawdopodobienstwie wykrycia
  ratei <- function() {
  samN3 <- seq(1, input$sampleN3)
  infRa3 <- ((1-(nthroot((1-input$probaB3), samN3)))*1000)/input$czTg
  iR3 <- as.data.frame(cbind('Maks.L.Infekcji' = infRa3, 'N' = samN3))
  tableG <- DT::datatable(data.frame('N' = samN3, 'Graniczny poziom infekcji' = infRa3),
                          class = 'stripe hover dt-head-center order-column',
                          rownames = F, style = 'bootstrap')
  list(tabG = tableG, iR = iR3)
  }
  #zmienic warunki dla wykresow
  output$wykresP <- renderPlotly({
      plotDFP <- data.frame(probability1()$prDF)#xvar = probability1()$ne1, yvar = probability1()$pe1)
      theGraphP <- ggplot(plotDFP, aes(x = N, y = p )) + 
        geom_line(colour = '#E74B47') +
        labs(x = 'Wielkość próby', y = 'Prawdopodbieństwo wykrycia')
    ggplotly(theGraphP)
  })
  
  output$wykresN <- renderPlotly({
      plotDFN <- data.frame(smp()$saN)#xvar = smp()$infRa2, yvar = smp()$sampleN2)
      theGraphN <- ggplot(plotDFN, aes(x = N, y = infekcje)) + 
        geom_line(colour = '#E74B47') +
        labs(x = 'Częstość infekcji', y = 'Wielkość próby')
      ggplotly(theGraphN)
  })
  
  output$wykresG <- renderPlotly({
      plotDFG <- data.frame(ratei()$iR)#xvar = ratei()$samN3, yvar = ratei()$infRa3)
      theGraphG <- ggplot(plotDFG, aes(x = Maks.L.Infekcji, y = N)) +
        geom_line(colour = '#E74B47') +
        labs(x = 'Wielkość próby', y = 'Graniczna częstość infekcji (na 1000)')
      ggplotly(theGraphG)
  })
  
  output$tabelaP <- DT::renderDataTable ({
    probability1()$tabP
  })
  
  output$tabelaN <- DT::renderDataTable ({
    smp()$tabN
    })
  
  output$tabelaG <- DT::renderDataTable ({
    ratei()$tabG
  })
  #output$tabelaP
  #output$tabelaG
  #theGraph <- ggplot(plotDF, aes(x = xvar, y = yvar)) + geom_line()
})
