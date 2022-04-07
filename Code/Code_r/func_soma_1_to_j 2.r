# Autor: AAB data 12/09/2018 versao 1.0
# A subrotina recebe o contador j e as informacoes da amostra z (vetor) (dist Wishart), e assim calcula a soma de 1 até j da amostra z.
func_soma_1_to_j <- function(j, z){
	func_soma_1_to_j = 0
	for (i in 1 : j){
		func_soma_1_to_j = func_soma_1_to_j + z[i]
	}
	func_soma_1_to_j <- func_soma_1_to_j / j
	return(func_soma_1_to_j)
}

