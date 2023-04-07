loglik_prod_mag_lee_eq26 <- function(param){
  L   <- param[1]
  rho <- param[2]
  soma1 <- 0
  soma2 <- 0
  soma3 <- 0
  for (k in Ni : Nf){
    soma1 <- soma1 + log(z[k])
    soma2 <- soma2 + log(besselI((2 * rho * L * z[k]) / (1 - rho^2), 0))
    soma3 <- soma3 + log(besselK((2 * L * z[k]) / (1 - rho^2), L - 1))
  }
  aux1 <- (L + 1) * log(L) - log(gamma(L)) - log(1 - rho^2)
  aux2 <- L * soma1 / (Nf - (Ni -1))
  aux3 <- soma2 / (Nf - (Ni - 1))
  aux4 <- soma3 / (Nf - (Ni - 1))
  ll <- aux1 + aux2 + aux3 + aux4
  return(ll)
}