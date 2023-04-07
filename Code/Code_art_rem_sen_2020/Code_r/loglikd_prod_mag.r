# Coded by Anderson Borba data: 09/06/2020 version 1.0
# Article to appear 
# Article title:
# Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C. Frery
#
# The reduced likelihood function presented in the article
# Input:  L  - Multilook numbers
#         mu - Intensity channel
# Output: Magnitude og product function value to left(external) side fixed pixel j.
#
loglikd_prod_mag <- function(param){
  rho <- param[1]
  #
  soma1 <- sum(log(besselI((2 * rho * L * z[(j + 1): N]) / (1 - rho^2), 0)))
  soma2 <- sum(log(besselK((2 *       L * z[(j + 1): N]) / (1 - rho^2), L - 1)))
  #
  aux1 <- log(1 - rho^2)
  aux2 <-     soma1 / (N - j)
  aux3 <-     soma2 / (N - j)
  ll <- -aux1 + aux2 + aux3
  return(ll)
}