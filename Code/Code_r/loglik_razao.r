loglik_razao <- function(param){
  tau  <- param[1]
  rho  <- param[2]
  soma1 <- 0
  soma2 <- 0
  soma3 <- 0
  for (k in Ni : Nf){
    soma1 <- soma1 + log(tau + z[k])
    soma2 <- soma2 + log(z[k])
    soma3 <- soma3 + log((tau + z[k])^2 - 4 * tau * abs(rho)^2 * z[k])
  }
  #soma1 <- sum(log(tau + z[Ni:Nf]))
  #soma2 <- sum(log(z[Ni:Nf]))
  #soma3 <- sum(log((tau + z[Ni:Nf])^2 - 4 * tau * abs(rho)^2 * z[Ni:Nf]))
  aux1 <- L * log(tau)
  aux2 <- log(gamma(2 * L))
  aux3 <- L * log(1 - abs(rho)^2)
  aux4 <- 2 * log(gamma(L))
  aux5 <- soma1 / (Nf - (Ni - 1))
  aux6 <- L * soma2 / (Nf - (Ni - 1)) 
  aux7 <- (0.5 * (2 * L + 1)) * soma3 / (Nf - (Ni - 1))
  ll <- aux1 + aux2 + aux3 - aux4 + aux5 + aux6 - aux7
  return(ll)
}