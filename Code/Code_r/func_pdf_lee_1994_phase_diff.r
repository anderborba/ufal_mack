# Autor: AAB - data 02/01/2019 versao - 1.0
# Programa para gerar graficos de funcoes pdf da distribuicao diferença de fase definidos de acordo com o artigo \cite{lee_1994}. 
# Figura usada no arquivo /home/aborba/git_ufal_mack/Text/Dissertacao/cap2_acf.tex
# Ref : lee_1994
rm(list = ls())
library(plyr)
library(ggplot2)
library(latex2exp)
roc   <- 0.7
theta <- 0.0
n <- 10000
x <- seq(-pi, pi, length.out = n )
look_1 <-  (1-abs(roc)^2)*((1-(abs(roc)*cos(x-theta))^(2))^(0.5)+(abs(roc)*cos(x-theta))*(pi-acos(abs(roc)*cos(x-theta))))/(2*pi*(1-(abs(roc)*cos(x-theta))^2)^(1.5))
look_2 <- (3*(1-abs(roc)^2)^2*(abs(roc)*cos(x-theta)))/(8*(1-(abs(roc)*cos(x-theta))^{2})^(2.5))+((1-abs(roc)^2)^2/(4*pi*(1-(abs(roc)*cos(x-theta))^2)^2))*(2+(abs(roc)*cos(x-theta))^2+(3*abs(roc)*cos(x-theta)*asin(abs(roc)*cos(x-theta)))/(1-(abs(roc)*cos(x-theta))^2)^(1/2))
look_3 <- (15*(1-abs(roc)^2)^3*(abs(roc)*cos(x-theta)))/(32*(1-(abs(roc)*cos(x-theta))^{2})^(3.5))+((1-abs(roc)^2)^3/(16*pi*(1-(abs(roc)*cos(x-theta))^2)^3))*(8+9*(abs(roc)*cos(x-theta))^2-2*(abs(roc)*cos(x-theta))^4+(15*abs(roc)*cos(x-theta)*asin(abs(roc)*cos(x-theta)))/(1-(abs(roc)*cos(x-theta))^2)^(1/2))
look_4 <- (35*(1-abs(roc)^2)^4*(abs(roc)*cos(x-theta)))/(64*(1-(abs(roc)*cos(x-theta))^{2})^(4.5))+((1-abs(roc)^2)^4/(96*pi*(1-(abs(roc)*cos(x-theta))^2)^4))*(48+87*(abs(roc)*cos(x-theta))^2-38*(abs(roc)*cos(x-theta))^4+8*(abs(roc)*cos(x-theta))^6+(105*abs(roc)*cos(x-theta)*asin(abs(roc)*cos(x-theta)))/(1-(abs(roc)*cos(x-theta))^2)^(1/2))
##### realizar o plot usando o ggplot #######################
data_look <- data.frame(x, look_1, look_2, look_3, look_4, fix.empty.names = TRUE)
p <- ggplot(data_look, aes(x, y, color = Visadas) )    +
     	geom_line(aes(y = look_1, col= "Visada 1"))    +
     	geom_line(aes(y = look_2, col= "Visada 2"))    +
     	geom_line(aes(y = look_3, col= "Visada 3"))    +
     	geom_line(aes(y = look_4, col= "Visada 4"))    +
       	xlab(TeX('Diferença de fase (Radianos)'))      +
      	ylab(TeX('Função densidade de probabilidade (PDF)')) +
       	ggtitle(TeX('Múltiplas visadas para a distribuíção diferença de fase')) +
       	coord_cartesian(ylim=c(0, 1.1))
setwd("../..")
setwd("Text/Dissertacao/figuras")
ggsave("grafico_pdf_lee_1994_dif_fase.pdf")
setwd("../../..")
setwd("Code/Code_r")
print(p)
