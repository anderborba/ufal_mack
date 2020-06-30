# Coded by Anderson Borba data: 22/06/2020 version 1.0
# The total log-likelihood presented in equation (X) in the article
# Article to appear 
# XXXXX
# Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C Frery
# 
# - The program reads an image of two halves 400 X 400 (channels hh, hv and vv) finds the parameters (rho)
#   by the BFGS method, and uses in function l(j) , calculating the point of max/min (edge evidence) by
#   the GenSA method.
# - The output of the program is a 400 size vector with the edge evidence for each line 
#   of the recorded image in a *.txt file
# obs: 1) Change the channels in the input and output files.
#      2) The code make to run samples in two halves with proposed sigmas in \cite{gamf} (see article).
#      3) Disable the print in file after running the tests of interest in order not to modify files unduly.
rm(list = ls())
require(ggplot2)
require(latex2exp)
require(GenSA)
require(maxLik)
#
source("func_obj_l_prod_mag.r")
source("loglike_prod_mag.r")
source("loglikd_prod_mag.r")
source("estima_L.r")
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
# Loop para toda a imagem
evidencias          <- rep(0, nrows)
evidencias_valores  <- rep(0, nrows)
xev  <- seq(1, nrows, 1 )
#L <- 4
#for (k in 1 : nrows){
for (k in 120 : 120){
	print(k)
	N <- ncols
	z1     <- rep(0, N)
	z2     <- rep(0, N)
	z3     <- rep(0, N)
	z4     <- rep(0, N)
	zaux1  <- rep(0, N)
	z1  <-  mat1[k,1:N]
	z2  <-  mat2[k,1:N]
	z3  <-  mat3[k,1:N]
	z4  <-  mat4[k,1:N]
	conta = 0
  for (i in 1 : N){
	  if (z1[i] > 0 && z2[i] > 0){
		  conta <- conta + 1
		  zaux1[conta] <- (z3[i]^2 + z4[i]^2)^0.5 / (z1[i] * z2[i])^0.5
	    }
  }
	indx  <- which(zaux1 != 0)
	N <- length(indx)
	z <- rep(0, N)
	z[1: N]  <- zaux1[1: N]
  matdf1 <- matrix(0, nrow = N, ncol = 1)
  matdf2 <- matrix(0, nrow = N, ncol = 1)
  L <- 4
  for (j in 1 : (N - 1)){
    r1 <- 0.01
    res1 <- maxBFGS(loglike_prod_mag, start=c(r1))
	  matdf1[j, 1] <- res1$estimate[1]
    r1 <- 0.01
    res2 <- maxBFGS(loglikd_prod_mag, start=c(r1))
    matdf2[j, 1] <- res2$estimate[1]
  }
	cf    <- 14
	lower <- as.numeric(cf)
	upper <- as.numeric(N - cf)
	out   <- GenSA(lower = lower, upper = upper, fn = func_obj_l_prod_mag, control=list(maxit = 100))
	evidencias[k] <- out$par
	print(evidencias[k])
	evidencias_valores[k] <- out$value
}
x <- seq(N - 1)
lobj <- rep(0, N - 1)
for (j in 1 : (N - 1)){
  lobj[j] <- func_obj_l_prod_mag(j)
}
df <- data.frame(x, lobj)
p <- ggplot(df, aes(x = x, y = lobj, color = 'darkred')) + geom_line() + xlab(TeX('Pixel $j$')) + ylab(TeX('$l(j)$')) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', NULL), TeX))
print(p)
# imprime em arquivo no diretorio  ~/Data/
#dfev <- data.frame(xev, evidencias)
#names(dfev) <- NULL
#setwd("../..")
#setwd("Data")
#sink("evid_real_flevoland_produto_mag_param_L_rho_1_3.txt")
#print(dfev)
#sink()
#setwd("..")
#setwd("Code/Code_art_rem_sen_2020")
