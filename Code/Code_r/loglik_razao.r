loglik_razao <- function(param){
  L   <- param[1]
  rho <- param[2]
  aux1 <- log(gamma(2 * L))
  aux2 <- L * log(1 - rho^2)
  aux3 <- L * sum(log(z[1 : j])) / j
  aux4 <- 2 * log(gamma(L))
  aux5 <- (0.5 * (2 * L + 1)) * sum(log((1 + z[1: j])^2 - 4 * rho^2 * z[1: j])) / j
  ll <- aux1 + aux2 + aux3 - aux4 - aux5
  return(ll)
}