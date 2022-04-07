# Autor: AAB    versão 1.0 data: 21/11/2018
# O programa le uma imagem "flor" 800 X 800 (canais hh, hv e vv) encontra a funcao l(j) para cada linha radial da imagem, e calcula o ponto de max/min (evidencia de borda) pelo método GenSA.
# O programa imprime um vetor com o a dimensão igual ao numero de linhas radiais  com as evidencias de bordas para cada linha radial da imagem em uma arquivo *.txt
# obs: 1) Trocar os canais e as imagens nos arquivos de entrada e saida.
#      2) Progama preparado para rodar com duas amostras conforme imagem flor e com sigmas propostos me \cite{nhfc} e \cite{gamf}.
#      3) Desabilitei o print em arquivo depois de rodar os testes de interesse com o intuito de não modificar arquivos indevidamente.
rm(list = ls())
require(ggplot2)
require(latex2exp)
require(GenSA)
#
source("func_soma_1_to_j.r")
source("func_soma_j_to_n.r")
source("fpmgamma.r")
source("func_obj_l.r")
# Programa principal
setwd("../..")
setwd("Data")
mat<- scan('radial_flor_8_103_3_3.txt')
setwd("..")
setwd("Code/Code_r")
N_mat  = 400
N_radial = 400
mat <- matrix(mat, ncol = N_mat , byrow = TRUE)
zaux  <- matrix(0, 1, N_mat)
Naux  <- matrix(0, 1, N_radial)
#  Define as dimensoes de cada radial em N[:]
for (j in 1: N_radial){
	zaux    <-  mat[j,1: N_mat]
	ind     <- which(zaux > 0, arr.ind = TRUE)
	Naux[j] <- length(ind)
}
# Constantes para a função func_obj_l
L  = 4
pm = 1
# Loop para toda as radiais
evidencias    <- rep(0, N_radial)
for (i in 1 : N_radial){
        N <- Naux[i]
	z     <-  mat[i,1: N]
	temp  <- sample(1: N, 1)
	lower <- 1
	upper <- N
	out   <- GenSA(lower = lower, upper = upper, fn = func_obj_l, control=list( maxit =100, temperature = temp))
	evidencias[i] <- out$par
}
# imprime em arquivo no diretorio  ~/Data/
xev <- seq(1, N_radial,1)
dfev <- data.frame(xev, evidencias)
setwd("../..")
setwd("Data")
sink("evidencias_flor_8_103_3_3.txt")
print(dfev)
sink()
setwd("..")
setwd("Code/Code_r")
