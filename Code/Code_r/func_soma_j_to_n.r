# Autor: AAB data 12/09/2018 versao 1.0
# A subrotina recebe o contador j, a dimensao da amostra n, e as informacoes da amostra z (vetor) (dist Wishart), e assim calcula a soma de (j + 1) ate n da amostra z.
func_soma_j_to_n <- function(j, n, z){
	func_soma_j_to_n = 0
	for (i in (j + 1) : n){
		func_soma_j_to_n = func_soma_j_to_n + z[i]
	}
	func_soma_j_to_n <- func_soma_j_to_n / (n - j)
	return(func_soma_j_to_n)
}

