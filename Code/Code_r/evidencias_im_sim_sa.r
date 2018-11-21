# Autor: AAB    versão 1.0 data: 14/11/2018
# O programa le uma imagem 400 X 400 (canais hh, hv e vv) encontra a funcao l(j) para cada linha da imagem, e calcula o ponto de max/min (evidencia de borda) pelo método GenSA.
# O programa imprime um vetor de tamanho 400 com as evidencias de bordas para cada linha da imagem em uma arquivo *.txt
# obs: 1) Trocar os canais nos arquivos de entrada e saida.
#      2) Progama preparado para rodar amostras em duas metades com sigmas propostos me \cite{nhfc} e \cite{gamf}.
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
#  referencia \cite{nhfc}
#  Phantom_nhfc_0.000_1_2_1.txt referente ao canal hh
#  Phantom_nhfc_0.000_1_2_2.txt referente ao canal hv
#  Phantom_nhfc_0.000_1_2_3.txt referente ao canal vv
#  referencia \cite{gamf}
#  Phantom_gamf_0.000_1_2_1.txt referente ao canal hh
#  Phantom_gamf_0.000_1_2_2.txt referente ao canal hv
#  Phantom_gamf_0.000_1_2_3.txt referente ao canal vv
#  referencia \cite{gamf} e \cite{nhfc}
#  Phantom_vert_0.000_1_2_1.txt referente ao canal hh
#  Phantom_vert_0.000_1_2_2.txt referente ao canal hv
#  Phantom_vert_0.000_1_2_3.txt referente ao canal vv
mat <- scan('Phantom_vert_0.000_1_2_3.txt')
setwd("..")
setwd("Code/Code_r")
mat <- matrix(mat, ncol = 400, byrow = TRUE)
N  = 400
tp <- N/2
z  <- matrix(0, 1, N)
pm = 1
L  = 4
# Loop para toda a imagem
evidencias    <- rep(0, N)
xev  <- seq(1, N, 1 )
for (j in 1 : N){
	z     <-  mat[j,1:N]
	temp  <- sample(1: N, 1)
	lower <- 1
	upper <- N
	out   <- GenSA(lower = lower, upper = upper, fn = func_obj_l, control=list( maxit =100, temperature = temp))
	evidencias[j] <- out$par
}
# imprime em arquivo no diretorio  ~/Data/
dfev <- data.frame(xev, evidencias)
setwd("../..")
setwd("Data")
sink("evidencias_vv_vert.txt")
print(dfev)
sink()
setwd("..")
setwd("Code/Code_r")
