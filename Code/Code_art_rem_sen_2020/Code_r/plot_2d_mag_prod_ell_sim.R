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
source("func_obj_l_prod_mag.r")
source("loglike_prod_mag.r")
source("loglikd_prod_mag.r")
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
setwd("Code/Code_art_rem_sen_2020")
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
ny <- 100
## Discretizacao de rho
y    <- rep(0, ny - 1)
ri <- 0
rf <- 1
hr <- (rf - ri) / (ny - 1)
for (i in 1 : ny - 1){
  y[i] <- ri + (i - 1) * hr
}
j <- 150
lobj1 <- rep(0, ny - 1)
lobj2 <- rep(0, ny - 1)
lobj3 <- rep(0, ny - 1)
lobj4 <- rep(0, ny - 1)
for (i in 1 : ny - 1){
    r1 <- y[i]
    L  <- 1
    #lobj1[i] = loglike_prod_mag(y[i]) # essa linha muda para o lado esquerdo da imagem duas folhas
    lobj1[i] = loglikd_prod_mag(y[i])
    L  <- 2
    lobj2[i] = loglikd_prod_mag(y[i])
    L  <- 4
    lobj3[i] = loglikd_prod_mag(y[i])
    L  <- 8
    lobj4[i] = loglikd_prod_mag(y[i])
}
df <- data.frame(x = y, y1 = lobj1, y2 =  lobj2, y3 =  lobj3, y4 =  lobj4)
alpha <- c(1,2,3,4)
p <- ggplot(df) 
pp <- p + geom_line(aes(x = x, y = y1, color = "L=1") , size=2, alpha=.7) +
          geom_line(aes(x = x, y = y2, color = "L=2") , size=2, alpha=.7) +
          geom_line(aes(x = x, y = y3, color = "L=4") , size=2, alpha=.7) +
          geom_line(aes(x = x, y = y4, color = "L=8") , size=2, alpha=.7) +
          ylim(-10,0) +
          ylab(TeX('Log-verossimilhança')) +
          xlab(TeX('$\\rho$')) +
          theme_ipsum(base_family = "Times New Roman", 
          base_size = 20, axis_title_size = 20) +
          scale_fill_ipsum() +
          theme(legend.title = element_blank()) +
          theme(plot.margin=grid::unit(c(0,0,0,0), "mm"))
print(pp)