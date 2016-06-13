library(FactoMineR)
library(ggplot2)
library(ggrepel)
library(readxl)

datos <- as.data.frame(read_excel("ejemplo CA.xlsx", 1))
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

ggplot(grafico, aes(x, y, label=row.names(grafico))) +
  geom_hline(yintercept=0, color="darkgrey") +
  geom_vline(xintercept=0, color="darkgrey") +
  geom_point(size=1.75, colour="#777777") +
  guides(alpha=FALSE) + 
  scale_colour_manual(values=c("#D11919","black")) +
  geom_label_repel(size=4, aes(colour = dimension)) +
  ggtitle("Mapa de Correspondencias") +  
  ylab(paste0("Contribucion: ",porcy,"%")) +
  xlab(paste0("Contribucion: ",porcx,"%")) +
  theme(axis.text.x = element_blank()) + 
  theme(axis.text.y = element_blank()) +
  theme(axis.ticks.x = element_blank()) +
  theme(axis.ticks.y = element_blank())

