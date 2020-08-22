# Autor: AAB data: 12/09/2018 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
#func_obj_l_L_mu_produto_biv <- function(param){
func_obj_l_L_mu_produto_biv <- function(param){
  j <- param
  s1e   <- matdf1[j,1]
  s2e   <- matdf1[j,2]
  rhoe  <- matdf1[j,3]
  #
  s1d   <- matdf2[j,1]
  s2d   <- matdf2[j,2]
  rhod  <- matdf2[j,3]
  #
  soma1 <- sum(z1[1: j])
  soma2 <- sum(z2[1: j])
  c1 <- 1.0 /  (s1e * s2e)^0.5
  c2 <-  rhoe / (1 - rhoe^2)
  soma3 <- sum(log(besselK(2 * L * (z1[1: j] * z2[1: j])^0.5 * c1 * c2, L - 1)))
  #
  aux1  <- log(1 - rhoe^2)
  aux2  <- (L - 1) * log(rhoe)
  aux3  <- 0.5 * (L + 1) * log(s1e)
  aux4  <- 0.5 * (L + 1) * log(s2e)
  aux5  <- (L / (s1e * (1 - rhoe^2))) * soma1 / j
  aux6  <- (L / (s2e * (1 - rhoe^2))) * soma2 / j
  aux7  <- soma3 / j
  a1 <- -aux1 - aux2 - aux3 - aux4 - aux5 - aux6 + aux7
  #
  soma1 <- sum(z1[(j + 1): N])
  soma2 <- sum(z2[(j + 1): N])
  c1 <- 1.0 / (s1d * s2d)^0.5
  c2 <- rhod / (1 - rhod^2)
  soma3 <- sum(log(besselK(2 * L * (z1[(j + 1): N] * z2[(j + 1): N])^0.5 * c1 * c2, L - 1)))
  #
  aux1  <- log(1 - rhod^2)
  aux2  <- (L - 1) * log(rhod)
  aux3  <- 0.5 * (L + 1) * log(s1d)
  aux4  <- 0.5 * (L + 1) * log(s2d)
  aux5  <- (L / (s1d * (1 - rhod^2))) * soma1 / (N - j)
  aux6 <- (L / (s2d * (1 - rhod^2))) * soma2 / (N - j)
  aux7 <- soma3 / (N - j)
  a2 <- -aux1 - aux2 - aux3 - aux4 - aux5 - aux6 + aux7
  #  
  func_obj_l_L_mu_produto_biv <-  (j * a1 + (N - j) * a2)
  return(func_obj_l_L_mu_produto_biv)
}