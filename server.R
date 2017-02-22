library(shiny)
library(pracma) # library for the function nthroot
library(dplyr)
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
  #wykresy----
  output$wykresP <- renderPlotly({
      plotDFP <- data.frame(probability1()$prDF)
      hovertxtp <- paste("p: ", round(plotDFP$p, digits = 2), "<br>",
                         "N: ", plotDFP$N)
      theGraphP <- plotDFP %>% plot_ly(x = ~N,
                                       hoverinfo = 'text', text = hovertxtp) %>%
                               add_lines(y = ~p, color = '#E74B74') %>%          
                               layout(xaxis = list(title = 'Wielkość próby'),
                               yaxis = list(title = 'Prawdopodobieństwo wykrycia',
                                            tickangle = -30))
  })
  
  output$wykresN <- renderPlotly({
      plotDFN <- data.frame(smp()$saN)
      hovertxtn <- paste("N: ", ceiling(plotDFN$N), "<br>",
                         "infekcje: ", round(plotDFN$infekcje, digits = 4))
      theGraphN <- plotDFN %>% plot_ly(x = ~infekcje,
                                       hoverinfo = 'text', text = hovertxtn) %>% 
                               add_lines(y=~N, name = 'linia',
                                         color = '#E74B74') %>%          
                               layout(xaxis = list(title = 'Poziom infekcji'),
                                      yaxis = list(title = 'Wielkość próby',
                                                   tickangle = -30))
      })
  
  output$wykresG <- renderPlotly({
      
      plotDFG <- data.frame(ratei()$iR)
      hovertxtg <- paste("infekcje: ", round(plotDFG$Maks.L.Infekcji, digits = 0),
                      "<br>", "N: ", ceiling(plotDFG$N))
      theGraphG <- plotDFG %>% plot_ly(x = ~N,
                                       hoverinfo = 'text', text = hovertxtg) %>% 
                               add_lines(y = ~Maks.L.Infekcji, color = '#e74b74') %>%
                               layout(xaxis = list(title = 'Wielkość próby'),
                                      yaxis = list(title = 'Graniczny poziom infekcji (na 1000)',
                                                   tickangle = -30))
  })
  
  #tabele----
  output$tabelaP <- DT::renderDataTable ({
    probability1()$tabP
  })
  
  output$tabelaN <- DT::renderDataTable ({
    smp()$tabN
    })
  
  output$tabelaG <- DT::renderDataTable ({
    ratei()$tabG
  })
})
