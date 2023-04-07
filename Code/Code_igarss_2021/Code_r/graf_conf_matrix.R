# Confusin matrix
library(ggplot2)
require(latex2exp)
library(hrbrthemes)
require(extrafont)
loadfonts()
#
ClasseV <- factor(c(1, 1, 0, 0))
ClasseP <- factor(c(1, 0, 1, 0))
# Valores da matriz de confusão para hh
#TP <- 12
#FN <- 88
#FP <- 378
#TN <- 767522
# Valores da matriz de confusão para hv
#TP <- 10
#FN <- 80
#FP <- 380
#TN <- 767521
# Valores da matriz de confusão para vv
#TP <- 8
#FN <- 92
#FP <- 382
#TN <- 767518
# Valores da matriz de confusão para fusão por media
#TP <- 27
#FN <- 225
#FP <- 363
#TN <- 767385
# Valores da matriz de confusão para fusão por PCA
#TP <- 27
#FN <- 225
#FP <- 363
#TN <- 767385
# Valores da matriz de confusão para fusão por MR-SWT
#TP <- 357
#FN <- 5055
#FP <- 36
#TN <- 762555
# Valores da matriz de confusão para fusão por MR-DWT
#TP <- 314
#FN <- 4171
#FP <- 76
#TN <- 763439
# Valores da matriz de confusão para fusão por ROC
#TP <- 3
#FN <- 37
#FP <- 387
#TN <- 767576
# Valores da matriz de confusão para fusão por MR-SVD
TP <- 60
FN <- 556
FP <- 330
TN <- 767054
Y  <- c(TP, FN, FP, TN)
np <- TP + FN
nn <- TN + FP
ni <- max(np, nn) / (np + nn)
df <- data.frame(ClasseV, ClasseP, Y)
p <- ggplot(data =  df, mapping = aes(x = ClasseV, y = ClasseP)) +
  geom_tile(aes(fill = Y), colour = "white") +
  geom_text(aes(label = sprintf("%1.0f", Y)), vjust = 1, fontface  = "bold", family="Times New Roman") +
  scale_fill_gradient(low = "gray", high = "brown1") +
  theme_bw() + theme(legend.position = "none")+
  xlab("Classes Reais")+
  ylab("Classes Preditas")+
  ggtitle(TeX("Matriz de confusão para o método fusão MR-SVD"))
print(p)