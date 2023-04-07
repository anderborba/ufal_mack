func_l_param_wishart_2d_to_j_function <- function(){
  #j <- param
  #matdf1 <- 0.0
  #matdf2 <- 0.0
  #matsig <- 0.0
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
    #return(func_l_param_wishart_2d_to_j_function)
  return(list(matdf1, matdf2, matsig))
}  