library(shiny)
library(shinydashboard)
library(readxl)
library(FactoMineR)
library(ggplot2)
library(ggrepel)


function(input, output) {

  datglobal <- reactiveValues()

  output$correspondencias <- renderPlot({
    
    datos <- NULL
    inFile1 <- input$file1
    tipo1 <- inFile1$type 
    
    if (!is.null(inFile1)) {
      if(tipo1 == "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet") {
        file.rename(inFile1$datapath, paste(inFile1$datapath, ".xlsx", sep=""))
        datos <- as.data.frame(read_excel(paste(inFile1$datapath, ".xlsx", sep=""), 1))
      } 
      else {
        file.rename(inFile1$datapath, paste(inFile1$datapath, ".xls", sep=""))
        datos <- as.data.frame(read_excel(paste(inFile1$datapath, ".xls", sep=""), 1))
      }
    }
    
    rownames(datos) <- datos[,1]
    datos <- datos[,-1]
    
    acor <- CA(datos, graph = FALSE)
    
    filas <- as.data.frame(acor$row$coord[,1:2])
    filas$dimension <- "filas"
    columnas <- as.data.frame(acor$col$coord[,1:2])
    columnas$dimension <- "columnas"
    
    grafico <- rbind(filas,columnas)
    names(grafico) <- c("x","y","dimension")
    porcx <- round(acor$eig[1,2],2)
    porcy <- round(acor$eig[2,2],2)
    
    mapacor <- ggplot(grafico, aes(x, y, label=row.names(grafico))) +
      geom_hline(yintercept=0, color="darkgrey") +
      geom_vline(xintercept=0, color="darkgrey") +
      ggtitle("Mapa de Correspondencias") +  
      ylab(paste0("Contribucion Dimension 2: ",porcy,"%")) +
      xlab(paste0("Contribucion Dimension 1: ",porcx,"%"))
    
    if (input$tema == 1) {mapacor <- mapacor + theme_gray()}
    if (input$tema == 2) {mapacor <- mapacor + theme_bw()}
    if (input$tema == 3) {mapacor <- mapacor + theme_void()}
    
    if (input$bolatexto == 1 | input$bolatexto == 3) {mapacor <- mapacor + geom_point(size=(input$tm_bola)/10, colour="#777777", alpha=0.5)}
    if (input$bolatexto == 1 | input$bolatexto == 2) {mapacor <- mapacor + scale_colour_manual(values=c(input$col1, input$col2)) +
      geom_label_repel(size=(input$tm_texto)/10, aes(colour = dimension))}
        
    mapacor <- mapacor + 
      theme(axis.text.x = element_blank()) + 
      theme(axis.text.y = element_blank()) +
      theme(axis.ticks.x = element_blank()) +
      theme(axis.ticks.y = element_blank()) +
      theme(legend.position="none")
    
    print(mapacor)

  })
    
}