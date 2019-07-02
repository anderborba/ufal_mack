# Autor: AAB data: 06/06/2019 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
# Distribuicao de gauss
func_obj_l_gauss <- function(param){
	j <- param
	aux1 = -0.5 * N * log(1/((2 * pi)^(0.5) * sig^2 ))
	aux2 = -1 / (2 * sig^2) * func_soma_1_to_j(N, z)
	func_obj_l_gauss <- aux1 + aux2
	return(func_obj_l_gauss)
}

