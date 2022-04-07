# AAB - versao 1.0 17/11/2018
# O programa le as evidencia de bordas para cada canal no diretorio ~/Data e calcula a probabilidade de detecçao de borda para cada canal, alem de calcular a probabilidades de detecçao para o método dos quadrados minimos. Imprime para arquivos *.pdf em /Text/Dissertacao/figuras
# Obs (1) Trocar os nomes das amostras de interesse na leitura de dados,
#     (2) trocar os nomes do arquivo de impressão,
#     (3) amostras definidas em \cite{nhfc} e \cite{gamf},
#     (4) impressão comentada.
rm(list = ls())
require(ggplot2)
require(latex2exp)
#
setwd("../..")
setwd("Data")
#mat_hh <- read.table('evidencias_hh_nhfc.txt')
#mat_hv <- read.table('evidencias_hv_nhfc.txt')
#mat_vv <- read.table('evidencias_vv_nhfc.txt')
#mat_ls <- read.table('evidencias_ls_nhfc.txt')
#mat_hh <- read.table('evidencias_hh_gamf.txt')
#mat_hv <- read.table('evidencias_hv_gamf.txt')
#mat_vv <- read.table('evidencias_vv_gamf.txt')
#mat_ls <- read.table('evidencias_ls_gamf.txt')
mat_hh <- read.table('evidencias_hh_vert.txt')
mat_hv <- read.table('evidencias_hv_vert.txt')
mat_vv <- read.table('evidencias_vv_vert.txt')
mat_ls <- read.table('evidencias_ls_vert.txt')
setwd("..")
setwd("Code/Code_r")
N  = 400
tp <- N / 2
x  = seq(1, N, 1 )
nk <- 10
error_hh  <- rep(0, N)
freq_hh   <- rep(0, nk + 1)
error_hv  <- rep(0, N)
freq_hv   <- rep(0, nk + 1)
error_vv  <- rep(0, N)
freq_vv   <- rep(0, nk + 1)
error_ls  <- rep(0, N)
freq_ls   <- rep(0, nk + 1)
xx    <- seq(0, nk, 1) 
evidencias_hh <- mat_hh[1: N, 3]
evidencias_hv <- mat_hv[1: N, 3]
evidencias_vv <- mat_vv[1: N, 3]
evidencias_ls <- mat_ls[1: N, 1]
for (k in 1 : nk){
	contador_hh <- 0
	contador_hv <- 0
	contador_vv <- 0
	contador_ls <- 0
	for (r in 1 : N){
		error_hh [r] = abs(evidencias_hh[r] - tp)
		error_hv [r] = abs(evidencias_hv[r] - tp)
		error_vv [r] = abs(evidencias_vv[r] - tp)
		error_ls [r] = abs(evidencias_ls[r] - tp)
		if(error_hh [r] < k){
			contador_hh  <- contador_hh  + 1
		}  	
		if(error_hv [r] < k){
			contador_hv  <- contador_hv  + 1
		}  	
		if(error_vv [r] < k){
			contador_vv  <- contador_vv  + 1
		}  	
		if(error_ls [r] < k){
			contador_ls  <- contador_ls  + 1
		}  	
	}
        freq_hh[k + 1] <- contador_hh / N
        freq_hv[k + 1] <- contador_hv / N
        freq_vv[k + 1] <- contador_vv / N
        freq_ls[k + 1] <- contador_ls / N
}
df <- data.frame(x = xx, y1 = freq_hh, y2 = freq_hv, y3 = freq_vv, y4 = freq_ls)
alpha <- c(1,2,3,4)
p <- ggplot(df) 
pp <- p + geom_line(aes(x = x, y = y1, color = "Ihh"))+  geom_line(aes(x = x, y = y2, color = "Ihv"))+  geom_line(aes(x = x, y = y3, color = "Ivv"))+ geom_line(aes(x = x, y = y4, color = "Ifus"))+ scale_y_log10(limits = c(0.002, 1))+ ggtitle(TeX('Probabilidade de detecção das evidências de bordas')) + ylab(TeX('Probabilidade de detecção estimada')) + xlab(TeX('Erros de detecção')) 
print(pp)
setwd("../..")
setwd("Text/Dissertacao/figuras")
#ggsave("metricas_ihh_ivh_ivv_ils_vert.pdf")
setwd("../../..")
setwd("Code/Code_r")




