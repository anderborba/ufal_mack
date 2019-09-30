# Autor: AAB - data 07/11/2018 versao - 1.0
# Programa para gerar graficos de funcoes pdf da distribuicao Wishart (canal hh), com sigmas(sigma1, sigma2) definidos de acordo com o artigo NHFC_2014. 
# Figura usada no arquivo /home/aborba/git_ufal_mack/Text/Dissertacao/cap2_acf.tex
# Ref : nhfc_2014
rm(list = ls())
library(plyr)
library(ggplot2)
library(latex2exp)
m = 1
L = 4
sigma1 = 962892
sigma2 = 360932
#sigma1 = 19171
#sigma2 = -3579
#a <- 0
#b <- 100000
a <- 0
b <- 10000000/3
n <- 10000
h <- (b - a)/ n
x <- seq(a, b, length.out = n )
##### realizar o plot usando o ggplot #######################
alpha <- c(abs(sigma1), abs(sigma2))
data <- mdply(alpha, function(a, x) data.frame(v=((L^L * x^(L-m))/(a^L * gamma(L))) * exp(((-L * x) / a)), x= x), x )
######## Com a funcao de densidadede no titulo da ordenada
#p <- ggplot(data, aes(x = x, y = v, color = X1)) + geom_line() + xlab(TeX('$z_{hh$}')) + ylab(TeX('$f(z_{hh})=\\frac{L^L z_{hh^{L-m}}}{\\sigma_{hh}^{2L}\\Gamma(L)}\\exp\\left(-L\\left(\\frac{z_{hh}}{\\sigma_{hh}^2}\\right)\\right) $')) + ggtitle(TeX('Distribuíção de probabilidade')) + coord_cartesian(ylim=c(0, 0.0000025)) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', alpha), TeX))
p <- ggplot(data, aes(x = x, y = v, color = X1)) + geom_line() + xlab(TeX('$z_{hh$}')) + ylab(TeX('$f(z_{hh})$')) + coord_cartesian(ylim=c(0, 0.0000025)) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', alpha), TeX))
#setwd("../..")
#setwd("Text/Dissertacao/figuras")
#ggsave("grafico_pdf_nhfc_2014_sigma_hh_artigos.pdf")
#setwd("../../..")
#setwd("Code/Code_r")
print(p)
