# Autor: AAB    versão 1.0 data: 14/11/2018
# O programa le uma imagem 400 X 400 (canais hh, hv e vv) encontra a funcao l(j) para cada linha da imagem, e calcula o ponto de max/min (evidencia de borda) pelo método GenSA.
# O programa imprime um vetor de tamanho 400 com as evidencias de bordas para cada linha da imagem em uma arquivo *.txt
# obs: 1) Trocar os canais nos arquivos de entrada e saida.
#      2) Progama preparado para rodar amostras em duas metades com sigmas propostos me \cite{nhfc} e \cite{gamf}.
#      3) Desabilitei o print em arquivo depois de rodar os testes de interesse com o intuito de não modificar arquivos indevidamente.
rm(list = ls())
require(ggplot2)
require(latex2exp)
#
source("loglik_razao.r")
# Programa principal
N  <- 120
#
L <- 4
k <- 10
j <- 20 
print(k)
z  <- rep(1, N)
r1 <- 0.5
r2 <- 0.5
Ni <- 1
Nf <- j
value <- loglik_razao(c(r1, r2))
print(value)
res1 <- maxBFGS(loglik_razao, start=c(r1, r2))
    