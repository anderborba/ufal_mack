# Bar metrics Confusin matrix
rm(list = ls())
library(ggplot2)
require(latex2exp)
library(hrbrthemes)
require(extrafont)
loadfonts()
#
setwd("..")
setwd("Data")
mat <- scan('metricas_class_mat_conf.txt')
setwd("..")
setwd("Code_r")
mat <- matrix(mat,  ncol = 4, byrow = TRUE)
nk <- 9
eixo  <- seq(0, nk - 1, 1)
eixo <- c("MLE-Ihh","MLE-Ihv","MLE-Ivv", "F-Med", "F-PCA", "F-MR-SWT", "F-MR-DWT", "F-ROC", "F-MR-SVD")
TP  <- seq(0, nk - 1, 1)
FN  <- seq(0, nk - 1, 1)
FP  <- seq(0, nk - 1, 1)
TN  <- seq(0, nk - 1, 1)
for(k in 1: nk){
  TP[k] <- mat[k, 1]
  FN[k] <- mat[k, 2]
  FP[k] <- mat[k, 3]
  TN[k] <- mat[k, 4]
}
df <- data.frame(x = eixo, y1 =TP, y2 = FN, y3 = FP, y4 = TN)
p <-ggplot(data=df, aes(x=eixo, y=y4)) +
  geom_bar(stat="identity",  fill="steelblue")+
  xlab("Métodos de detecção de bordas")+
  ylab("TN")+
  ggtitle(TeX("TN para os métodos de detecção de bordas")) +
  geom_text(aes(label=y4), vjust=-0.3, color="blue", size=3.5)
print(p)