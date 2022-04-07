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
  Ni <- 1
  Nf <- j
  soma1 <- loglik_produto_biv(param = c(s1e, s2e, rhoe))
  Ni <- j + 1
  Nf <- N
  soma2 <- loglik_produto_biv(param = c(s1d, s2d, rhod))
  func_obj_l_L_mu_produto_biv <-  ( j * soma1 + (N - j) * soma2)
  return(func_obj_l_L_mu_produto_biv)
}