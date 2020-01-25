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
#source("func_obj_l_L_mu_produto.r")
source("func_obj_l_prod_inten.r")
source("loglike_produto.r")
source("loglikd_produto.r")
#source("func_soma_1_to_j.r")
#source("func_soma_j_to_n.r")
# Programa principal
setwd("../..")
setwd("Data")
# canais hh, hv, and vv
mat1 <- scan('real_flevoland_1.txt')
mat2 <- scan('real_flevoland_2.txt')
setwd("..")
setwd("Code/Code_r")
mat1 <- matrix(mat1, ncol = 120, byrow = TRUE)
mat2 <- matrix(mat2, ncol = 120, byrow = TRUE)
d <- dim(mat1)
nrows <- d[1]
ncols <- d[2]
N  = ncols
#rho1 <- 0.4
#rho2 <- 0.3
#r1s <- rho1^2
#r2s <- rho2^2
# Loop para toda a imagem
matdf1 <- matrix(0, nrow = N, ncol = 2)
matdf2 <- matrix(0, nrow = N, ncol = 2)
evidencias          <- rep(0, nrows)
evidencias_valores  <- rep(0, nrows)
xev  <- seq(1, nrows, 1 )
#for (k in 1 : nrows){# j aqui varre o número de radiais
for (k in 1 : 1){# j aqui varre o número de radiais
         print(k)
	N <- ncols
	z  <- rep(0, N)
	z1 <- rep(0, N)
	z2 <- rep(0, N)
        z1 <- mat1[k, 1: N] 
        z2 <- mat2[k, 1: N]
	conta = 0
  	for (i in 1 : N){
	  if (z2[i] > 0){
          	conta <- conta + 1
		#z[conta] <- (z1[i] * z2[i]) /  sqrt(z1[1]^2 * z2[i]^2)
		z[conta] <- (z1[i] * z2[i]) 
	  }
	}
	indx  <- which(z != 0)
	N <- floor(max(indx))
	matdf1 <- matrix(0, nrow = N, ncol = 2)
	matdf2 <- matrix(0, nrow = N, ncol = 2)
	for (j in 1 : N ){
	  #r1 <- runif(1, 0, 10)
	  #r2 <- runif(1, 0, 1)
	  r1 <- 1
	  r2 <- 0.5
	  res1 <- maxBFGS(loglike_produto, start=c(r1, r2))
	  #r1 <- runif(1, 0, 10)
	  #r2 <- runif(1, 0, 1)
	  r1 <- 1
	  r2 <- 0.5
	  res2 <- maxBFGS(loglikd_produto, start=c(r1, r2))
	  matdf1[j, 1] <- res1$estimate[1]
	  matdf1[j, 2] <- res1$estimate[2]
	  if (j < N){
	    matdf2[j, 1] <- res2$estimate[1]
	    matdf2[j, 2] <- res2$estimate[2]
	  }
	}
	#temp  <- sample(1: N, 1)
	#lower <- 1 
	#upper <- N
	#out   <- GenSA(lower = lower, upper = upper, fn = func_obj_l_L_mu_produto, control=list( maxit =100, temperature = temp))
	#evidencias[k] <- out$par
	#evidecias_valores[k] <- out$value
}
x <- seq(N - 1)
lobj <- rep(0, (N - 1))
for (j in 1 : (N - 1) ){
#  lobj[j] <- func_obj_l_L_mu_produto(j)
  lobj[j] <- func_obj_l_prod_inten(j)
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
