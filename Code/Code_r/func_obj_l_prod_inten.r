# Autor: AAB data: 06/06/2019 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
# Distribuicao de gauss
func_obj_l_prod_inten <- function(param){
  z   <- matrix(0, 1, 400)	
  soma1 <- 0.0
	look <- 0.0
  for (i in 1: j){ 
    caux1 <- func_soma_1_to_j(j, z1)
    caux2 <- func_soma_1_to_j(j, z2)
 	  aux1 <- L^(L+1) * (z1[i] * z2[i])^(0.5 * (L - 1)) 
	  aux2 <- (caux1 * caux2)^(0.5 * (L + 1)) * gamma(L) * (1 - r1s) * rho1^(L - 1)
 		aux3 <- exp(-L * (z1[i] / caux1 + z2[i] / caux2 ) / (1 - r1s))
		daux <- 2 * L * sqrt((z1[i] * z2[i]) / (caux1 * caux1)) * rho1 / (1 - r1s)
		aux4 <- besselI(daux, L - 1)
		look <- (aux1 / aux2) * aux3 * aux4 
	  soma1 <- soma1 + log(look)
	  }
	soma2 <- 0.0
	look <- 0.0
  for (i in (j + 1) : N){
    caux1 <- func_soma_j_to_n(j, N, z1)
    caux2 <- func_soma_j_to_n(j, N, z2)
    aux1 <- L^(L+1) * (z1[i] * z2[i])^(0.5 * (L - 1)) 
    aux2 <- (caux1 * caux2)^(0.5 * (L + 1)) * gamma(L) * (1 - r2s) * rho2^(L - 1)
    aux3 <- exp(-L * (z1[i] / (caux1) + z2[i] / (caux2) ) / (1 - r2s))
    daux <- 2 * L * sqrt((z1[i] * z2[i]) / (caux1 * caux1)) * rho2 / (1 - r2s)
    aux4 <- besselI(daux, L - 1)
    look <- (aux1 / aux2) * aux3 * aux4 
    soma1 <- soma1 + log(look)
		}
	func_obj_l_prod_inten <-  soma1 + soma2
	return(func_obj_l_prod_inten)
}

