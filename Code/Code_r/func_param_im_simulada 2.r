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
#require(ggplot2)
require(latex2exp)
# Library
library(plotly)
#library(plot3d)
require(rgl)
# funcoes auxiliares para encontrar l(j) de acordo com \cite{nhfc}
source("func_soma_1_to_j.r")
source("func_soma_j_to_n.r")
source("fpmgamma.r")
source("func_obj_l.r")
# Programa principal
## Leitura do arquivo *.txt no diretorio /Data 
setwd("../..")
setwd("Data")
mat <- scan('Phantom_nhfc_0.000_1_2_1.txt')
#mat <- scan('Phantom_nhfc_0.000_1_2_2.txt')
#mat <- scan('Phantom_nhfc_0.000_1_2_3.txt')
#mat <- scan('Phantom_nhfc_0.000_1_2_4.txt')
#mat <- scan('Phantom_nhfc_0.000_1_2_5.txt')
#mat <- scan('Phantom_nhfc_0.000_1_2_6.txt')
#mat <- scan('Phantom_nhfc_0.000_1_2_7.txt')
#mat <- scan('Phantom_nhfc_0.000_1_2_8.txt')
#mat <- scan('Phantom_nhfc_0.000_1_2_9.txt')
#mat <- scan('Phantom_gamf_0.000_1_2_1.txt')
#mat <- scan('Phantom_gamf_0.000_1_2_2.txt')
#mat <- scan('Phantom_gamf_0.000_1_2_3.txt')
#mat <- scan('Phantom_vert_0.000_1_2_1.txt')
#mat <- scan('Phantom_vert_0.000_1_2_2.txt')
#mat <- scan('Phantom_vert_0.000_1_2_3.txt')
setwd("..")
setwd("Code/Code_r")
## retornou ao diretorio de trabalho /Code/Code_r
mat <- matrix(mat, ncol = 400, byrow = TRUE)
z  <- matrix(0, 1, 400)
z <-  mat[200,1:400] 
N  <- 50
x  <- matrix(0, 1, N)
y  <- matrix(0, 1, N)
A <- matrix(0, N, N)
l <- 180
a <- 1
b <- 10
c <- 0
d <- 1
hx <- (b - a) / N
hy <- (d - c) / N
eps <- 0.1
for (i in 0 : N + 1){ 
  x[i] <- a + (i - 1) * hx + eps
  y[i] <- c + (i - 1) * hy + eps
}
for (i in 1 : N){
  for (j in 1 : N){
	  A[i, j] <- (x[i] * log(x[i]) + (x[i] - 1) * log(z[l]) - x[i] * log(y[j]) - log(gamma(x[i])) - (x[i] / y[j]) * z[l])
  }
}
#df <- data.frame(x, y, A)
#pdf(file.pdf,width=6,height=4,paper='special')
#pdf("teste.pdf")
p <- plot_ly(x = x, y = y,z = A, type = "surface") %>%
  layout(
    title = "ddd",
    scene = list(
      xaxis = list(title = TeX("\\sqrt{2}")),
      yaxis = list(title = "Sin"),
      zaxis = list(title = "Z")
    ))
#p <- plot3d(x = x, y = y,z = A, type = "surface")
#orca("teste.pdf")
print(p)
#orca(p, "surface-plot.pdf")
#dev.off()
##### realizar o plot usando o ggplot #######################
#### Retirei esse comando para gerar figuras para artigo em inglês 
#p <- ggplot(df, aes(x = x, y = lobj, color = 'darkred')) + geom_line() + xlab(TeX('Position $j$ - ésima posição ')) + ylab(TeX('$l(j)$')) + ggtitle(TeX('Função detecção por máxima verossimilhança')) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', NULL), TeX))
#p <- ggplot(df, aes(x = x, y = lobj, color = 'darkred')) + geom_line() + xlab(TeX('Pixel $j$')) + ylab(TeX('$l(j)$')) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', NULL), TeX))
# escrita no diretorio /Text/Dissertacao/figura
#setwd("../..")
#setwd("Text/Dissertacao/figuras")
#ggsave("grafico_l_nhfc_2014_sigmavv_artigos.pdf")
#setwd("../../..")
#setwd("Code/Code_r")
# retornou ao diretorio /Code/Code_r
#print(p)
