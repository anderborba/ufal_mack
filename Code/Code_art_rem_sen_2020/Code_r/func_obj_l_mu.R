# Coded by Anderson Borba data: 21/06/2020 version 1.0
# Article to appear 
# XXXX
# Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C Frery
# The total log-likelihood presented in equation (X) in the article
#
# Input:  j  - Pixel localization
#         L_i  - Multilook numbers (fixed parameter)
#         mu_i - Intensity channel (guest parameter)
#         i - Internal  or external region of the sample (e - internal, d - external)
# Output: Gamma Function value
#
func_obj_l_mu <- function(param){
  j <- param
  #Le <- L
  #Ld <- L
  mue <- matdf1[j, 1]
  mud <- matdf2[j, 1]
  #
  aux1 <- log(mue)
  aux2 <- sum(z[1:j]) / (j * mue)
  #
  aux3 <- log(mud) 
  aux4 <- sum(z[(j + 1): N]) / ((N - j) * mud) 
  #
  a1 <-  -aux1 - aux2
  a2 <-  -aux3 - aux4
  #### O sinal negativo, pois o GenSA minimiza uma funcao
  func_obj_l_mu <- -(j * a1 + (N - j) * a2)   
return(func_obj_l_mu)
}