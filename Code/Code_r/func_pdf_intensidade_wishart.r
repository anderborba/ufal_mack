# Le duas amostras de um dos arquivos em /Data/Phantom_****_0.000_1_2_*.txt
#
# Obs: (1) Trocar os nomes dos arquivos de entrada,
#      (2) trocar os nomes dos arquivos de saida,
#      (3) os arquivos de saida ficarao comentados para não alterar as figuras
#rm(list = ls())
#require(ggplot2)
#require(latex2exp)
#require(plyr)
rm(list = ls())
require(ggplot2)
require(latex2exp)
library(hrbrthemes)
require(extrafont)
loadfonts()
# Programa principal
## Leitura do arquivo *.txt no diretorio /Data 
setwd("../..")
setwd("Data")
mat <- scan('roi_mar_azul_11.txt')
setwd("..")
setwd("Code/Code_r")
## retornou ao diretorio de trabalho /Code/Code_r
dimdf = length(mat)
x <- seq(1, dimdf)
#############################################################
#sig <- sum(mat) / (dimdf)
sig <- 0.01
m = 1
L2 <- 2
L3 <- 3
L4 <- 4
L8 <- 8
sigma <- sig
##### realizar o plot usando o ggplot #######################
look_1 <- ((L2^L2 * mat^(L2-m))/(sigma^L2 * gamma(L2))) * exp(((-L2 * mat) / sigma))
look_2 <- ((L3^L3 * mat^(L3-m))/(sigma^L3 * gamma(L3))) * exp(((-L3 * mat) / sigma))
look_3 <- ((L4^L4 * mat^(L4-m))/(sigma^L4 * gamma(L4))) * exp(((-L4 * mat) / sigma))
look_4 <- ((L8^L8 * mat^(L8-m))/(sigma^L8 * gamma(L8))) * exp(((-L8 * mat) / sigma))
##### realizar o plot usando o ggplot #######################
df <- data.frame(x, mat, look_1, look_2, look_3, look_4, fix.empty.names = TRUE)
#data_look <- data.frame(x, look_1, look_2, look_3,fix.empty.names = TRUE)
pp <- ggplot(df, aes(x = mat, color = Visadas) )                 +
       # geom_histogram(position = 'stack', stat = 'bin', binwidth = 0.0005, alpha = 0.7, color = "lightblue", fill = "darkblue")                 +
     	geom_line(aes(y = look_1, col= "2-Visadas"), size = 1)    +
     	geom_line(aes(y = look_2, col= "3-Visadas"), size = 1)    +
     	geom_line(aes(y = look_3, col= "4-Visadas"), size = 1)    +
     	geom_line(aes(y = look_4, col= "8-Visadas"), size = 1)    +
       	xlab(TeX('Intensidade'))                +
      	ylab(TeX('Funções densidade de probabilidade'))     +
       	ggtitle(TeX('Distribuições densidade de probabilidade para o canal de intensidade'))+
       	coord_cartesian(ylim=c(0, 130))
# escrita no diretorio /Text/Dissertacao/figura
setwd("../..")
setwd("Text/Dissertacao/figuras")
ggsave("dist_intensidade_multi_visadas.pdf")
setwd("../../..")
setwd("Code/Code_r")
# retornou ao diretorio /Code/Code_r
print(pp)
