loglike_prod_mag <- function(param){
          L   <- param[1]
	  #h <- sqrt(sum(z1[1: j])  * sum(z2[1: j]) / (j * j)) 
          rho <- param[2]
          h <- param[3]
          aux1 <- log(4)
          aux2 <- (L + 1) * log(L)
          aux3 <- L * sum(log(z[1: j])) / j
          aux4 <- log(gamma(L))
	  aux5 <- log(1 - rho^2)
	  aux6 <- (L + 1) * log(h)
          aux7 <- sum(log(besselI((2 * rho * L * z[1: j]) / ((1 - rho^2) * h) , 0))) / j 
          aux8<-  sum(log(besselK((2 * L * z[1: j]) / ((1 - rho^2) * h), L - 1))) / j
            ll <- aux1 + aux2 + aux3 - aux4 - aux5 - aux6 + aux7 + aux8 
            ll
	    return(ll)
          }

