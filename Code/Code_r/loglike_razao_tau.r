loglike_razao_tau <- function(param){
  L   <- param[1]
  rho <- param[2]
  aux1 <- L * sum(log(tau[1 : j])) / j
  aux2 <- log(gamma(2 * L))
  aux3 <- L * log(1 - rho^2)
  aux4 <- L * sum(log(z[1 : j])) / j
  aux5 <- 2 * log(gamma(L))
  aux6 <- (0.5 * (2 * L + 1)) * sum(log((tau[1: j] + z[1: j])^2 - 4 * tau[j] * rho^2 * z[1: j])) / j
  ll <- aux1 + aux2 + aux3 + aux4 - aux5 - aux6
  return(ll)
}
