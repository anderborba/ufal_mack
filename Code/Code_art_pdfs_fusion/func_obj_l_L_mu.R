# Coded by Anderson Borba data: 05/06/2020 version 1.0
# Article to appear 
# Fusion of Evidences in Intensities Channels for Edge Detection in PolSAR Images
# Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C Frery
# The total log-likelihood presented in equation (4) in the article
#
# Input:  j  - Pixel localization
#         L_i  - Multilook numbers (guest parameter)
#         mu_i - Intensity channel (guest parameter)
#         i - Internal  or external region of the sample (e - internal, d - external)
# Output: Gamma Function value
#
func_obj_l_L_mu <- function(param){
  j <- param
  Le <- matdf1[j,1]
  Ld <- matdf2[j,1]
  mue <- matdf1[j,2]
  mud <- matdf2[j,2]
  #
  aux1 <- Le * log(Le)
  aux2 <- (Le - 1) * sum(log(z[1: j])) / j
  aux3 <- Le * log(mue)
  aux4 <- log(gamma(Le))
  aux5 <- (Le / mue) *  sum(z[1:j]) / j
  #
  aux6  <- Ld * log(Ld)
  aux7  <- (Ld - 1) * sum(log(z[(j + 1): N])) / (N - j)
  aux8  <- Ld * log(mud) 
  aux9  <- log(gamma(Ld)) 
  aux10 <- (Ld / mud) * sum(z[(j + 1): N]) / (N - j) 
  #
  a1 <-  aux1 + aux2 - aux3 - aux4 - aux5
  a2 <-  aux6 + aux7 - aux8 - aux9 - aux10
  #### O sinal negativo, pois o GenSA minimiza uma funcao
  func_obj_l_L_mu <- -(j * a1 + (N - j) * a2)   
return(func_obj_l_L_mu)
}