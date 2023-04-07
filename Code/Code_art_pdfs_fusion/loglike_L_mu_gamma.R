# Coded by Anderson Borba data: 05/06/2020 version 1.0
# Article to appear 
# Fusion of Evidences in Intensities Channels for Edge Detection in PolSAR Images
# Anderson A. de Borba, Maurı́cio Marengoni, and Alejandro C. Frery
#
# The reduced likelihood function presented in equation (3) in the article
# Input:  L  - Multilook numbers
#         mu - Intensity channel
# Output: Function value to left (internal) side fixed pixel j.
#
loglike_L_mu_gamma <- function(param){
  L    <- param[1]
  mu   <- param[2]
  aux1 <- L * log(L)
  aux2 <- (L - 1) * sum(log(z[1: j])) / j
  aux3 <- L * log(mu)
  aux4 <- log(gamma(L))
  aux5 <- (L / mu) * sum(z[1: j]) /  j
  ll   <- aux1 + aux2 - aux3 - aux4 - aux5
  return(ll)
}