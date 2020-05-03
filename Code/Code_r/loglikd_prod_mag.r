loglikd_prod_mag <- function(param){
  L   <- param[1]
  rho <- param[2]
  aux1 <- (L + 1) * log(L)
  aux2 <- L * sum(log(z[(j + 1): N])) / (N - j)
  aux3 <- log(gamma(L))
	aux4 <- log(1 - rho^2)
  aux5 <- sum(log(besselI((2 * rho * L * z[(j + 1): N]) / (1 - rho^2), 0))) / (N - j) 
  aux6 <- sum(log(besselK((2 * L * z[(j + 1): N]) / (1 - rho^2), L - 1))) / (N - j)
  ll <- aux1 + aux2 - aux3 - aux4 + aux5 + aux6  
	return(ll)
}

