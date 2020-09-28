# AAB - versao 1.0 17/11/2018
# O programa le as evidencia de bordas para cada canal no diretorio ~/Data e calcula a probabilidade de detecçao de borda e imprime para arquivo em /Text/Dissertacao/figuras
# Obs (1) Trocar os nomes das amostras de interesse na leitura de dados,
#     (2) trocar os nomes do arquivo de impressão, 
#     (3) amostras definidas em \cite{nhfc} e \cite{gamf},
#     (4) impressão comentada.
rm(list = ls())
require(ggplot2)
require(latex2exp)
library(hrbrthemes)
require(extrafont)
loadfonts()
#
setwd("../..")
setwd("Data")
mat_1 <- read.table('evid_sim_gamf_1_param_mu_14_pixel.txt', dec = ",")
mat_2 <- read.table('evid_sim_gamf_2_param_mu_14_pixel.txt', dec = ",")
mat_3 <- read.table('evid_sim_gamf_3_param_mu_14_pixel.txt', dec = ",")
mat_4 <- read.table('evid_sim_gamf_hh_hv_razao_param_tau_rho_14_pixel.txt', dec = ",")
mat_5 <- read.table('evid_sim_gamf_hh_vv_razao_param_tau_rho_14_pixel.txt', dec = ",")
mat_6 <- read.table('evid_sim_gamf_hv_vv_razao_param_tau_rho_14_pixel.txt', dec = ",")
mat_7 <- read.table('evid_sim_gamf_span_media_mu_14_pixel.txt', dec = ",")
setwd("..")
setwd("Code/Code_art_rem_sen_2020")
N  = 400
tp <- N / 2
nk <- 10
error_1  <- rep(0, N)
error_2  <- rep(0, N)
error_3  <- rep(0, N)
error_4  <- rep(0, N)
error_5  <- rep(0, N)
error_6  <- rep(0, N)
error_7  <- rep(0, N)
evidencias_1 <- rep(0, N)
evidencias_2 <- rep(0, N)
evidencias_3 <- rep(0, N)
evidencias_4 <- rep(0, N)
evidencias_5 <- rep(0, N)
evidencias_6 <- rep(0, N)
evidencias_7 <- rep(0, N)
x        <- seq(0, nk , 1)
freq_1   <- rep(0, nk + 1)
freq_2   <- rep(0, nk + 1)
freq_3   <- rep(0, nk + 1)
freq_4   <- rep(0, nk + 1)
freq_5   <- rep(0, nk + 1)
freq_6   <- rep(0, nk + 1)
freq_7   <- rep(0, nk + 1)
evidencias_1 <- mat_1[1: N, 3]
evidencias_2 <- mat_2[1: N, 3]
evidencias_3 <- mat_3[1: N, 3]
evidencias_4 <- mat_4[1: N, 3]
evidencias_5 <- mat_5[1: N, 3]
evidencias_6 <- mat_6[1: N, 3]
evidencias_7 <- mat_7[1: N, 3]
for (k in 1 : nk){
	contador_1 <- 0
	contador_2 <- 0
	contador_3 <- 0
	contador_4 <- 0
	contador_5 <- 0
	contador_6 <- 0
	contador_7 <- 0
	for (r in 1 : N){
		error_1 [r] = abs(evidencias_1[r] - tp)
		error_2 [r] = abs(evidencias_2[r] - tp)
		error_3 [r] = abs(evidencias_3[r] - tp)
		error_4 [r] = abs(evidencias_4[r] - tp)
		error_5 [r] = abs(evidencias_5[r] - tp)
		error_6 [r] = abs(evidencias_6[r] - tp)
		error_7 [r] = abs(evidencias_7[r] - tp)
		if(error_1[r] < k){
			contador_1  <- contador_1  + 1
		}  	
		if(error_2 [r] < k){
			contador_2  <- contador_2  + 1
		}  	
		if(error_3 [r] < k){
			contador_3  <- contador_3  + 1
		}
		if(error_4 [r] < k){
		  contador_4  <- contador_4  + 1
		}
		if(error_5 [r] < k){
		  contador_5  <- contador_5  + 1
		}
		if(error_6 [r] < k){
		  contador_6  <- contador_6  + 1
		}
		if(error_7 [r] < k){
		  contador_7  <- contador_7  + 1
		}
	}
        freq_1[k + 1] <- contador_1 / N
        freq_2[k + 1] <- contador_2 / N
        freq_3[k + 1] <- contador_3 / N
        freq_4[k + 1] <- contador_4 / N
        freq_5[k + 1] <- contador_5 / N
        freq_6[k + 1] <- contador_6 / N
        freq_7[k + 1] <- contador_7 / N
}
df <- data.frame(x = x, y1 = freq_1, y2 = freq_2, y3 = freq_3, y4 = freq_4, y5 = freq_5, y6 = freq_6, y7 = freq_7)
alpha <- c(1,2,3,4,5,6,7)
p <- ggplot(df) 
pp <- p + 
  geom_line(aes(x = x, y = y1, color = "Canal hh")   , size=2, alpha=.7) +
  geom_line(aes(x = x, y = y2, color = "Canal hv")   , size=2, alpha=.7) +
  geom_line(aes(x = x, y = y3, color = "Canal vv")   , size=2, alpha=.7) +
  geom_line(aes(x = x, y = y4, color = "Canal hh/hv"), size=2, alpha=.7) +
  geom_line(aes(x = x, y = y5, color = "Canal hh/vv"), size=2, alpha=.7) +
  geom_line(aes(x = x, y = y6, color = "Canal hv/vv"), size=2, alpha=.7) +
  geom_line(aes(x = x, y = y7, color = "Canal Span") , size=2, alpha=.7) +
  ylim(.01,1) +
  ylab(TeX('Probabilidade')) +
  xlab(TeX('Error de detecção')) +
  theme_ipsum(base_family = "Times New Roman", 
              base_size = 20, axis_title_size = 20) +
  scale_fill_ipsum() +
  theme(legend.title = element_blank()) +
  theme(plot.margin=grid::unit(c(0,0,0,0), "mm"),
  )
print(pp) 