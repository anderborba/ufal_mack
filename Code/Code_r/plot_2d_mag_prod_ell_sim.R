# Autor: AAB    versão 1.0 data: 14/11/2018
# O programa le uma imagem 400 X 400 (canais hh, hv e vv) encontra a funcao l(j) para cada linha da imagem, e calcula o ponto de max/min (evidencia de borda) pelo método GenSA.
# O programa imprime um vetor de tamanho 400 com as evidencias de bordas para cada linha da imagem em uma arquivo *.txt
# obs: 1) Trocar os canais nos arquivos de entrada e saida.
#      2) Progama preparado para rodar amostras em duas metades com sigmas propostos me \cite{nhfc} e \cite{gamf}.
#      3) Desabilitei o print em arquivo depois de rodar os testes de interesse com o intuito de não modificar arquivos indevidamente.
rm(list = ls())
library(plotly)
#
source("func_obj_l_gauss_lee_eq26.r")
source("loglik_prod_mag_lee_eq26.r")
#source("loglikd_prod_mag_lee_eq26.r")
# Programa principal
setwd("../..")
setwd("Data")
# canais hh, hv, and vv
# canais para a + bi
mat1 <- scan('Phantom_gamf_0.000_1_2_1.txt')
mat2 <- scan('Phantom_gamf_0.000_1_2_2.txt')
mat3 <- scan('Phantom_gamf_0.000_1_2_4.txt')
mat4 <- scan('Phantom_gamf_0.000_1_2_5.txt')
setwd("..")
setwd("Code/Code_r")
mat1 <- matrix(mat1, ncol = 400, byrow = TRUE)
mat2 <- matrix(mat2, ncol = 400, byrow = TRUE)
mat3 <- matrix(mat3, ncol = 400, byrow = TRUE)
mat4 <- matrix(mat4, ncol = 400, byrow = TRUE)
d <- dim(mat1)
nrows <- d[1]
ncols <- d[2]
N <- ncols
z1    <- rep(0, N)
z2    <- rep(0, N)
z3    <- rep(0, N)
z4    <- rep(0, N)
zaux1  <- rep(0, N)
#
nr <- 35
z1  <-  mat1[nr,1:N]
z2  <-  mat2[nr,1:N]
z3  <-  mat3[nr,1:N]
z4  <-  mat4[nr,1:N]
conta = 0
for (i in 1 : N){
  if (z1[i] > 0 && z2[i] > 0){
    conta <- conta + 1
    zaux1[conta] <-  sqrt(z3[i]^2 + z4[i]^2) / sqrt(z1[i] * z2[i]) 
  }
}
indx  <- which(zaux1 != 0)
N <- length(indx)
z <- rep(0, N)
z[1: N]  <- zaux1[1: N]
## Discretizacao de L
nx <- 100
ny <- 20
x    <- rep(0, nx)
## Discretizacao de rho
y    <- rep(0, ny - 1)
li <- 1
lf <- 20
ri <- 0
rf <- 1
hl <- (lf - li) / (nx - 1)
hr <- (rf - ri) / (ny - 1)
for (i in 1 : nx){
  x[i] <- li + (i - 1) * hl
}
for (i in 1 : ny - 1){
  y[i] <- ri + (i - 1) * hr
}
matf <- matrix(0, nrow = nx, ncol = ny - 1)
Ni <- 50
Nf <- N
for (i in 1 : nx ){
  for (j in 1 : ny - 1){
    r1 <- x[i]
    r2 <- y[j]
    matf[i,j] = loglik_prod_mag_lee_eq26(c(r1, r2))
  }
}
p <- plot_ly(x = y, y = x, z = matf, type = "surface") 
p <- p %>%  layout(title = TeX("\\rho"),
    scene = list(
      xaxis = list(title = TeX("&frac{1}{4}")),
      yaxis = list(title = TeX("\\frac{1}{4}")),  
      zaxis = list(title = TeX("f(x,y)=x^2\\dot y"))
    ))
p <- p %>% config(mathjax = 'cdn')
print(p) 
