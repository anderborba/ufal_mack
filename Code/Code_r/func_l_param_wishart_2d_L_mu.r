## Estimate the parameter of wishart distribution
rm(list = ls())
source("func_l_param_wishart_2d_to_j.r") ## Cuidado tem o rm(list = ls) no programa
source("func_obj_l_L_mu.r")
x <- seq(N - 1)
lobj <- rep(0, (N - 1))
for (j in 1 : (N - 1) ){
  lobj[j] <- func_obj_l_L_mu(j)
}
df <- data.frame(x, lobj)
p <- ggplot(df, aes(x = x, y = lobj, color = 'darkred')) + geom_line() + xlab(TeX('Pixel $j$')) + ylab(TeX('$l(j)$')) + guides(color=guide_legend(title=NULL)) + scale_color_discrete(labels= lapply(sprintf('$\\sigma_{hh} = %2.0f$', NULL), TeX))
# escrita no diretorio /Text/Dissertacao/figura
#setwd("../..")
#setwd("Text/Dissertacao/figuras")
#ggsave("func_max_ver_L_4_z_80_flev_wishart.pdf")
#setwd("../../..")
#setwd("Code/Code_r")
# retornou ao diretorio /Code/Code_r
print(p)
