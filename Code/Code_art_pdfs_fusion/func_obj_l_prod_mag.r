# Coded by Anderson Borba data: 09/06/2020 version 1.0
# Article to appear 
# Article title
# Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C Frery
# The total log-likelihood presented in equation (4) in the article
#
# Input:  j  - Pixel localization
#         L_i  - Multilook numbers (guest parameter)
#         rho_i - Intensity channel (guest parameter)
#         i - Internal  or external region of the sample (e - internal, d - external)
# Output: Magnitude of product Function value
#
func_obj_l_prod_mag <- function(j){
  Le   <- matdf1[j,1]
  Ld   <- matdf2[j,1]
  rhoe <- matdf1[j,2]
  rhod <- matdf2[j,2]
  #
  soma1 <- sum(log(z[1: j]))
  soma2 <- sum(log(besselI((2 * rhoe * Le * z[1: j]) / (1 - rhoe^2), 0)))
  soma3 <- sum(log(besselK((2 *        Le * z[1: j]) / (1 - rhoe^2), Le - 1)))
  #
  aux1 <- (Le + 1) * log(Le) - log(gamma(Le)) - log(1 - rhoe^2)
  aux2 <- Le * soma1 / j
  aux3 <-      soma2 / j
  aux4 <-      soma3 / j
  a1 <- aux1 + aux2 + aux3 + aux4
  #
  soma1 <- sum(log(z[(j + 1): N]))
  soma2 <- sum(log(besselI((2 * rhod * Ld * z[(j + 1): N]) / (1 - rhod^2), 0)))
  soma3 <- sum(log(besselK((2 *        Ld * z[(j + 1): N]) / (1 - rhod^2), Ld - 1)))
  #
  aux1 <- (Ld + 1) * log(Ld) - log(gamma(Ld)) - log(1 - rhod^2)
  aux2 <- Ld * soma1 / (N - j)
  aux3 <-      soma2 / (N - j)
  aux4 <-      soma3 / (N - j)
  a2 <- aux1 + aux2 + aux3 + aux4
  func_obj_l_prod_mag <- -( j * a1 + (N - j) * a2)
  return(func_obj_l_prod_mag)
}