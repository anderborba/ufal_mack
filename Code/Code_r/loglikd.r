loglikd <- function(param){
	  L    <- param[1]
	  mu   <- param[2]
	  aux1 <- L * log(L)
  	aux2 <- (L - 1) * sum(log(z[(j + 1): N])) / (N - j)
  	aux3 <- L * log(mu) 
  	aux4 <- log(gamma(L))
  	aux5 <- (L / mu) * sum(z[(j + 1): N]) / (N - j) 
  	ll   <- aux1 + aux2 - aux3 - aux4 - aux5 
	return(ll)
	}

