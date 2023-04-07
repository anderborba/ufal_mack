# Coded by Anderson Borba data: 09/06/2020 version 1.0
# Article to appear 
# Article title:
# Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C. Frery
#
# The reduced likelihood function presented in the article
# Input:  L  - Multilook numbers
#         mu - Intensity channel
# Output: Magnitude og product function value to left(internal) side fixed pixel j.
#
loglike_prod_mag <- function(param){
  L   <- param[1]
  rho <- param[2]
  #
  soma1 <- sum(log(z[1: j]))
  soma2 <- sum(log(besselI((2 * rho * L * z[1: j]) / (1 - rho^2), 0)))
  soma3 <- sum(log(besselK((2 * L * z[1: j]) / (1 - rho^2), L - 1)))
  #
  aux1 <- (L + 1) * log(L) - log(gamma(L)) - log(1 - rho^2)
  aux2 <- L * soma1 / j
  aux3 <-     soma2 / j
  aux4 <-     soma3 / j
  ll <- aux1 + aux2 + aux3 + aux4
  return(ll)
}