# Autor: AAB data: 12/09/2018 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
func_obj_l_L_mu_razao <- function(param){
  j <- param
  Le <- matdf1[j,1]
  Ld <- matdf2[j,1]
  rhoe <- matdf1[j,2]
  rhod <- matdf2[j,2]
  taue <- matdf1[j,3]
  taud <- matdf2[j,3]
  aux1 <- Le * log(taue)
  aux2 <- log(gamma(2 * Le))
  aux3 <- Le * log(1 - abs(rhoe)^2)
  sig1 <- sum(log(taue + z[1: j])) / j
  aux4 <- sig1
  sig2 <- sum(log(z[1: j])) / j
  aux5 <- (Le - 1) * sig2
  aux6 <- 2 * log(gamma(Le))
  sig3  <- sum((taue + z[1: j])^2 - 4 * taue * abs(rhoe)^2 * z[1: j]) / j 
  aux7 <- ((2 * Le + 1) / 2) * sig3
  #
  aux8  <- Ld * log(taud)
  aux9  <- log(gamma(2 * Ld))
  aux10 <- Ld * log(1 - abs(rhod)^2)
  sig4  <- sum(log(taud + z[(j + 1): N])) / (N - j)
  aux11 <- sig4
  sig5  <- sum(log(z[(j + 1): N])) / (N - j)
  aux12 <- (Ld - 1) * sig5
  aux13 <- 2 * log(gamma(Ld))
  sig6   <- sum((taud + z[(j + 1): N])^2 - 4 * taud * abs(rhod)^2 * z[(j + 1): N]) / (N - j) 
  aux14 <- ((2 * Ld + 1) / 2) * sig6
  #
  a1 <-  aux1 + aux2 + aux3  + aux4  + aux5  - aux6  - aux7 
  a2 <-  aux8 + aux9 + aux10 + aux11 + aux12 - aux13 - aux14
  #### cuidado!!! sinal negativo, pois o GenSA minimiza uma funcao
  func_obj_l_L_mu_razao <- -(j * a1 + (N - j) * a2)   
  return(func_obj_l_L_mu_razao)
}
