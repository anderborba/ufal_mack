# Bar metrics Classificacao
rm(list = ls())
library(ggplot2)
require(ggthemes)
require(latex2exp)
library(hrbrthemes)
require(extrafont)
loadfonts()
#
setwd("..")
setwd("Data")
mat <- scan('metricas_classificacao.txt')
setwd("..")
setwd("Code_r")
mat <- matrix(mat,  ncol = 9, byrow = TRUE)
nk <- 9
eixo  <- seq(0, nk - 1, 1)
eixo <- c("MLE-Ihh","MLE-Ihv","MLE-Ivv", "F-Med", "F-PCA", "F-MR-SWT", "F-MR-DWT", "F-ROC", "F-MR-SVD")
v1  <- seq(0, nk - 1, 1)
v2  <- seq(0, nk - 1, 1)
v3  <- seq(0, nk - 1, 1)
for(k in 1: nk){
  v1[k] <- mat[1, k]
  v2[k] <- mat[2, k]
  v3[k] <- mat[3, k]
}
df <- data.frame(x = eixo, y1 =v1, y2 = v2, y3 = v3)

ggplot(data=df, aes(x=eixo, y=y3)) +
  ylim(0, .65) +
  geom_bar(stat="identity",  fill="steelblue")+
  xlab("Métodos de detecção de bordas")+
  ylab("Valor")+
  ggtitle(TeX("Métrica Mcc para os métodos de detecção de bordas")) +
  geom_text(aes(label=y3), vjust=-0.3, color="blue", size=3.5) +
  theme_clean() +
  theme(axis.text.x=element_text(angle = 90, vjust = 0.5, hjust=1))

# Gráfico de métricas relativas

df$GanhoRelativo <- (df$y3-min(df$y3))/(1-min(df$y3))

ggplot(data=df, 
       aes(x=reorder(eixo, GanhoRelativo), 
           y=GanhoRelativo
           )
       ) + 
  geom_bar(stat="identity",  fill="steelblue")+
  labs(title="Métrica Mcc para os métodos de detecção de bordas",
       subtitle="Melhoria relativa à pior métrica: F-ROC 51.19%",
       x="Métodos de detecção de bordas",
       y="Ganho relativo") +
  geom_text(aes(
            label=paste(100*round(GanhoRelativo, 4), "%"),
            ), 
            hjust=0, vjust=0, color="blue", size=3.5) +
#  xlim(0, .25) +
  coord_flip() +
  theme_clean() +
  theme(axis.text.x=element_text(angle = 90, vjust = 0.5, hjust=1))
