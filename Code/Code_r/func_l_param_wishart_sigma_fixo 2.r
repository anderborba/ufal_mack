## Estimate the parameter of wishart distribution
rm(list = ls())
require(maxLik)
require(ggplot2)
require(latex2exp)
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
index <- 81
sigma <- z[index]
mu <- z[index]
#mu <- sigma
loglik <- function(param) {
  #L <- param[1]
  #mu <- param[2]
  L <- param[1]
  aux1 <- L * log(L)
  aux2 <- (L - 1) * log(sigma)
  aux3 <- L * log(mu)
  aux4 <- log(gamma(L))
  aux5 <- (L / mu) * sigma
  ll <- aux1 + aux2 - aux3 - aux4 - aux5 
  ll
}
N <- 1000
x    <- rep(0, N)
lobj <- rep(0, N)
h <- 100 / N
for (j in 1 : N){
  x[j] <- j * h 
  lobj[j] <- loglik(x[j])
}
df <- data.frame(x, lobj)
p <- ggplot(df, aes(x = x, y = lobj, color = 'darkred')) +
  geom_line() + 
  xlab(TeX('$L$')) + 
  ylab(TeX('$\\ln(f_Z(z_i;L,\\mu))$')) +
  guides(color=guide_legend(title=NULL)) +
  scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', NULL), TeX))
#x <- rnorm(100, 1, 2) # use mean=1, stdd=2
#N <- length(x)
#res <- maxLik(loglik, start=c(0.1)) # use 'wrong' start values
#res <- maxBFGS(loglik, start=c(6,0.5)) # use 'wrong' start values
res <- maxBFGS(loglik, start=c(6)) # use 'wrong' start values
summary( res )
# escrita no diretorio /Text/Dissertacao/figura
#setwd("../..")
#setwd("Text/Dissertacao/figuras")
#ggsave("func_max_ver_sigma_81_flev_wishart.pdf")
#setwd("../../..")
#setwd("Code/Code_r")
# retornou ao diretorio /Code/Code_r
print(p)