library(FactoMineR)
library(ggplot2)
library(ggrepel)
library(readxl)

grafico <- as.data.frame(read_excel("ejemplo XY.xlsx", 1))
names(grafico) <- c("etiqueta","x","y","dimension")


ggplot(grafico, aes(x, y, label=row.names(grafico))) +
  geom_hline(yintercept=mean(grafico$y), color="darkgrey") +
  geom_vline(xintercept=mean(grafico$x), color="darkgrey") +
  geom_point(size=2, aes(colour=dimension)) +
  geom_label_repel(size=4, force=5, aes(label=etiqueta, colour = dimension)) +
  theme(axis.text.x = element_blank()) + 
  theme(axis.text.y = element_blank()) +
  theme(axis.ticks.x = element_blank()) +
  theme(axis.ticks.y = element_blank())



ggplot(grafico, aes(x, y, label=row.names(grafico))) +
  geom_hline(yintercept=mean(grafico$y), color="darkgrey") +
  geom_vline(xintercept=mean(grafico$x), color="darkgrey") +
  geom_point(size=3, alpha=0.75, colour="darkgrey") +
  geom_label_repel(size=4, force=5, aes(label=etiqueta, colour = dimension)) +
  theme(axis.ticks.x = element_blank()) +
  theme(axis.ticks.y = element_blank())
