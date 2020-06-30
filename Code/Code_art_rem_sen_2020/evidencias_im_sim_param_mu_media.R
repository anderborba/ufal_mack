# Coded by Anderson Borba data: 21/06/2020 version 1.0
# The total log-likelihood presented in equation (X) in the article
# Article to appear 
# XXXXX
# Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C Frery
# 
# - The program reads an image of two halves 400 X 400 (channels hh, hv and vv) finds the parameters (mu)
#   by the BFGS method, and uses in function l(j) , calculating the point of max/min (edge evidence) by
#   the GenSA method.
# - The output of the program is a 400 size vector with the edge evidence for each line 
#   of the recorded image in a *.txt file
# obs: 1) Change the channels in the input and output files.
#      2) The code make to run samples in two halves with proposed sigmas in \cite{gamf} (see article).
#      3) Disable the print in file after running the tests of interest in order not to modify files unduly.
#
rm(list = ls())
library(ggplot2)
library(latex2exp)
require(tikzDevice)
require(GenSA)
require(maxLik)
#
source("func_obj_l_mu.R")
source("loglike_mu_gamma.R")
source("loglikd_mu_gamma.R")
source("estima_L.r")
# Main
setwd("../..")
setwd("Data")
# channels hh, hv, and vv
mat <- scan('Phantom_gamf_0.000_1_2_3.txt')
setwd("..")
setwd("Code/Code_art_rem_sen_2020")
#
r <- 400
nr <- r
N  <- r
mat <- matrix(mat, ncol = r, byrow = TRUE)
evidencias          <- rep(0, nr)
evidencias_valores  <- rep(0, nr)
xev  <- seq(1, nr, 1 )
for (k in 1 : nr){# k is radial lines
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
  L <- 4
  matdf1 <- matrix(0, nrow = N, ncol = 1)
  matdf2 <- matrix(0, nrow = N, ncol = 1)
  for (j in 1 : (N - 1)){
    r1 <- sum(z[1: j]) / j
    #res1 <- maxBFGS(loglike_mu_gamma, start=c(r1))
    r2 <- sum(z[(j + 1): N]) / (N - j)
    #res2 <- maxBFGS(loglikd_mu_gamma, start=c(r1))
    matdf1[j, 1] <- r1
    matdf2[j, 1] <- r2
  }
  lower <- as.numeric(14)
  upper <- as.numeric(N - 14)
  out   <- GenSA(lower = lower, upper = upper, fn = func_obj_l_mu, control=list( maxit =100))
  evidencias[k] <- out$par
  print(evidencias[k])
  evidencias_valores[k] <- out$value
}
x <- seq(N - 1)
lobj <- rep(0, (N - 1))
for (j in 1 : (N - 1) ){
  lobj[j] <- -func_obj_l_mu(j)
}
df <- data.frame(x, lobj)
p <- ggplot(df, aes(x = x, y = lobj, color = 'darkred')) +
  geom_line() + xlab(TeX("$j$")) +
  ylab(TeX("$l (j)$")) +
  guides(color=guide_legend(title=NULL)) +
  scale_color_discrete(labels= lapply(sprintf("$\\sigma_{hh} = %2.0f$", NULL), TeX))
print(p)
# imprime em arquivo no diretorio  ~/Data/
#dfev <- data.frame(xev, evidencias)
#names(dfev) <- NULL
#setwd("../..")
#setwd("Data")
#sink("evid_sim_gamf_3_param_mu_14_pixel.txt")
#print(dfev)
#sink()
#setwd("..")
#setwd("Code/Code_art_rem_sen_2020")
