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
source("func_obj_l_L_mu_produto_biv.r")
source("loglik_produto_biv.r")
# Programa principal
setwd("../..")
setwd("Data")
# canais hh, hv, and vv
mat1 <- scan('real_flevoland_1.txt')
mat2 <- scan('real_flevoland_3.txt')
setwd("..")
setwd("Code/Code_r")
mat1 <- matrix(mat1, ncol = 120, byrow = TRUE)
mat2 <- matrix(mat2, ncol = 120, byrow = TRUE)
d <- dim(mat1)
nrows <- d[1]
ncols <- d[2]
N  = ncols
# Loop para toda a imagem
evidencias          <- rep(0, nrows)
evidencias_valores  <- rep(0, nrows)
xev  <- seq(1, nrows, 1 )
L <- 4
#for (k in 1 : nrows){# j aqui varre o número de radiais
for (k in 10 : 10){# k aqui varre o número de radiais
  print(k)
  N <- ncols
  z1aux <- rep(0, N)
  z2aux <- rep(0, N)
  z1aux <- mat1[k, 1: N] 
  z2aux <- mat2[k, 1: N]
  conta = 0
  for (i in 1 : N){
    if (z1aux[i] > 0 & z2aux[i] > 0){
      conta <- conta + 1
      z1aux[conta] <- z1aux[i]
      z2aux[conta] <- z2aux[i]
    }
  }
  indx      <- which(z1aux != 0)
  N         <- length(indx)
  z1        <- rep(0, N)
  z2        <- rep(0, N)
  z1[1: N]  <- z1aux[1: N]
  z2[1: N]  <- z2aux[1: N]
  matdf1 <- matrix(0, nrow = N, ncol = 3)
  matdf2 <- matrix(0, nrow = N, ncol = 3)
  for (j in 1 : (N - 1)){
    print(j)
    Ni <- 1
    Nf <- j
    r1 <- sum(z1[Ni: Nf]) / (Nf - (Ni - 1))
    r2 <- sum(z2[Ni: Nf]) / (Nf - (Ni - 1))
    r3 <- 0.1
    res1 <- maxBFGS(loglik_produto_biv, start=c(r1, r2, r3))
    print(res1$maximum)
    Ni <- j + 1
    Nf <- N
    r1 <- sum(z1[Ni: Nf]) / (Nf - (Ni - 1))
    r2 <- sum(z2[Ni: Nf]) / (Nf - (Ni - 1))
    r3 <- 0.1
    res2 <- maxBFGS(loglik_produto_biv, start=c(r1, r2, r3))
    print(res2$maximum)
    matdf1[j, 1] <- res1$estimate[1]
    matdf1[j, 2] <- res1$estimate[2]
    matdf1[j, 3] <- res1$estimate[3]
    #
    matdf2[j, 1] <- res2$estimate[1]
    matdf2[j, 2] <- res2$estimate[2]
    matdf2[j, 3] <- res2$estimate[3]
  }
  #  cf <- 14
  #  lower <- as.numeric(cf) 
  #  upper <- as.numeric(N - cf)
  #  out   <- GenSA(lower = lower, upper = upper, fn = func_obj_l_L_mu_produto_biv, control=list( maxit =100))
  #  evidencias[k] <- out$par
  #  evidencias_valores[k] <- out$value
}
x <- seq(N - 1)
lobj <- rep(0, (N - 1))
for (j in 1 : (N - 1)){
  lobj[j] <- func_obj_l_L_mu_produto_biv(j)
}
df <- data.frame(x, lobj)
p <- ggplot(df, aes(x = x, y = lobj, color = 'darkred')) + geom_line() + xlab(TeX('Pixel $j$')) + ylab(TeX('$l(j)$')) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', NULL), TeX))
print(p)
# imprime em arquivo no diretorio  ~/Data/
#dfev <- data.frame(xev, evidencias)
#names(dfev) <- NULL
#setwd("../..")
#setwd("Data")
#sink("evid_real_flevoland_3_param_L_mu.txt")
#print(dfev)
#sink()
#setwd("..")
#setwd("Code/Code_r")
