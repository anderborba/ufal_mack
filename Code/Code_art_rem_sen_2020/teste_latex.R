library(ggplot2)
library(latex2exp)
x <- seq(0, 4, length.out=100)
alpha <- 1:5

plot(x, xlim=c(0, 4), ylim=c(0, 10), 
     xlab='x', ylab=TeX('$\\alpha  x^\\alpha$, where $\\alpha \\in 1\\ldots 5$'), 
     type='n', main=TeX('Using $\\LaTeX$ for plotting in base graphics!'))

invisible(sapply(alpha, function(a) lines(x, a*x^a, col=a)))

legend('topleft', legend=TeX(sprintf("$\\ell = %d$", alpha)), 
       lwd=1, col=alpha)