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
# canais hh, hv, and vv
mat <- scan('real_flevoland_1.txt')
setwd("..")
setwd("Code/Code_r")
mat <- matrix(mat, ncol = 120, byrow = TRUE)
d <- dim(mat)
nrows <- d[1]
ncols <- d[2]
N  = ncols
zaux <- matrix(0, 1, N)
zaux <-  mat[61, 1: N] 
indx <- which(zaux != 0)
N <- max(indx)
z <-  mat[61, 1: N] 
#z  <- rep(0, N)
#zaux  <- rep(0, N)
#zaux1  <- rep(0, N)
pm = 1
L  = 4
# Loop para toda a imagem
evidencias          <- rep(0, nrows)
evidencias_valores  <- rep(0, nrows)
xev  <- seq(1, nrows, 1 )
for (j in 1 : nrows){
	N <- ncols
	z     <- rep(0, N)
	zaux  <- rep(0, N)
        zaux1 <- rep(0, N)
	zaux  <-  mat[j,1:N]
	conta = 0
        for (i in 1 : N){
	       if (zaux[i] > 0){
		       conta <- conta + 1
		       zaux1[conta] = zaux[i]
	       }
        }
	indx  <- which(zaux1 != 0)
	N <- floor(max(indx))
	z     <-  zaux1[1:N]
	temp  <- sample(1: N, 1)
	lower <- 1 
	upper <- N
	out   <- GenSA(lower = lower, upper = upper, fn = func_obj_l, control=list( maxit =100, temperature = temp))
	evidencias[j] <- out$par
	evidencias_valores[j] <- out$value
}
# imprime em arquivo no diretorio  ~/Data/
dfev <- data.frame(xev, evidencias)
names(dfev) <- NULL
setwd("../..")
setwd("Data")
sink("evid_real_flevoland_3.txt")
print(dfev)
sink()
setwd("..")
setwd("Code/Code_r")
