# Le duas amostras de um dos arquivos em /Data/Phantom_****_0.000_1_2_*.txt
#   Phantom_nhfc_0.000_1_2_1.txt   canal I_hh  \cite{nhfc}
#   Phantom_nhfc_0.000_1_2_2.txt   canal I_hv  \cite{nhfc}
#   Phantom_nhfc_0.000_1_2_3.txt   canal I_vv  \cite{nhfc}
#   Phantom_gamf_0.000_1_2_1.txt   canal I_hh  \cite{gamf}
#   Phantom_gamf_0.000_1_2_2.txt   canal I_hv  \cite{gamf}
#   Phantom_gamf_0.000_1_2_3.txt   canal I_vv  \cite{gamf}
#   Phantom_vert_0.000_1_2_1.txt   canal I_hh  \cite{nhfc} \cite{gamf}
#   Phantom_vert_0.000_1_2_2.txt   canal I_hv  \cite{nhfc} \cite{gamf}
#   Phantom_vert_0.000_1_2_3.txt   canal I_vv  \cite{nhfc} \cite{gamf}
#   constroi a l(j)
#   imprime o gráfico em /Text/Dissertacao/figuras
#   grafico_l_****_201*_sigmahh.pdf
#   grafico_l_****_201*_sigmahv.pdf
#   grafico_l_****_201*_sigmavv.pdf
#
# Obs: (1) Trocar os nomes dos arquivos de entrada,
#      (2) trocar os nomes dos arquivos de saida,
#      (3) os arquivos de saida ficarao comentados para não alterar as figuras
rm(list = ls())
require(ggplot2)
require(latex2exp)
# funcoes auxiliares para encontrar l(j) de acordo com \cite{nhfc}
source("func_soma_1_to_j.r")
source("func_soma_j_to_n.r")
source("func_obj_l_gauss.r")
# Programa principal
## Leitura do arquivo *.txt no diretorio /Data 
setwd("../..")
setwd("Data")
mat <- scan('real_flevoland_produto_1.txt')
mat1 <- scan('real_flevoland_1.txt')
mat2 <- scan('real_flevoland_2.txt')
setwd("..")
setwd("Code/Code_r")
## retornou ao diretorio de trabalho /Code/Code_r
num_radial <- 200
r          <- 120
nc         <- 3
mat <- matrix(mat, ncol = r, byrow = TRUE)
mat1 <- matrix(mat1, ncol = r, byrow = TRUE)
mat2 <- matrix(mat2, ncol = r, byrow = TRUE)
pm = 1
L  = 4
N  = r
rho <- 0.01
z  <-  mat[1, 1: N] 
z1 <-  mat1[1, 1: N] 
z2 <-  mat2[1, 1: N] 
x  = seq(1, N - 1, 1 )
lobj <- rep(0, (N - 1))
vh <- rep(0, (N))
for (j in 1: N){
	c1  =  z1[j]
	c2  =  z2[j]
	vh[j]  = sqrt(c1^2  + c2^2)
	}
for (j in 1 : (N - 1) ){
	lobj[j] <- -func_obj_l_gauss(j)
}
df <- data.frame(x, lobj)
##### realizar o plot usando o ggplot #######################
p <- ggplot(df, aes(x = x, y = lobj, color = 'darkred')) + geom_line() + xlab(TeX('Ponto de transição na $j$ - ésima posição ')) + ylab(TeX('$l(j)$')) + ggtitle(TeX('Função detecção por máxima verossimilhança')) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', NULL), TeX))
# escrita no diretorio /Text/Dissertacao/figura
#setwd("../..")
#setwd("Text/Dissertacao/figuras")
#ggsave("grafico_l_vert_sigmavv.pdf")
#setwd("../../..")
#setwd("Code/Code_r")
# retornou ao diretorio /Code/Code_r
print(p)