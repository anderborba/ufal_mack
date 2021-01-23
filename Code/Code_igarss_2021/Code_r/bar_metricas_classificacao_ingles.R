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
# Gráfico de métricas relativas
df$GanhoRelativo <- (df$y3-min(df$y3))/(1-min(df$y3))
df$GanhoRelativoMac <- (df$y1-min(df$y1))/(1-min(df$y1))
df$GanhoRelativoMfe <- (df$y2-min(df$y2))/(1-min(df$y2))
df$GanhoRelativoMcc <- (df$y3-min(df$y3))/(1-min(df$y3))
#
ggplot(data=df, 
       aes(x=reorder(eixo, GanhoRelativo), 
           y=GanhoRelativo
       )
) + 
  geom_bar(stat="identity",  fill="steelblue")
  labs(title="nMcc metrics for edge detection methods",
       subtitle="Improvement relative to the worst metric: F-ROC 51.19%",
       x="Edge Detection Methods",
       y="Relative Gain") +
  geom_text(aes(
    label=paste(100*round(GanhoRelativo, 4), "%"),
  ), 
  hjust=0, vjust=0, color="blue", size=3.5) +
  coord_flip(ylim = c(0, 0.25)) +
  theme_clean() +
  theme(axis.text.x=element_text(angle = 90, vjust = 0.5, hjust=1))
#
#setwd("../../..")
#getwd()
#setwd("Text/Dissertacao/figuras")
#getwd()
#ggsave("metrica_igarss_2021_mcc.pdf")
ggsave("teste.pdf")
#setwd("../../..")
#getwd()
#setwd("Code/Code_igarss_2021/Code_r")
#getwd()

#p <- ggplot(data=df, 
#       aes(x=reorder(eixo, GanhoRelativoMcc), 
#           y=GanhoRelativoMcc
#           )
#       ) + 
#  geom_bar(stat="identity",  fill="lightsteelblue2")+
#  labs(title="nMcc metric for edge detection methods",
#       subtitle="Improvement relative to the worst metric: F-ROC 51.19%",
#       x="Edge Detection Methods",
#       y="Relative Gain") +
#  geom_text(aes(
#            label=paste(100*round(GanhoRelativoMcc, 4), "%"),
#            ), 
#            hjust=1, vjust=0, color="blue4", size=3.5) +
#  #xlim(0, 1.25) +
#  coord_flip() +
#  theme_clean() +
#  theme(axis.text.x=element_text(angle = 90, vjust = 0.5, hjust=1.0))
#print(p)