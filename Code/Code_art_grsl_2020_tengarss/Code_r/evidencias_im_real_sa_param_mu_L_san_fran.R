rm(list = ls())
require(ggplot2)
require(latex2exp)
require(GenSA)
require(maxLik)
#
source("func_obj_l_L_mu.r")
source("loglike.r")
source("loglikd.r")
# Programa principal
setwd("../../..")
setwd("Data")
# canais hh, hv, and vv 
mat <- scan('real_san_fran_r1_3.txt')
setwd("..")
setwd("Code/Code_art_grsl_2020_tengarss/Code_r")
########## setup para a imagem de flevoland
r <- 120
nr <- 25
mat <- matrix(mat, ncol = r, byrow = TRUE)
evidencias          <- rep(0, nr)
evidencias_valores  <- rep(0, nr)
xev  <- seq(1, nr, 1 )
for (k in 1 : nr){# j aqui varre o número de radiais
#for (k in 20: 20){# j aqui varre o número de radiais
  print(k)
  N <- r
  z <- rep(0, N)
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
  for (j in 1 : (N - 1)){
    r1 <- 1
    r2 <- sum(z[1: j]) / j
    res1 <- maxBFGS(loglike, start=c(r1, r2))
    matdf1[j, 1] <- res1$estimate[1]
    matdf1[j, 2] <- res1$estimate[2]
    r1 <- 1
    r2 <- sum(z[(j + 1): N]) / (N - j)
    res2 <- maxBFGS(loglikd, start=c(r1, r2))
    matdf2[j, 1] <- res2$estimate[1]
    matdf2[j, 2] <- res2$estimate[2]
  }
  lim <- as.numeric(25)
  lower <- lim
  upper <- N - lim 
  out   <- GenSA(lower = lower, upper = upper, fn = func_obj_l_L_mu, control=list( maxit =100))
  evidencias[k] <- out$par
  print(evidencias[k])
  evidencias_valores[k] <- out$value
}
x <- seq(N - 1)
lobj <- rep(0, (N - 1))
for (j in 1 : (N - 1) ){
  lobj[j] <- func_obj_l_L_mu(j)
}
df <- data.frame(x, lobj)
p <- ggplot(df, aes(x = x, y = lobj, color = 'darkred')) + geom_line() + xlab(TeX('Pixel $j$')) + ylab(TeX('$l(j)$')) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', NULL), TeX))
print(p)
# imprime em arquivo no diretorio  ~/Data/
dfev <- data.frame(xev, evidencias)
names(dfev) <- NULL
setwd("../../..")
setwd("Data")
sink("evid_real_sf_3_param_L_mu_25_pixel_r1.txt")
print(dfev)
sink()
setwd("..")
setwd("Code/Code_art_grsl_2020_tengarss/Code_r")
