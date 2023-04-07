# Autor: AAB data: 06/06/2019 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
# Distribuicao de gauss
func_obj_l_gauss_lee_eq26<- function(j){
  Le <- matdf1[j,1]
  Ld <- matdf2[j,1]
  rhoe <- matdf1[j,2]
  rhod <- matdf2[j,2]
  #Le <- 4
  #Ld <- 4
  #rhoe <- 0.3
  #rhod <- 0.9
  Ni <- 1
  Nf <- j
  soma1 <- loglik_prod_mag_lee_eq26(param = c(Le, rhoe))
  Ni <- j + 1
  Nf <- N
  soma2 <- loglik_prod_mag_lee_eq26(param = c(Ld, rhod))
  func_obj_l_gauss_lee_eq26 <- ( j * soma1 + (N - j) * soma2)
  return(func_obj_l_gauss_lee_eq26)
}
