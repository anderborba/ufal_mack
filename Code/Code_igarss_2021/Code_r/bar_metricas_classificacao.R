# Bar metrics Classificacao
rm(list = ls())
library(ggplot2)
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
p <-ggplot(data=df, aes(x=eixo, y=y3)) +
  geom_bar(stat="identity",  fill="steelblue")+
  xlab("Métodos de detecção de bordas")+
  ylab("Valor")+
  ggtitle(TeX("Métrica Mcc para os métodos de detecção de bordas")) +
  geom_text(aes(label=y3), vjust=-0.3, color="blue", size=3.5)
print(p)