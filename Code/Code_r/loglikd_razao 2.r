loglikd_razao <- function(param){
          L   <- param[1]
          rho <- param[2]
          aux1 <- log(gamma(2 * L))
          aux2 <- L * log(1 - rho^2)
          aux3 <- L * sum(log(z[(j + 1) : N])) / (N - j)
          aux4 <- 2 * log(gamma(L))
          aux5 <- (0.5 * (2 * L + 1)) * sum(log((1 + z[(j + 1): N])^2 - 4 * rho^2 * z[(j + 1): N])) / (N - j)
            ll <- aux1 + aux2 + aux3 - aux4 - aux5
	    return(ll)
          }

