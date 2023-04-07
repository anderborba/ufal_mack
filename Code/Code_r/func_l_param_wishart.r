## Estimate the parameter of wishart distribution
rm(list = ls())
require(maxLik)
require(ggplot2)
require(latex2exp)
require(nleqslv)
## Leitura do arquivo *.txt no diretorio /Data 
setwd("../..")
setwd("Data")
mat <- scan('real_flevoland_1.txt')
setwd("..")
setwd("Code/Code_r")
## retornou ao diretorio de trabalho /Code/Code_r
N <- 120
mat <- matrix(mat, ncol = N, byrow = TRUE)
z <-  mat[51, 1: N]
matdf <- matrix(0, nrow = N, ncol = 3)
for (index in 20 : 20){
  sigma <- z[index]
  loglik <- function(param) {
    L <- param[1]
    mu <- param[2]
    aux1 <- L * log(L)
    aux2 <- (L - 1) * log(sigma)
    aux3 <- L * log(mu)
    aux4 <- log(gamma(L))
    aux5 <- (L / mu) * sigma
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
dslnex <- function(L) {
  y <- numeric(1)
  #y <- L^3 - L
  y <- log(L) - digamma(L)
  y
}
xstart <- c(2)
# a solution is c(1,1)
res1 <- nleqslv(xstart, dslnex, control=list(btol=.0001))
#fun_der_l <- function(param){
#  L <- param
#  #ll <- log(L) - digamma(L)
#  ll <- L^3 - L
#}
#res1 <- solve(fun_der_l=0, start=c(1))
# escrita no diretorio /Text/Dissertacao/figura
#setwd("../..")
#setwd("Text/Dissertacao/figuras")
#ggsave("func_max_ver_L_4_z_80_flev_wishart.pdf")
#setwd("../../..")
#setwd("Code/Code_r")
# retornou ao diretorio /Code/Code_r
#print(p)