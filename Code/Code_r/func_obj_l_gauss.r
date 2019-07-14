# Autor: AAB data: 06/06/2019 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
# Distribuicao de gauss
func_obj_l_gauss <- function(param){
	j <- param
	#print(j)
	aux1      = N * log(4) + N * (L + 1) * log(L) - N * log(gamma(L)) - N * log(1 - rho^2)
	cons1 = (2 * abs(rho) * L) / (1 - rho^2) 
	cons2 = (2 * L) / (1 - rho^2) 
	#h1 <- func_soma_1_to_j(j, vh)
	#h2 <- func_soma_j_to_n(j, N, vh )
	h1 <- vh[j]
	h2 <- vh[j]
        soma1 = L * sum(log(z[1: j]))
        soma2 = (L + 1) * sum(log(vh[1:j])) 
	soma3 = sum(log(besselI(cons1 * z[1:j] / h1, 0)))
        soma4 = sum(log(besselK(cons2 * z[1:j]/ h1, (L - 1))))
        soma5 = L * sum(log(z[(j+1): N]))
        soma6 = (L + 1) *  sum(log(vh[(j+1): N])) 
	soma7 = sum(log(besselI( cons1 * z[(j+1):N] / h2 , 0)))
	soma8 = sum(log(besselK( cons2 * z[(j+1):N] / h2, L - 1)))
	func_obj_l_gauss <- aux1+soma1-soma2+soma3+soma4+soma5-soma6+soma7+soma8
	#func_obj_l_gauss <- aux1+soma1+soma2 

	return(func_obj_l_gauss)
}

