set.seed(1234)
source("func_obj_l_L_mu.r") 
Rastrigin <- function(x) {
 fn.call <<- fn.call + 1
 sum(x^2 - 10 * cos(2 * pi * x)) + 10 * length(x)
}
 dimension <- 1
 lower <- 1
 upper <- 120
 out.GenSA <- GenSA(lower = lower, upper = upper, fn = func_obj_l_L_mu,
	 control = list(max.time=1.9, verbose=TRUE))
 out.GenSA[c("value")]
