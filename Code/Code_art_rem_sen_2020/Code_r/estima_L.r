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
estima_L <- function(z, j){
  #
  Na <- j
  m1  <- mean(z[1 : Na])
  sd1 <- sd(z[1 : Na])
  cv1 <- sd1 / m1
  L1  <- 1.0 / cv1^2
  #
  m2  <- mean(z[(Na + 1) : N])
  sd2 <- sd(z[(Na + 1): N])
  cv2 <- sd2 / m2
  L2  <- 1.0 / cv2^2
  #
  L = 0.5 * (L1 + L2)
  estima_L   <- L
  return(estima_L)
}