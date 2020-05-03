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
source("func_obj_l_gauss.r")
source("func_obj_l_gauss_copia1.r")
source("loglike_prod_mag.r")
source("loglikd_prod_mag.r")
# Programa principal
setwd("../..")
setwd("Data")
# canais hh, hv, and vv
# canais para a + bi
mat1 <- scan('Phantom_nhfc_0.000_1_2_1.txt')
mat2 <- scan('Phantom_nhfc_0.000_1_2_2.txt')
mat3 <- scan('Phantom_nhfc_0.000_1_2_4.txt')
mat4 <- scan('Phantom_nhfc_0.000_1_2_5.txt')
setwd("..")
setwd("Code/Code_r")
mat1 <- matrix(mat1, ncol = 400, byrow = TRUE)
mat2 <- matrix(mat2, ncol = 400, byrow = TRUE)
mat3 <- matrix(mat3, ncol = 400, byrow = TRUE)
mat4 <- matrix(mat4, ncol = 400, byrow = TRUE)
d <- dim(mat1)
nrows <- d[1]
ncols <- d[2]
# Loop para toda a imagem
evidencias          <- rep(0, nrows)
evidencias_valores  <- rep(0, nrows)
xev  <- seq(1, nrows, 1 )
#for (k in 1 : nrows){
for (k in 10 : 10){
	print(k)
	N <- ncols
	z1    <- rep(0, N)
	z2    <- rep(0, N)
	z3    <- rep(0, N)
	z4    <- rep(0, N)
	zc    <- rep(0, N)
	zaux  <- rep(0, N)
	zaux1  <- rep(0, N)
	z1  <-  mat1[k,1:N]
	z2  <-  mat2[k,1:N]
	z3  <-  mat3[k,1:N]
	z4  <-  mat4[k,1:N]
	for (i in 1: N){
		zaux[i] = sqrt(z3[i]^2 + z4[i]^2)
	}
	conta = 0
  for (i in 1 : N){
	  if (zaux[i] > 0 && z1[i] > 0 && z2[i] > 0){
		  conta <- conta + 1
	    zaux[conta] <- zaux[i]
		  z1[conta] <- z1[i]
		  z2[conta] <- z2[i]
		  zaux1[conta] <-  zaux[i] / sqrt(z1[i] * z2[i])
	    }
  }
	indx  <- which(zaux1 != 0)
	N <- length(indx)
	z     <- rep(0, N)
	z[1: N]  <- zaux1[1: N]  
  matdf1 <- matrix(0, nrow = N, ncol = 2)
  matdf2 <- matrix(0, nrow = N, ncol = 2)
  for (j in 1 : N){
    r1 <- 4
    r2 <- z[j]
    #res1 <- maxSANN(loglike_prod_mag, grad = NULL, hess = NULL, start=c(r1, r2), fixed = NULL,
    #                print.level = 0, iterlim = 10000, constraints = NULL,
    #                tol = 1e-08, reltol=sqrt(.Machine$double.eps),
    #                finalHessian=TRUE,
    #                cand = NULL, temp = 10, tmax = 10,
    #                parscale = rep(1, length = length(start)),
    #                random.seed = 123)
	  res1 <- maxBFGS(loglike_prod_mag, start=c(r1, r2))
	  #res1 <- maxBFGSR(loglike_prod_mag, grad = NULL, hess = NULL, start, print.level = 0,
	  #                  tol = 1e-8, reltol=sqrt(.Machine$double.eps), gradtol = 1e-6,
	  #                  steptol = 1e-10, lambdatol=1e-6, qrtol=1e-10,
	  #                 iterlim = 150,
	  #                  constraints = NULL, finalHessian = TRUE,
	  #                 fixed = NULL, activePar = NULL)
	  #
	  #res1 <- maxNR(loglike_prod_mag, start=c(r1, r2))
	  #res1 <- maxNM(loglike_prod_mag, start=c(r1, r2))
    #res1 <- maxLik(loglike_prod_mag, start=c(r1, r2), activePar=c(TRUE, FALSE))
	  matdf1[j, 1] <- res1$estimate[1]
	  matdf1[j, 2] <- res1$estimate[2]
  	r1 <- 4 
    r2 <- z[j]
    #res2 <- maxSANN(loglikd_prod_mag, grad = NULL, hess = NULL, start=c(r1, r2), fixed = NULL,
    #                print.level = 0, iterlim = 10000, constraints = NULL,
    #                tol = 1e-08, reltol=sqrt(.Machine$double.eps),
    #                finalHessian=TRUE,
    #                cand = NULL, temp = 10, tmax = 10,
    #                parscale = rep(1, length = length(start)),
    #                random.seed = 123)
		res2 <- maxBFGS(loglikd_prod_mag, start=c(r1, r2))
		#res2 <- maxBFGSR(loglikd_prod_mag, grad = NULL, hess = NULL, start, print.level = 0,
		#         tol = 1e-8, reltol=sqrt(.Machine$double.eps), gradtol = 1e-6,
		#         steptol = 1e-10, lambdatol=1e-6, qrtol=1e-10,
		#         iterlim = 150,
		#         constraints = NULL, finalHessian = TRUE,
		#         fixed = NULL, activePar = NULL)
		#res2 <- maxNR(loglikd_prod_mag, start=c(r1, r2))
		#res2 <- maxNM(loglikd_prod_mag, start=c(r1, r2))
		#res2 <- maxLik(loglikd_prod_mag, start=c(r1, r2), activePar=c(TRUE, FALSE))
      if (j < N){
        matdf2[j, 1] <- res2$estimate[1]
	      matdf2[j, 2] <- res2$estimate[2]
	    }
  }
	cf    <- 14
	lower <- as.numeric(cf)
	upper <- as.numeric(N - cf)
	out   <- GenSA(lower = lower, upper = upper, fn = func_obj_l_gauss, control=list(maxit = 100))
	evidencias[k] <- out$par
	evidencias_valores[k] <- out$value
}
x <- seq(N - 1)
lobj <- rep(0, (N - 1))
for (j in 1 : (N - 1) ){
# GenSA minimiza funções
  lobj[j] <- func_obj_l_gauss(j)
}
df <- data.frame(x, lobj)
p <- ggplot(df, aes(x = x, y = lobj, color = 'darkred')) + geom_line() + xlab(TeX('Pixel $j$')) + ylab(TeX('$l(j)$')) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', NULL), TeX))
print(p)
# imprime em arquivo no diretorio  ~/Data/
dfev <- data.frame(xev, evidencias)
names(dfev) <- NULL
setwd("../..")
setwd("Data")
sink("evid_real_flevoland_produto_mag_param_L_rho_1_3.txt")
print(dfev)
sink()
setwd("..")
setwd("Code/Code_r")
