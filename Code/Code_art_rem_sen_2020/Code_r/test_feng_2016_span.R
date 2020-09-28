# Autor: AAB    versão 1.0 data: 14/11/2018
# O programa le uma imagem 400 X 400 (canais hh, hv e vv) encontra a funcao l(j) para cada linha da imagem, e calcula o ponto de max/min (evidencia de borda) pelo método GenSA.
# O programa imprime um vetor de tamanho 400 com as evidencias de bordas para cada linha da imagem em uma arquivo *.txt
# obs: 1) Trocar os canais nos arquivos de entrada e saida.
#      2) Progama preparado para rodar amostras em duas metades com sigmas propostos me \cite{nhfc} e \cite{gamf}.
#      3) Desabilitei o print em arquivo depois de rodar os testes de interesse com o intuito de não modificar arquivos indevidamente.
rm(list = ls())
require(ggplot2)
require(latex2exp)
library(hrbrthemes)
require(extrafont)
#
N <- 5
A = matrix( 
     c(   1, 0.64, 0.64, 0.64, 0.64,
       0.64,    1, 0.64, 0.64, 0.64,
       0.64, 0.64,    1, 0.64, 0.64,
       0.64, 0.64, 0.64,    1, 0.64,
       0.64, 0.64, 0.64, 0.64,    1), # the data elements 
     nrow= N,              # number of rows 
     ncol= N,              # number of columns 
     byrow = TRUE)        # fill matrix by rows 
C <- chol(A)
L   <- 2.5
mu  <- 1
rho <- 0.64
## Discretizacao de rho
ny <- 100
y    <- rep(0, ny - 1)
ri <- 0
rf <- 10
hr <- (rf - ri) / (ny - 1)
for (i in 1 : ny - 1){
  y[i] <- ri + (i - 1) * hr
}
lobj1 <- rep(0, ny - 1)
lobj2 <- rep(0, ny - 1)
for (i in 1 : ny - 1){
  lobj1[i] = (1 / gamma(L)) * (L / mu)^L * y[i]^(L - 1) * exp(- (L / mu) * y[i])
  lobj2[i] = (pi^0.5 / (gamma(L) * (1 - rho^2)^L))  
}
df <- data.frame(x = y, y1 = lobj1, y2 = lobj2)
alpha <- c(1)
p <- ggplot(df) 
pp <- p + geom_line(aes(x = x, y = y1, color = "L=1") , size=2, alpha=.7) +
  geom_line(aes(x = x, y = y2, color = "L=2") , size=2, alpha=.7) +
  #geom_line(aes(x = x, y = y3, color = "L=4") , size=2, alpha=.7) +
  #geom_line(aes(x = x, y = y4, color = "L=8") , size=2, alpha=.7) +
  ylim(0,1) +
  ylab(TeX('Log-likelihood')) +
  xlab(TeX('$\\rho$')) +
  theme_ipsum(base_family = "Times New Roman", 
              base_size = 10, axis_title_size = 10) +
  scale_fill_ipsum() +
  theme(legend.title = element_blank()) +
  theme(plot.margin=grid::unit(c(0,0,0,0), "mm"))
print(pp)