loglikd_razao <- function(param){
          L   <- param[1]
          tau <- param[2]
          rho <- param[3]
          aux1 <- L * log(tau)
          aux2 <- log(gamma(2 * L))
          aux3 <- L * log(1 - rho^2)
          aux4 <- sum(log(tau + z[(j + 1): N])) / (N - j)
          aux5 <- (L - 1) * sum(log(z[(j + 1) : N])) / (N - j)
          aux6 <- 2 * log(gamma(L))
          aux7 <- (0.5 * (2 * L + 1)) * sum(log((tau + z[(j + 1): N])^2 - 4 * tau * rho^2 * z[(j + 1): N])) / (N - j)
            ll <- aux1 + aux2 + aux3 + aux4 + aux5 - aux6 - aux7 
            ll
	    return(ll)
          }

