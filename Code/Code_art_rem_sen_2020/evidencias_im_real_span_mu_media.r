# Autor: AAB    versão 1.0 data: 14/11/2018
# O programa le uma imagem 400 X 400 (canais hh, hv e vv) encontra a funcao l(j) para cada linha da imagem, e calcula o ponto de max/min (evidencia de borda) pelo método GenSA.
# O programa imprime um vetor de tamanho 400 com as evidencias de bordas para cada linha da imagem em uma arquivo *.txt
# obs: 1) Trocar os canais nos arquivos de entrada e saida.
#      2) Progama preparado para rodar amostras em duas metades com sigmas propostos me \cite{nhfc} e \cite{gamf}.
#      3) Desabilitei o print em arquivo depois de rodar os testes de interesse com o intuito de não modificar arquivos indevidamente.
rm(list = ls())
require(ggplot2)
require(latex2exp)
require(GenSA)
require(maxLik)
#
source("func_obj_l_mu.R")
# Programa principal
setwd("../..")
setwd("Data")
# canais hh, hv, and vv 
mat1 <- scan('real_flevoland_1.txt')
mat2 <- scan('real_flevoland_2.txt')
mat3 <- scan('real_flevoland_3.txt')
setwd("..")
setwd("Code/Code_art_rem_sen_2020")
########## setup para a imagem de flevoland
r <- 120
mat1 <- matrix(mat1, ncol = r, byrow = TRUE)
mat2 <- matrix(mat2, ncol = r, byrow = TRUE)
mat3 <- matrix(mat3, ncol = r, byrow = TRUE)
d <- dim(mat1)
nr <- d[1]
N  <- d[2]
# Loop para toda a imagem
matdf1 <- matrix(0, nrow = N, ncol = 2)
matdf2 <- matrix(0, nrow = N, ncol = 2)
evidencias          <- rep(0, nr)
evidencias_valores  <- rep(0, nr)
xev  <- seq(1, nr, 1 )
for (k in 1 : nr){# k is radial lines
  print(k)
  N <- r
  z1 <- rep(0, N)
  z1 <- mat1[k, 1: N]
  z2 <- rep(0, N)
  z2 <- mat1[k, 1: N]
  z3 <- rep(0, N)
  z3 <- mat1[k, 1: N]
  z  <- rep(0, N)
  z  <- z1 + 2 * z2 + z3
  zaux1 <- rep(0, N)
  conta = 0
  for (i in 1 : N){
    if (z[i] > 0){
      conta <- conta + 1
      zaux1[conta] = z[i]
    }
  }
  indx  <- which(zaux1 != 0)
  N <- floor(max(indx))
  z     <-  zaux1[1:N]
  matdf1 <- matrix(0, nrow = N, ncol = 1)
  matdf2 <- matrix(0, nrow = N, ncol = 1)
  for (j in 1 : (N - 1)){
    r1 <- sum(z[1: j]) / j
    r2 <- sum(z[(j + 1): N]) / (N - j)
    matdf1[j, 1] <- r1
    matdf2[j, 1] <- r2
  }
  lower <- as.numeric(14)
  upper <- as.numeric(N - 14)
  L <- 4
  out   <- GenSA(lower = lower, upper = upper, fn = func_obj_l_mu, control=list( maxit =100))
  evidencias[k] <- out$par
  print(evidencias[k])
  evidencias_valores[k] <- out$value
}
x <- seq(N - 1)
lobj <- rep(0, (N - 1))
for (j in 1 : (N - 1) ){
  #  Tomar cuidado com o sinal o mesmo é inserido pois o GenSA minimiza funçoes
  lobj[j] <- func_obj_l_mu(j)
}
df <- data.frame(x, lobj)
p <- ggplot(df, aes(x = x, y = lobj, color = 'darkred')) + geom_line() + xlab(TeX('Pixel $j$')) + ylab(TeX('$l(j)$')) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', NULL), TeX))
print(p)
# imprime em arquivo no diretorio  ~/Data/
dfev <- data.frame(xev, evidencias)
names(dfev) <- NULL
setwd("../..")
setwd("Data")
sink("evid_real_flevoland_span_mu_media_14_pixel.txt")
print(dfev)
sink()
setwd("..")
setwd("Code/Code_art_rem_sen_2020")