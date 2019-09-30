# Autor: AAB data: 06/06/2019 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
# Distribuicao de gauss
func_obj_l_gauss <- function(param){
	soma1 <- 0.0
        for (i in 1: j){
		look <-  (4 * L^(L + 1) * z[i]^L) / (gamma(L) * (1 - r1s)) * besselI((2 * rho1 * L * z[i]) / (1 - r1s), 0) * besselK((2 * L * z[i]) / (1 - r1s) , L - 1) 

		soma1 <- soma1 + log(look)
	}
	soma2 <- 0.0
        for (i in (j + 1) : N){
		look <-  (4 * L^(L + 1) * z[i]^L) / (gamma(L) * (1 - r2s)) * besselI((2 * rho2 * L * z[i]) / (1 - r2s), 0) * besselK((2 * L * z[i]) / (1 - r2s) , L - 1) 

		soma2 <- soma2 + log(look)
	}
	#aux1      = N * log(4) + N * (L + 1) * log(L) - N * log(gamma(L)) - N * log(1 - rho^2)
	#cons1 = (2 * abs(rho) * L) / (1 - rho^2) 
	#cons2 = (2 * L) / (1 - rho^2) 
        #soma1 = L * N * log(z[j])
	#soma2 = N * log(besselI(cons1 * z[j], 0))
        #soma3 = N * log(besselK(cons2 * z[j], (L - 1)))
	#func_obj_l_gauss <- aux1 + soma1 + soma2 + soma3
	func_obj_l_gauss <- soma1 + soma2 
	return(func_obj_l_gauss)
}

