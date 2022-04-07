loglik_produto_biv <- function(param){
  s1   <- param[1]
  s2   <- param[2]
  rho  <- param[3]
  #
  soma1 <- sum(log(z1[Ni: Nf]))
  soma2 <- sum(log(z2[Ni: Nf]))
  soma3 <- sum(z1[Ni: Nf])
  soma4 <- sum(z2[Ni: Nf])
  soma5 <- sum(log(besselK(2 * L * ((1 * z1[Ni: Nf] * z2[Ni: Nf]) / (s1 * s2))^0.5 * rho / (1 - rho^2), L - 1)))
  #
  aux1  <- (L + 1) * log(L)
  aux2  <- log(gamma(L))
  aux3  <- log(1 - rho^2)
  aux4  <- (L - 1) * log(rho)
  aux5  <- 0.5 * L * log(s1)
  aux6  <- 0.5 * L * log(s2)
  aux7  <- 0.5 * L * soma1 / (Nf - (Ni - 1))
  aux8  <- 0.5 * L * soma2 / (Nf - (Ni - 1))
  aux9  <- (L / (s1 * (1 - rho^2))) * soma3 / (Nf - (Ni - 1))
  aux10 <- (L / (s2 * (1 - rho^2))) * soma4 / (Nf - (Ni - 1))
  aux11 <- soma5 / (Nf - (Ni - 1))
  ll <- aux1 - aux2 - aux3 - aux4 - aux5 - aux6 + aux7 + aux8 - aux9 - aux10 + aux11
  return(ll)
}