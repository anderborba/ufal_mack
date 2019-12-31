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
source("func_obj_l_L_mu.r")
# Programa principal
setwd("../..")
setwd("Data")
# canais hh, hv, and vv
mat <- scan('real_flevoland_3.txt')
setwd("..")
setwd("Code/Code_r")
mat <- matrix(mat, ncol = 120, byrow = TRUE)
d <- dim(mat)
nrows <- d[1]
ncols <- d[2]
N  = ncols
# Loop para toda a imagem
matdf1 <- matrix(0, nrow = N, ncol = 2)
matdf2 <- matrix(0, nrow = N, ncol = 2)
matsig <- matrix(0, nrow = N, ncol = 4)
evidencias          <- rep(0, nrows)
evidencias_valores  <- rep(0, nrows)
xev  <- seq(1, nrows, 1 )
for (k in 1 : nrows){# j aqui varre o número de radiais
  print(k)
	N <- ncols
	z     <- rep(0, N)
	z <- mat[k, 1: N]
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
	matdf1 <- matrix(0, nrow = N, ncol = 2)
	matdf2 <- matrix(0, nrow = N, ncol = 2)
	matsig <- matrix(0, nrow = N, ncol = 4)
	for (j in 1 : N ){
	  sigma1 <- sum(log(z[1: j])) / j
	  sigma2 <- sum(z[1: j]) / j
	  sigma3 <- sum(log(z[(j + 1): N])) / (N - j)
	  sigma4 <- sum(z[(j + 1): N]) / (N - j)
	  matsig[j, 1] <- sigma1
	  matsig[j, 2] <- sigma2
	  matsig[j, 3] <- sigma3
	  matsig[j, 4] <- sigma4
	  loglike <- function(param) {
	    L <- param[1]
	    mu <- param[2]
	    aux1 <-  L * log(L)
	    aux2 <- (L - 1) * sigma1
	    aux3 <-  L * log(mu)
	    aux4 <-  log(gamma(L))
	    aux5 <- (L / mu) * sigma2
	    ll <- aux1 + aux2 - aux3 - aux4 - aux5 
	    ll
	  }
	  loglikd <- function(param) {
	    L <- param[1]
	    mu <- param[2]
	    aux1 <-  L * log(L)
	    aux2 <- (L - 1) * sigma3
	    aux3 <-  L * log(mu)
	    aux4 <-  log(gamma(L))
	    aux5 <- (L / mu) * sigma4
	    ll <- aux1 + aux2 - aux3 - aux4 - aux5 
	    ll
	  }
	  r1 <- runif(1, 0, 10)
	  r2 <- runif(1, 0, 1)
	  res1 <- maxBFGS(loglike, start=c(r1,r2))
	  r1 <- runif(1, 0, 10)
	  r2 <- runif(1, 0, 1)
	  res2 <- maxBFGS(loglikd, start=c(r1,r2))
	  matdf1[j, 1] <- res1$estimate[1]
	  matdf1[j, 2] <- res1$estimate[2]
	  if (j < N){
	    matdf2[j, 1] <- res2$estimate[1]
	    matdf2[j, 2] <- res2$estimate[2]
	  }
	}
	temp  <- sample(1: N, 1)
	lower <- 1 
	upper <- N
	out   <- GenSA(lower = lower, upper = upper, fn = func_obj_l_L_mu, control=list( maxit =100, temperature = temp))
	evidencias[k] <- out$par
	evidencias_valores[k] <- out$value
}
# imprime em arquivo no diretorio  ~/Data/
dfev <- data.frame(xev, evidencias)
names(dfev) <- NULL
setwd("../..")
setwd("Data")
sink("evid_real_flevoland_3_param_L_mu.txt")
print(dfev)
sink()
setwd("..")
setwd("Code/Code_r")
