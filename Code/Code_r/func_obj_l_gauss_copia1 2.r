# Autor: AAB data: 06/06/2019 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
# Distribuicao de gauss
func_obj_l_gauss_copia1 <- function(param){
	soma1 <- 0.0
	look <- 0.0
  for (i in 1: j){
    #caux <- sqrt(func_soma_1_to_j(j, z1)  * func_soma_1_to_j(j, z2))
    caux <- sqrt(sum(z1[1: j])  * sum(z2[1: j]) / j^2)
    z[i] <- z[i] / caux 
	  aux1 <- 4 * L^(L + 1) * z[i]^L
	  aux2 <- gamma(L) * (1 - rho1^2)
	  daux1 <- aux1 / aux2
	  aux3 <- 2 * rho1 * L * z[i]
	  aux4 <- 1 - rho1^2
		daux2 <- aux3 / aux4
		aux5 <- 2 * L * z[i]
		aux6 <- 1 - rho1^2
		daux3 <- aux5 / aux6
		#look <-  daux1 * besselI(daux2, 0) * besselK(daux3, L - 1)
	  #soma1 <- soma1 + log(look)
    soma1 <- soma1 + log(daux1 * besselI(daux2, 0)* besselK(daux3, L - 1))
	  #soma1 <- soma1 + log(daux1 * besselI(daux2, 0))
	  #soma1 <- soma1 + log(daux1)
	  }
	soma2 <- 0.0
	look <- 0.0
  for (i in (j + 1) : N){
    #caux <- sqrt(func_soma_j_to_n(j, N, z1)  * func_soma_j_to_n(j, N, z2))
    caux <- sqrt(sum(z1[(j + 1): N])  * sum(z2[(j + 1): N])/ (N - j)^2)
    z[i] <- z[i] / caux
    aux1 <- 4 * L^(L + 1) * z[i]^L
    aux2 <- gamma(L) * (1 - rho2^2)
    daux1 <- aux1 / aux2
    aux3 <- 2 * rho2 * L * z[i]
    aux4 <- 1 - rho2^2
    daux2 <- aux3 / aux4
    aux5 <- 2 * L * z[i]
    aux6 <- 1 - rho2^2
    daux3 <- aux5 / aux6
		#look <-  daux1 * besselI(daux2, 0) * besselK(daux3, L - 1)
		#soma2 <- soma2 + log(look)
    soma2 <- soma2 + log(daux1 * besselI(daux2, 0) * besselK(daux3, L - 1))
		#soma2 <- soma2 + log(daux1 * besselI(daux2, 0))
		#soma2 <- soma2 + log(daux1)
		}
	func_obj_l_gauss_copia1 <- soma1 + soma2 
	return(func_obj_l_gauss_copia1)
}

