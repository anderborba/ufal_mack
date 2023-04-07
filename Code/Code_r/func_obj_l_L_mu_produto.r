# Autor: AAB data: 12/09/2018 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
func_obj_l_L_mu_produto <- function(param){
  j <- param
  #Le <- matdf1[j,1]
  #Ld <- matdf2[j,1]
  #rhoe <- matdf1[j,2]
  #rhod <- matdf2[j,2]
  Le <- 4
  Ld <- 4
  rhoe <- 0.01
  rhod <- 0.2
  aux1 <- log(4)
  aux2 <- (Le + 1) * log(Le)
  sigma1 <- sum(z[1: j]) / j
  aux3 <- Le * sigma1
  aux4 <- log(gamma(Le))
  aux5 <- log(1 - abs(rhoe)^2)
  arg1 <- (2 * abs(rhoe) * Le) / (1 - abs(rhoe)^2) 
  sigma2 <- sum(log(besselI( arg1 * z[1 : j], 0))) / j
  aux6 <- sigma2
  arg2 <- (2 * Le) / (1 - abs(rhoe)^2)
  sigma3 <- sum(log(besselK(arg2 * z[1: j], Le - 1))) / j
  aux7 <- sigma3
  #
  aux8 <- log(4)
  aux9 <- (Ld + 1) * log(Ld)
  sigma1 <- sum(z[(j + 1): N]) / (N - j)
  aux10 <- Ld * sigma1
  aux11 <- log(gamma(Ld))
  aux12 <- log(1 - abs(rhod)^2)
  arg1 <- (2 * abs(rhod) * Ld) / (1 - abs(rhod)^2) 
  sigma2 <- sum(log(besselI( arg1 * z[(j + 1) : N], 0))) / (N - j)
  aux13 <- sigma2
  arg2 <- (2 * Ld) / (1 - abs(rhod)^2)
  sigma3 <- sum(log(besselK(arg2 * z[(j + 1): N], Ld - 1))) / (N - j)
  aux14 <- sigma3
  #
  a1 <-  aux1 + aux2 + aux3  - aux4  - aux5  + aux6  + aux7
  a2 <-  aux8 + aux9 + aux10 - aux11 - aux12 + aux13 + aux14 
  #### O sinal negativo, pois o GenSA minimiza uma funcao
  func_obj_l_L_mu_produto <- -(j * a1 + (N - j) * a2)   
  return(func_obj_l_L_mu_produto)
}
