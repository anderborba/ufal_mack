# Autor: AAB - data 02/01/2019 versao - 1.0
# Programa para gerar graficos de funcoes pdf da distribuicao razão amplitude definidos de acordo com o artigo \cite{lee_1994}. 
# Figura usada no arquivo /home/aborba/git_ufal_mack/Text/Dissertacao/cap2_acf.tex
# Ref : lee_1994
rm(list = ls())
library(plyr)
library(ggplot2)
library(latex2exp)
roc   <- 0.5
np <- 10000
x <- seq(0, 4, length.out = np )
n = 1
look_1 <- (2*gamma(2*n)*(1-abs(roc)^2)^n*(1+x^2)*x^(2*n-1))/(gamma(n)*gamma(n)*((1+x^2)^2-4*abs(roc)^2*x^2)^((2*n+1)/2))
#
n = 2
look_2 <- (2*gamma(2*n)*(1-abs(roc)^2)^n*(1+x^2)*x^(2*n-1))/(gamma(n)*gamma(n)*((1+x^2)^2-4*abs(roc)^2*x^2)^((2*n+1)/2))
#
n = 4
look_3 <- (2*gamma(2*n)*(1-abs(roc)^2)^n*(1+x^2)*x^(2*n-1))/(gamma(n)*gamma(n)*((1+x^2)^2-4*abs(roc)^2*x^2)^((2*n+1)/2))
#
n = 8
look_4 <- (2*gamma(2*n)*(1-abs(roc)^2)^n*(1+x^2)*x^(2*n-1))/(gamma(n)*gamma(n)*((1+x^2)^2-4*abs(roc)^2*x^2)^((2*n+1)/2))
##### realizar o plot usando o ggplot #######################
data_look <- data.frame(x, look_1, look_2, look_3, look_4, fix.empty.names = TRUE)
p <- ggplot(data_look, aes(x, y, color = Visadas) )    +
     	geom_line(aes(y = look_1, col= "Visada 1"))    +
     	geom_line(aes(y = look_2, col= "Visada 2"))    +
     	geom_line(aes(y = look_3, col= "Visada 4"))    +
     	geom_line(aes(y = look_4, col= "Visada 8"))    +
       	xlab(TeX('Razão de amplitudes (Normalizada)'))      +
      	ylab(TeX('Funções densidades de probabilidade')) +
       	ggtitle(TeX('Múltiplas visadas para a distribuíção Razão de amplitudes')) +
       	coord_cartesian(ylim=c(0, 1.9))
setwd("../..")
setwd("Text/Dissertacao/figuras")
ggsave("grafico_pdf_lee_1994_razao_amplitude.pdf")
setwd("../../..")
setwd("Code/Code_r")
print(p)
