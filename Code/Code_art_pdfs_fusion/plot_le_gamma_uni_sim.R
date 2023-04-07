# Autor: AAB    versão 1.0 data: 14/11/2018
# O programa le uma imagem 400 X 400 (canais hh, hv e vv) encontra a funcao l(j) para cada linha da imagem, e calcula o ponto de max/min (evidencia de borda) pelo método GenSA.
# O programa imprime um vetor de tamanho 400 com as evidencias de bordas para cada linha da imagem em uma arquivo *.txt
# obs: 1) Trocar os canais nos arquivos de entrada e saida.
#     ´ 2) Progama preparado para rodar amostras em duas metades com sigmas propostos me \cite{nhfc} e \cite{gamf}.
#      3) Desabilitei o print em arquivo depois de rodar os testes de interesse com o intuito de não modificar arquivos indevidamente.
rm(list = ls())
library(plotly)
require(maxLik)
#
source("loglike_L_mu_gamma.R")
source("loglikd_L_mu_gamma.R")
# Programa principal
setwd("../..")
setwd("Data")
# canais hh, hv, and vv
# canais para a + bi
mat <- scan('Phantom_gamf_0.000_1_2_1.txt')
setwd("..")
setwd("Code/Code_art_pdfs_fusion")
mat <- matrix(mat, ncol = 400, byrow = TRUE)
d <- dim(mat)
nrows <- d[1]
ncols <- d[2]
N <- ncols
z    <- rep(0, N)
#
nr <- 50
l <- 100
z  <-  mat[nr,1:l]
## Discretizacao de L
nx <- 20
ny <- 100
x    <- rep(0, nx)
y    <- rep(0, ny - 1)
li <- 0.001
lf <- 10
ri <- 0.005
rf <- 0.95
hl <- (lf - li) / (nx - 1)
hr <- (rf - ri) / (ny - 1)
for (i in 1 : nx){
  x[i] <- li + (i - 1) * hl
}
for (i in 1 : ny - 1){
  y[i] <- ri + (i - 1) * hr
}
matf <- matrix(0, nrow = nx, ncol = ny - 1)
l <- 100
Ni <- l
Nf <- N
L <- 4
rho <- 0.01
for (i in 1 : nx){
  for (j in 1 : ny - 1){
    r1 <- x[i]
    r2 <- y[j]
    #matf[i,j] = loglike_L_mu_gamma(c(r1, r2))
    matf[i,j] = loglikd_L_mu_gamma(c(r1, r2))
  }
}
#res1 <- maxBFGS(loglik_produto_biv, start=c(0.1, 0.1, 0.1))
p <- plot_ly(x= y, y = x, z = matf, type = "surface") 
p <- p %>%  layout(title = TeX("\\rho"),
                   scene = list(
                     xaxis = list(title = TeX("&frac{1}{4}")),
                     yaxis = list(title = TeX("\\frac{1}{4}")),  
                     zaxis = list(title = TeX("f(x,y)=x^2\\dot y"))
                   ))
p <- p %>% config(mathjax = 'cdn')
print(p) 