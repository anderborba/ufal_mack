# Autor: AAB - data 07/11/2018 versao - 1.0
# Programa para gerar graficos de funcoes pdf da distrubuicao Wishart (canal hh), com sigmas(sigma1, sigma2) definidos de acordo com o artigo GAMF_2017.
# Figura usada no arquivo /home/aborba/git_ufal_mack/Text/Dissertacao/cap2_acf.tex
# Ref : gamf_2017
rm(list = ls())
require(graphics)
require(maxLik)
library(plyr)
library(ggplot2)
library(latex2exp)
m = 1
L = 4
sigma1 = 0.042811
sigma2 = 0.014380
x <- seq(0, 0.15, length.out = 500 )
##### realizar o plot usando o ggplot #######################
alpha <- c(sigma1, sigma2)
data <- mdply(alpha, function(a, x) data.frame(v=((L^L * x^(L-m))/(a^L * gamma(L))) * exp(((-L * x) / a)), x= x), x )
p <- ggplot(data, aes(x = x, y = v, color = X1)) + geom_line() + xlab(TeX('$z_{hh$}')) + ylab(TeX('$f(z_{hh})=\\frac{L^L z_{hh^{L-m}}}{\\sigma_{hh}^{2L}\\Gamma(L)}\\exp\\left(-L\\left(\\frac{z_{hh}}{\\sigma_{hh}^2}\\right)\\right) $')) + ggtitle(TeX('Distribuíção de probabilidade')) + coord_cartesian(ylim=c(0, 65)) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.4f$', alpha), TeX))
#ggsave("grafico_pdf_gamf_2017_sigma_hh.pdf")
print(p)
