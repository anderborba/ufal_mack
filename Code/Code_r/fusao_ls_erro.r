# AAB - versao 1.0 17/11/2018
# o programa le um arquivo em ~/Data com informaçoes sobre o erro max(p_est - b) na deteccao e imprime o gráfico erro x pixel(/Text/Dissertacao/figuras). Onde p_est é a evidência de borda encontrada para cada linha da matrix(400 x 400) dividida em duas amostras distintas e b é a borda conhecida.  
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
mat <- read.table('fusao_ls_erro_vert.txt')
setwd("..")
setwd("Code/Code_r")
N  = 400
tp <- N / 2
x  = seq(1, N, 1 )
error  <- rep(0, N)
error  <- mat[1: N, 1]
df <- data.frame(x = x, y1 = error)
p <- ggplot(df)
pp <- p + geom_line(aes(x = x, y = y1, color = "erro")) + ggtitle(TeX('Valor absoluto da diferença entre o vetor estimado e a borda real')) + ylab(TeX('erro = |p_{est} - b|')) + xlab(TeX('Pixels')) 
print(pp) 
setwd("../..")
setwd("Text/Dissertacao/figuras")
#ggsave("fusao_ls_erro_vert.pdf")
setwd("../../..")
setwd("Code/Code_r")




