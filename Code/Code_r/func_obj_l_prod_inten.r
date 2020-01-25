# Autor: AAB data: 06/06/2019 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
# Distribuicao de gauss
func_obj_l_prod_inten <- function(param){
  #Le <- 4
  #Ld <- 4
  Le <- matdf1[j, 1]
  Ld <- matdf2[j, 1]
  rhoe <- 0.4
  rhod <- 0.3
  for (i in 1: j){ 
    sig1e <- sum(z1[1: j]) / j
    sig2e <- sum(z2[1: j]) / j
  }
  aux1 <- (Le + 1) * log(Le)  
  aux2 <- 0.5 * (Le - 1) * sum(log(z1[1: j])) / j 
  aux3 <- 0.5 * (Le - 1) * sum(log(z2[1: j])) / j
  aux4 <- 0.5 * (Le + 1) * log(sig1e)
  aux5 <- 0.5 * (Le + 1) * log(sig2e) 
  aux6 <- log(gamma(Le)) + log(1 - rhoe^2)
  aux7 <- (Le - 1) * log(rhoe)
  aux8 <- -Le * (sum(z1[1: j]) / (j * sig1e) + sum(z2[1: j]) / (j * sig2e) ) / (1 - rhoe^2)
  aux9 <- sum(log(besselI(2 * Le * sqrt((z1[1: j] * z2[1: j]) / (sig1e * sig1e)) * rhoe / (1 - rhoe^2), Le - 1))) / j 
  soma1 <- aux1 + aux2 + aux3 - aux4 - aux5 - aux6 - aux7 + aux8 + aux9
  for (i in (j + 1) : N){
    sig1d <- sum(z1[(j + 1): N]) / (N - j)
    sig2d <- sum(z2[(j + 1): N]) / (N - j)
  }
  aux1 <- (Ld + 1) * log(Ld)  
  aux2 <- 0.5 * (Ld - 1) * sum(log(z1[(j + 1): N])) / (N - j)
  aux3 <- 0.5 * (Ld - 1) * sum(log(z2[(j + 1): N])) / (N - j)
  aux4 <- 0.5 * (Ld + 1) * log(sig1d)
  aux5 <- 0.5 * (Ld + 1) * log(sig2d) 
  aux6 <- log(gamma(Ld)) + log(1 - rhod^2)
  aux7 <- (Ld - 1) * log(rhod)
  aux8 <- -Ld * (sum(z1[(j + 1): N]) / ((N - j) * sig1d) + sum(z2[(j + 1): N]) / ((N - j) * sig2d) ) / (1 - rhod^2)
  aux9 <- sum(log(besselI(2 * Ld * sqrt((z1[(j + 1): N] * z2[(j + 1): N]) / (sig1d * sig1d)) * rhod / (1 - rhod^2), Ld - 1))) / (N - j)
  soma2 <- aux1 + aux2 + aux3 - aux4 - aux5 - aux6 - aux7 + aux8 + aux9
  func_obj_l_prod_inten <-  j * soma1 + (N - j) * soma2
  return(func_obj_l_prod_inten)
}

