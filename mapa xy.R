library(FactoMineR)
library(ggplot2)
library(ggrepel)
library(readxl)

grafico <- as.data.frame(read_excel("ejemplo XY.xlsx", 1))
etiquetax <- names(grafico)[2]
etiquetay <- names(grafico)[3]
names(grafico) <- c("etiqueta","x","y","dimension")

output <- ggplot(grafico, aes(x, y, label=row.names(grafico))) +
  geom_hline(yintercept=mean(grafico$y), color="darkgrey") +
  geom_vline(xintercept=mean(grafico$x), color="darkgrey") +
  #scale_colour_brewer() +
  geom_point(size=3, aes(colour=dimension)) +
  geom_label_repel(size=4, force=5, aes(label=etiqueta, colour = dimension)) +
  theme_minimal() +
  theme(axis.ticks.x = element_blank()) +
  theme(axis.ticks.y = element_blank()) +
  
  #theme(panel.border = element_rect(fill = NA, colour = "lightgray", size = 0.5)) +
  theme(panel.grid.major = element_blank()) +
  theme(panel.grid.minor = element_blank()) +
  theme(panel.border = element_blank())
  
print(output)
