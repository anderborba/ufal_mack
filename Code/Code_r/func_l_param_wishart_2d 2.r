## Estimate the parameter of wishart distribution
rm(list = ls())
require(maxLik)
require(ggplot2)
require(latex2exp)
## Leitura do arquivo *.txt no diretorio /Data 
setwd("../..")
setwd("Data")
#mat <- scan('real_flevoland_1.txt')
mat <- scan('Phantom_nhfc_0.000_1_2_1.txt')
setwd("..")
setwd("Code/Code_r")
## retornou ao diretorio de trabalho /Code/Code_r
N <- 400
mat <- matrix(mat, ncol = N, byrow = TRUE)
z <-  mat[51, 1: N]
matdf <- matrix(0, nrow = N, ncol = 2)
for (index in 1 : N){
  sigma1 <- sum(log(z[1:index]))
  sigma2 <- sum(z[1:index])
  loglik <- function(param) {
    L <- param[1]
    mu <- param[2]
    aux1 <- N * L * log(L)
    aux2 <- (L - 1) * sigma1
    aux3 <- N * L * log(mu)
    aux4 <- N * log(gamma(L))
    aux5 <- (L / mu) * sigma2
    ll <- aux1 + aux2 - aux3 - aux4 - aux5 
    ll
  }
  r1 <- runif(1, 0, 10)
  r2 <- runif(1, 0, 1)
  res <- maxBFGS(loglik, start=c(r1,r2)) # use 'wrong' start values
  summary( res )
  matdf[index, 1] <- res$estimate[1]
  matdf[index, 2] <- res$estimate[2]
}
#loglik_L_mu <- function(param) {
#  j <- param
#  aux1 <- N * L * log(L)
#  aux2 <- (L - 1) * sigma1
#  aux3 <- N * L * log(mu)
#  aux4 <- N * log(gamma(L))
#  aux5 <- (L / mu) * sigma2
#  ll <- aux1 + aux2 - aux3 - aux4 - aux5 
#  ll
#}
# escrita no diretorio /Text/Dissertacao/figura
#setwd("../..")
#setwd("Text/Dissertacao/figuras")
#ggsave("func_max_ver_L_4_z_80_flev_wishart.pdf")
#setwd("../../..")
#setwd("Code/Code_r")
# retornou ao diretorio /Code/Code_r
#print(p)