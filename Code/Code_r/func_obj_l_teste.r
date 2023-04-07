# Autor: AAB data: 12/09/2018 versao 1.0
# A funcao recebe  parametros ao qual atribui param como variavel da funcao,
# L como numero de visadas,  m (< L) como o número de canais da imagens, 
# N como o tamanho da imagem e z como valores da imagem (dist Wishart),
# assim a subrotina define a funcão objetivo l(j) descrita na eq(5) do artigo NHFC_2014
func_obj_l_teste <- function(param){
	print(j)
	Le <- L
	Ld <- L
	mue <- sum(z[1: j]) / j 
	mud <- sum(z[(j + 1): N]) / (N - j) 
	soma1 <- 0
	for(i in 1: j){
		aux1 <- Le * log(Le) 
		aux2 <-	(Le - 1) * log(z[i]) 
		aux3 <- Le * log(mue) 
		aux4 <- log(gamma(Le))
	        aux5 <- (Le / mue) * z[i]  
		soma1 <- soma1 + aux1 + aux2 - aux3 - aux4  - aux5
	}
	soma2 = 0
	for(i in (j + 1): N){
		aux6 <- Ld * log(Ld) 
		aux7 <-	(Ld - 1) * log(z[i]) 
		aux8 <- Ld * log(mud) 
		aux9 <- log(gamma(Ld))
	        aux10 <- (Ld / mud) * z[i]  
		soma2 <- soma2 + aux6 + aux7 - aux8 - aux9  - aux10
		#aux6 <- (L^L * z[i]^(L - 1)) / (mud^L * gamma(L)) 
	        #aux7 <- -(L * z[i])  / mud
		#soma2 <- soma2 + log(aux6) - aux7

	}
	# O sinal negativo é devido ao GenSA minimizar a função
	func_obj_l_teste <- -(soma1 + soma2)
#	j <- param
#	a1 <- L * log(L) 
#	a2 <- (L - 1) * sum(log(z[1: j])) / j
#	a4 <- log(gamma(L))
#	aux1 <- (L / mu) * sum(z[1:j])/j 
#########################################################################
#	a6 <- L * log(L) 
#	a7 <- (L - 1) * sum(log(z[(j + 1): N])) / (N - j)
#	a9 <- log(gamma(L))
#	aux2 <- (L / mu) * sum(z[(j + 1):N])/(N - j)
#	func_obj_l_teste <- j * (aux1 + a1 + a2 - a4) + (N - j) *  (aux2 + a6 + a7 - a9)
	return(func_obj_l_teste)
}

