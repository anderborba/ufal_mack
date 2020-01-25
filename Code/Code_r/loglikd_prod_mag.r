loglikd_prod_mag <- function(param){
          L   <- param[1]
	  #h <- sqrt(sum(z1[(j + 1): N])  * sum(z2[(j + 1): N]) / (N - j)^2)
          rho <- param[2]
          h <- param[3]
          aux1 <- log(4)
          aux2 <- (L + 1) * log(L)
          aux3 <- L * sum(log(z[(j + 1): N])) / (N - j)
          aux4 <- log(gamma(L))
	  aux5 <- log(1 - rho^2)
	  aux6 <- (L + 1) * log(h)
          aux7 <- sum(log(besselI((2 * rho * L * z[(j + 1): N]) / ((1 - rho^2) * h) , 0))) / (N - j) 
          aux8<-  sum(log(besselK((2 * L * z[(j + 1): N]) / ((1 - rho^2) * h), L - 1))) / (N - j)
            ll <- aux1 + aux2 + aux3 - aux4 - aux5 - aux6 + aux7 + aux8 
            ll
	    return(ll)
          }

