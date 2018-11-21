#  Autor: AAB data: 12/09/2018 versao 1.0
# A funcao recebe as atributos L como numero de visadas e m como o numero de canais da imagem (m < L), e a funcao devolve uma funcao gamma multivariada.
fpmgamma <- function(L, m){
	fpmgamma = 1
	for (i in 0 : (L - 1)){
		fpmgamma = fpmgamma * gamma(L - i)
	}
	fpmgamma = pi^(0.5 * m * (m - 1)) * fpmgamma
	return(fpmgamma)
}
