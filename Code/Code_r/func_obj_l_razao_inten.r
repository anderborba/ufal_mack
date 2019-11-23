# Autor: AAB data: 06/06/2019 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
# Distribuicao de gauss
func_obj_l_razao_inten <- function(param){
  z   <- matrix(0, 1, 400)	
  soma1 <- 0.0
	look <- 0.0
  for (i in 1: j){ 
    caux <- func_soma_1_to_j(j, z1) / func_soma_1_to_j(j, z2)
    z[i] <- (z1[i]) / (caux * (z2[i]))
 	  aux1 <- gamma(2 * L)
	  aux2 <- (1 - r1s)^L
		aux3 <- (1 + z[i]) * z[i]^(L - 1)
		paux1 <- aux1 * aux2 * aux3
		aux4 <- gamma(L) * gamma(L)
		aux5 <- ((1 + z[i])^2 - 4 * r1s * z[i])^(0.5 * (2 * L +1))
		paux2 <- aux4 * aux5
		look <- paux1 / paux2
	  soma1 <- soma1 + log(look)
	  }
	soma2 <- 0.0
	look <- 0.0
  for (i in (j + 1) : N){
    caux <- func_soma_j_to_n(j, N, z1) / func_soma_j_to_n(j, N ,z2)
    z[i] <- (z1[i]) / (caux * (z2[i]))
    aux1 <- gamma(2 * L)
    aux2 <- (1 - r2s)^L
    aux3 <- (1 + z[i]) * z[i]^(L - 1)
    paux1 <- aux1 * aux2 * aux3
    aux4 <- gamma(L) * gamma(L)
    aux5 <- ((1 + z[i])^2 - 4 * r2s * z[i])^(0.5 * (2 * L +1))
    paux2 <- aux4 * aux5
    look <- paux1 / paux2
		soma2 <- soma2 + log(look)
		}
	func_obj_l_razao_inten <-  soma1 + soma2
	return(func_obj_l_razao_inten)
}

