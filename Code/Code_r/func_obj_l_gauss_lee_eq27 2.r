# Autor: AAB data: 06/06/2019 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
# Distribuicao de gauss
func_obj_l_gauss_lee_eq27 <- function(param){
  j <- param
  Le <- matdf1[j,1]
  Ld <- matdf2[j,1]
  rhoe <- matdf1[j,2]
  rhod <- matdf2[j,2]
  aux1 <- (Le + 1) * log(Le)
  aux2 <- Le * sum(log(z[1: j])) / j
  aux3 <- log(gamma(Le)) 
  aux4 <- log(1 - rhoe^2)
  aux5 <- sum(log(besselI((2 * rhoe * Le * z[1: j]) / ((1 - rhoe^2) * h[1: j]) , 0))) / j
  aux6 <- sum(log(besselK((2 * Le * z[1: j]) / ((1 - rhoe^2) * h[1: j]), Le - 1))) / j
  aux7 <- Le  * sum(log(h[1: j])) / j
  soma1 <- aux1 + aux2 - aux3 - aux4 + aux5 + aux6 - aux7
  aux1 <- (Ld + 1) * log(Ld) 
  aux2 <- Ld * sum(log(z[(j + 1): N])) / (N - j)
  aux3 <- log(gamma(Ld)) 
  aux4 <- log(1 - rhod^2)
  aux5 <- sum(log(besselI((2 * rhod * Ld * z[(j + 1): N]) / ((1 - rhod^2) * h[(j + 1): N]), 0))) / (N - j)
  aux6 <- sum(log(besselK((2 * Ld * z[(j + 1): N]) / ((1 - rhod^2) * h[(j + 1): N]), Ld - 1))) / (N - j)
  aux7 <  Ld  * sum(log(h[(j + 1): N])) / (N - j)
  soma2 <- aux1 + aux2 - aux3 - aux4 + aux5 + aux6 - aux7
  func_obj_l_gauss_lee_eq27 <- - (j * soma1 + (N - j) * soma2)
  return(func_obj_l_gauss_lee_eq27)
}
