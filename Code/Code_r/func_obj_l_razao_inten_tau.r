# Autor: AAB data: 06/06/2019 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
# Distribuicao de gauss
func_obj_l_razao_inten_tau <- function(param){
  j <- param
  Le <- 4
  Ld <- 4
  taue <- matdf1[j, 1]
  taud <- matdf2[j, 1]
  rhoe <- matdf1[j, 2]
  rhod <- matdf2[j, 2]
  aux1 <- Le * log(taue)
  aux2 <- log(gamma(2 * Le))
  aux3 <- Le * log(1 - abs(rhoe)^2)
  aux4 <- 2 * log(gamma(Le))
  aux5 <- sum(log(taue + z[1 : j])) / j
  aux6 <- Le * sum(log(z[1 : j])) / j
  aux7 <- (0.5 * (2 * Le +1)) * sum(log((taue + z[1: j])^2 - 4 * taue * abs(rhoe)^2 * z[1: j])) / j
  soma1 <- aux1 + aux2 + aux3 - aux4 + aux5 + aux6 -aux7 
  aux8  <- Ld * log(taud)
  aux9  <- log(gamma(2 * Ld))
  aux10 <- Ld * log(1 - abs(rhod)^2)
  aux11 <- 2 * log(gamma(Ld))
  aux12 <- sum(log(taud + z[(j + 1) : N])) / (N - j)
  aux13 <- Ld * sum(log(z[(j + 1) : N])) / (N - j)
  aux14 <- (0.5 * (2 * Ld +1)) * sum(log((taud + z[(j + 1): N])^2 - 4 * taud * abs(rhod)^2 * z[(j + 1): N])) / (N - j)
  soma2 <-aux8 + aux9 + aux10 - aux11 + aux12 + aux13 -aux14
  func_obj_l_razao_inten <- -(soma1 * j + soma2 * (N - j))
  return(func_obj_l_razao_inten)
}
