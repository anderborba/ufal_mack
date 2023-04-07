# Coded by Anderson Borba data: 21/06/2020 version 1.0
# Article to appear 
# XXXX
# Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C. Frery
#
# The reduced likelihood function presented in equation (3) in the article
# Input:  L  - Multilook numbers - fixed
#         mu - Intensity channel
# Output: Function value to left (internal) side fixed pixel j.
#
loglike_mu_gamma <- function(param){
  mu   <- param[1]
  aux1 <- log(mu)
  aux2 <- sum(z[1: j]) /  (j * mu)
  ll   <- - aux1 - aux2
  return(ll)
}