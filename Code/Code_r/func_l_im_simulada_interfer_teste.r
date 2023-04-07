rm(list = ls())
require(graphics)
soma1 <- function(j){
	soma1 = 0
	for (i in 1 : j){
		#print(z[i])
		soma1 = soma1 + log(func_g(z[i])) 
	}
	return(soma1)
}
soma2 <- function(j){
	soma2 = 0
	for (i in (j + 1) : m){
		soma2 = soma2 + log(func_g(z[i])) 
	}
	return(soma2)
}
func_g <- function(x) {
	aux1 <- 4 * n^(n + 1) / (gamma(n) * abs(rho)^2) * x^n
	aux2 <- 4 * n^(n + 1) / (gamma(n) * abs(rho)^2) 
        cons1 = (2 * abs(rho) * n) / (1- abs(rho)^2) 	
        cons2 = (2            * n) / (1- abs(rho)^2) 	
        #func_g <- aux1 *  besselI(cons1 * x, 0) * besselK(cons2 * x, n - 1) 
	func_g <- aux1 *  besselI(cons1 * x, 0) * besselK(cons2 * x, n - 1) 
 
        return(func_g)
}
func_obj_l <- function(j) {
        #func_obj_l <- soma1() + soma2() 
        func_obj_l <-  soma1(j) + soma2(j) 
        #func_obj_l <-  soma1(j)
	print(j)
       	print(soma1(j) )
       	print(soma2(j) )
        return(func_obj_l)
}
setwd("../..")
setwd("Data")
mat <- scan('Phantom_nhfc_prod_0.000_1_2_1.txt')
mat1 <- scan('Phantom_nhfc_0.000_1_2_1.txt')
mat2 <- scan('Phantom_nhfc_0.000_1_2_2.txt')
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
n = 1
m = 400
rho <- 0.7
mat  <- matrix(mat,  ncol = 400, byrow = TRUE)
mat1 <- matrix(mat1, ncol = 400, byrow = TRUE)
mat2 <- matrix(mat2, ncol = 400, byrow = TRUE)
z   <- matrix(0, 1, 400)
z1  <- matrix(0, 1, 400)
z2  <- matrix(0, 1, 400)
z  <-  mat[200,1:400] 
z1 <-  mat1[200,1:400] 
z2 <-  mat2[200,1:400]
vh <- rep(0, m)
for (j in 1 : m ){
	c1 = z1[j]
	c2 = z2[j]
	vh[j] = sqrt(c1^2 * c2^2)
	z[j] = z[j] / vh[j]
}
alphar = -9.14
alphab = -3.92
gamr = 372294
gamb = 293242
x =seq(1, m, 1)
lobj <- rep(0, m)
#
for (j in 1: m ){
	lobj[j] <- func_obj_l(j) 
}
plot(x, lobj, type="l", main = "Função objetivo l(j)")
#dev.off()
