teste_fun3d <- function(param){
  s1   <- param[1]
  s2   <- param[2]
  rho  <- param[3]
  ll <- -((s1 - 1)^2 + (s2 - 2)^2 + (rho - 3)^2)
  return(ll)
}