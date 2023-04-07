loglike_prod_mag_lee_eq_27 <- function(param){
  L   <- param[1] 
  rho <- param[2]
  aux1 <- (L + 1) * log(L)
  aux2 <- L * sum(log(z[1: j])) / j
  aux3 <- log(gamma(L))
  aux4 <- log(1 - rho^2)
  aux5 <- sum(log(besselI((2 * rho * L * z[1: j]) / ((1 - rho^2) *h[1: j]), 0))) / j 
  aux6 <- sum(log(besselK((2 * L * z[1: j]) / ((1 - rho^2) * h[1: j]) , L - 1))) / j
  aux7 <- L * sum(log(h[1: j])) / j
  ll <- aux1 + aux2 - aux3 - aux4 + aux5 + aux6 - aux7
  return(ll)
}
