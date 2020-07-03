loglikd_razao <- function(param){
  tau  <- param[1]
  rho  <- param[2]
  #
  soma1 <- sum(log(tau + z[(j + 1): N]))
  soma2 <- sum(log((tau + z[(j + 1): N])^2 - 4 * tau * abs(rho)^2 * z[(j + 1): N]))
  aux1 <- L * log(tau)
  aux2 <- L * log(1 - abs(rho)^2)
  aux3 <- soma1 / (N - j)
  aux4 <- (0.5 * (2 * L + 1)) * soma2 / (N - j)
  ll <- aux1 + aux2 + aux3 - aux4
  return(ll)
}