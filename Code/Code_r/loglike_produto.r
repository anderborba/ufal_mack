loglike_produto <- function(param){
	L    <- param[1]
	rho  <- param[2]
	for (i in 1: j){
    		sig1 <- sum(z1[1: j]) / j
    		sig2 <- sum(z2[1: j]) / j
  		}
	aux1 <- (L + 1) * log(L)
  	aux2 <- 0.5 * (L - 1) * sum(log(z1[1: j])) / j
  	aux3 <- 0.5 * (L - 1) * sum(log(z2[1: j])) / j
  	aux4 <- 0.5 * (L + 1) * log(sig1)
  	aux5 <- 0.5 * (L + 1) * log(sig2)
  	aux6 <- log(gamma(L)) + log(1 - rho^2)
  	aux7 <- (L - 1) * log(rho)
  	aux8 <- -L * (sum(z1[1: j]) / (j * sig1) + sum(z2[1: j]) / (j * sig2) ) / (1 - rho^2)
  	aux9 <- sum(log(besselI(2 * L * sqrt((z1[1: j] * z2[1: j]) / (sig1 * sig1)) * rho / (1 - rho^2), L - 1))) / j
  	ll <- aux1 + aux2 + aux3 - aux4 - aux5 - aux6 - aux7 + aux8 + aux9
	return(ll)
	}

