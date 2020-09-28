loglike_produto_biv <- function(param){
  s1   <- param[1]
  s2   <- param[2]
  rho  <- param[3]
  #
  soma1 <- sum(z1[1: j])
  soma2 <- sum(z2[1: j])
  c1 <- 1.0 /  (s1 * s2)^0.5
  c2 <-  rho / (1 - rho^2)
  soma3 <- sum(log(besselK(2 * L * (z1[1: j] * z2[1: j])^0.5 * c1 * c2, L - 1)))
  #
  aux1  <- log(1 - rho^2)
  aux2  <- (L - 1) * log(rho)
  aux3  <- 0.5 * (L + 1) * log(s1)
  aux4  <- 0.5 * (L + 1) * log(s2)
  aux5  <- (L / (s1 * (1 - rho^2))) * soma1 / j
  aux6  <- (L / (s2 * (1 - rho^2))) * soma2 / j
  aux7  <- soma3 / j
  ll <- -aux1 - aux2 - aux3 - aux4 - aux5 - aux6 + aux7
  return(ll)
}