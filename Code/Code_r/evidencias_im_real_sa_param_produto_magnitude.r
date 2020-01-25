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
#
source("func_obj_l_gauss.r")
source("func_obj_l_gauss_copia1.r")
source("loglike_prod_mag.r")
source("loglikd_prod_mag.r")
# Programa principal
setwd("../..")
setwd("Data")
# canais hh, hv, and vv
# canais para a + bi 
mat <- scan('real_flevoland_produto_1.txt')
mat1 <- scan('real_flevoland_1.txt')
mat2 <- scan('real_flevoland_2.txt')
setwd("..")
setwd("Code/Code_r")
mat <- matrix(mat, ncol = 120, byrow = TRUE)
mat1 <- matrix(mat1, ncol = 120, byrow = TRUE)
mat2 <- matrix(mat2, ncol = 120, byrow = TRUE)
d <- dim(mat)
nrows <- d[1]
ncols <- d[2]
rho1 <- 0.4
rho2 <- 0.3
L  = 4
# Loop para toda a imagem
evidencias          <- rep(0, nrows)
evidencias_valores  <- rep(0, nrows)
xev  <- seq(1, nrows, 1 )
#for (k in 1 : nrows){
for (k in 1 : 1){
	N <- ncols
	z     <- rep(0, N)
	z1    <- rep(0, N)
	z2    <- rep(0, N)
	zaux  <- rep(0, N)
        zaux1 <- rep(0, N)
	zaux  <-  mat[k,1:N]
	z1  <-  mat1[k,1:N]
	z2  <-  mat2[k,1:N]
	conta = 0
        for (i in 1 : N){
	       if (zaux[i] > 0){
		       conta <- conta + 1
		       zaux1[conta] = zaux[i]
	       }
        }
	indx  <- which(zaux1 != 0)
	N <- floor(max(indx))
	z     <-  zaux1[1:N]
        #matdf1 <- matrix(0, nrow = N, ncol = 3)
        #matdf2 <- matrix(0, nrow = N, ncol = 3)
        #for (j in 1 : N){
	#	print(j)
        #      	r1 <- 1
        #      	r2 <- 0.5
	#	r3 <- 1
	#        res1 <- maxBFGS(loglike_prod_mag, start=c(r1, r2, r3))
	#        matdf1[j, 1] <- res1$estimate[1]
	#        matdf1[j, 2] <- res1$estimate[2]
	#        matdf1[j, 3] <- res1$estimate[3]
  	#	r1 <- 1
        #      	r2 <- 0.5
  	#	r3 <- 1
	#	res2 <- maxBFGS(loglikd_prod_mag, start=c(r1, r2, r3))
        #       if (j < N){
	#            matdf2[j, 1] <- res2$estimate[1]
	#            matdf2[j, 2] <- res2$estimate[2]
	#            matdf2[j, 3] <- res2$estimate[3]
	#       }
        #}
	#temp  <- sample(1: N, 1)
	#lower <- 1 
	#upper <- N
	#out   <- GenSA(lower = lower, upper = upper, fn = func_obj_l_gauss, control=list( maxit =100, temperature = temp))
	#evidencias[j] <- out$par
	#evidencias_valores[j] <- out$value
}
x <- seq(N - 1)
lobj <- rep(0, (N - 1))
for (j in 1 : (N - 1) ){
  lobj[j] <- func_obj_l_gauss(j)
}
df <- data.frame(x, lobj)
p <- ggplot(df, aes(x = x, y = lobj, color = 'darkred')) + geom_line() + xlab(TeX('Pixel $j$')) + ylab(TeX('$l(j)$')) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', NULL), TeX))
print(p)
# imprime em arquivo no diretorio  ~/Data/
#dfev <- data.frame(xev, evidencias)
#names(dfev) <- NULL
#setwd("../..")
#setwd("Data")
#sink("evid_real_flevoland_produto_3.txt")
#print(dfev)
#sink()
#setwd("..")
#setwd("Code/Code_r")
