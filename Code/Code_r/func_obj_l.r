# Autor: AAB data: 12/09/2018 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
func_obj_l <- function(param){
	#print(j)
	j <- param
	#aux1 = j * log(abs(func_soma_1_to_j(j, z))) + (N - j) * log(abs(func_soma_j_to_n(j, N, z)))
	aux1 = j * log(abs(sum(z[1:j])/j)) + (N - j) * log(abs(sum(z[(j + 1):N])/(N - j)))
	aux2 =  pm * L * (log(L) - 1) - log(fpmgamma(L, pm)) 
	aux3 = (L - pm) * sum(log(abs(z)))
	func_obj_l <- (L * aux1 + N * aux2 + aux3)
	return(func_obj_l)
}

