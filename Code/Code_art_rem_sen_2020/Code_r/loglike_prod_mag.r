# Coded by Anderson Borba data: 22/06/2020 version 1.0
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
  rho <- param[1]
  #
  soma1 <- sum(log(besselI((2 * rho * L * z[1: j]) / (1 - rho^2), 0)))
  soma2 <- sum(log(besselK((2       * L * z[1: j]) / (1 - rho^2), L - 1)))
  #
  aux1 <- log(1 - rho^2)
  aux2 <-     soma1 / j
  aux3 <-     soma2 / j
  ll <- -aux1 + aux2 + aux3
  return(ll)
}