## Estimate the parameter of wishart distribution
#rm(list = ls())
require(maxLik)
require(ggplot2)
require(latex2exp)
require(GenSA)
source("fpmgamma.r")
## Leitura do arquivo *.txt no diretorio /Data 
setwd("../..")
setwd("Data")
mat <- scan('real_flevoland_1.txt')
setwd("..")
setwd("Code/Code_r")
## retornou ao diretorio de trabalho /Code/Code_r
N <- 120
mat <- matrix(mat, ncol = N, byrow = TRUE)
zaux <- matrix(0, 1, N)
zaux <-  mat[1, 1: N] 
indx <- which(zaux != 0)
N <- max(indx)
z <-  mat[1, 1: N] 
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
# escrita no diretorio /Text/Dissertacao/figura
#setwd("../..")
#setwd("Text/Dissertacao/figuras")
#ggsave("func_max_ver_L_4_z_80_flev_wishart.pdf")
#setwd("../../..")
#setwd("Code/Code_r")
# retornou ao diretorio /Code/Code_r
#print(p)
