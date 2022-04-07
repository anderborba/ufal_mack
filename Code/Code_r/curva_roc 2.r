# AAB - versao 1.0 25/01/2019
# o programa le um arquivo em ~/Data com informaçoes sobre a curva ROC.  
# Obs (1) Trocar os nomes das amostras de interesse na leitura de dados,
#     (2) trocar os nomes do arquivo de impressão,
#     (3) impressão comentada.
rm(list = ls())
require(ggplot2)
require(latex2exp)
#
setwd("../..")
setwd("Data")
mat <- read.table('curva_roc_3_canais.txt')
setwd("..")
setwd("Code/Code_r")
# Esse valor é gerado no programa em matlab fus_hh_hv_vv_est_roc.m 
p <- 0.0025
N <- max(row(mat))
x_diagnostico <- seq(0, p, p/100)
y_diagnostico <- ((p - 1)/ p) * x_diagnostico + 1
xroc <- mat[1: N, 1]
yroc <- mat[1: N, 2]
df  <- data.frame(x = xroc, y = yroc)
df_diagnostico <- data.frame(x = x_diagnostico, y = y_diagnostico)
theme_update(plot.title = element_text(hjust = 0.5))
p1 <- ggplot(data = df_diagnostico, aes(x, y))
p <- p1 + geom_line(color = 'red') + 
	  geom_point(data = df, aes(x = xroc, y = yroc), color = 'blue', shape = 8)+
    ggtitle("Curva ROC") +
    xlab("Razão de positivos falsos") +
    ylab("Razão de positivos verdadeiros") + 
    annotate("text", x = df[1,1], y = df[1,2]- 0.05, label = "t == 1", parse = TRUE, color = 'blue')+
    annotate("text", x = df[2,1], y = df[2,2]- 0.05, label = "t == 2", parse = TRUE, color = 'blue')+
    annotate("text", x = df[3,1], y = df[3,2]- 0.05, label = "t == 3", parse = TRUE, color = 'blue')
print(p)
#setwd("../..")
#setwd("Text/Dissertacao/figuras")
#ggsave("curva_roc_3_canais.pdf")
#setwd("../../..")
#setwd("Code/Code_r")




