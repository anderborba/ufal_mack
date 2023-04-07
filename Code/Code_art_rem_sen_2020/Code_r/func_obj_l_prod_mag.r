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
  Le   <- L
  Ld   <- L
  rhoe <- matdf1[j,1]
  rhod <- matdf2[j,1]
  #
  soma1 <- sum(log(besselI((2 * rhoe * Le * z[1: j]) / (1 - rhoe^2), 0)))
  soma2 <- sum(log(besselK((2 *        Le * z[1: j]) / (1 - rhoe^2), Le - 1)))
  #
  aux1 <- log(1 - rhoe^2)
  aux2 <-      soma1 / j
  aux3 <-      soma2 / j
  a1 <- -aux1 + aux2 + aux3
  #
  soma1 <- sum(log(besselI((2 * rhod * Ld * z[(j + 1): N]) / (1 - rhod^2), 0)))
  soma2 <- sum(log(besselK((2 *        Ld * z[(j + 1): N]) / (1 - rhod^2), Ld - 1)))
  #
  aux1 <- log(1 - rhod^2)
  aux2 <-      soma1 / (N - j)
  aux3 <-      soma2 / (N - j)
  a2 <- -aux1 + aux2 + aux3
  func_obj_l_prod_mag <- -( j * a1 + (N - j) * a2)
  return(func_obj_l_prod_mag)
}