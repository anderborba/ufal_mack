# Autor: AAB data: 06/06/2019 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
# Distribuicao de gauss
func_obj_l_gauss <- function(param){
	j <- param
	csi1j  =  func_soma_1_to_j(j,    z1) / j
	csi1nj =  func_soma_j_to_n(j, N, z1) / (N -j)
	csi2j  =  func_soma_1_to_j(j,    z2) / j
	csi2nj =  func_soma_j_to_n(j, N, z2) / (N -j)
	csij   =  1.0 / (sqrt(csi1j^2  + csi2j^2))
	csinj  =  1.0 / (sqrt(csi1nj^2 + csi2nj^2))
	#print(j)
	aux1      = N * log(4) + N * (L + 1) * log(L) - N * log(L) - N * log(1 - rho^2) - N * log(csij) - N * log(csinj)
	cons1 = (2 * abs(rho) * L) / (1 - rho^2) 
	cons2 = (2 * L) / (1 - rho^2) 
        soma1 = func_soma_1_to_j(j, log(z/csij ))
	soma2 = func_soma_1_to_j(j, log(besselI(cons1 * z/csij, 0)))
        soma3 = func_soma_1_to_j(j, log(besselK(cons2 * z/csij, (L - 1))))
	soma4 = func_soma_j_to_n(j, N, log(z / csinj))
	soma5 = func_soma_j_to_n(j, N, log(besselI( cons1 * z / csinj, 0)))
	soma6 = func_soma_j_to_n(j, N, log(besselK( cons2 * z / csinj, L - 1)))
	func_obj_l_gauss <- aux1 + soma1 + soma2 + soma3 + soma4 + soma5 + soma6

	return(func_obj_l_gauss)
}

