# Autor: AAB data: 12/09/2018 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
func_obj_l_L_mu <- function(param){
  j <- param
  Le <- matdf1[j,1]
  Ld <- matdf2[j,1]
  mue <- matdf1[j,2]
  mud <- matdf2[j,2]
  soma_aux1 <- matsig[j, 1]
  soma_aux2 <- matsig[j, 2]
  soma_aux3 <- matsig[j, 3]
  soma_aux4 <- matsig[j, 4]
  aux1 <- Le * log(Le)
  aux2 <- Le * log(mue)
  aux3 <- log(gamma(Le))
  aux4 <- (Le - 1)   *  soma_aux1
  aux5 <- (Le / mue) *  soma_aux2
  #
  aux6 <- Ld * log(Ld)
  aux7 <- Ld* log(mud)
  aux8 <- log(gamma(Ld))
  aux9 <- (Ld - 1) *  soma_aux3 
  aux10 <-  (Ld / mud) * sum(z[(j + 1):N])/(N - j) 
  #
  a1 <-  aux1 - aux2 - aux3 + aux4 - aux5
  a2 <-  aux6 - aux7 - aux8 + aux9 - aux10
  #### O sinal negativo, pois o GenSA minimiza uma funcao
  func_obj_l_L_mu <- -(j * a1 + (N - j) * a2)   
  return(func_obj_l_L_mu)
}
