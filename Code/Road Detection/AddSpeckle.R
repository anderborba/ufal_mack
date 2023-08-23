# Adding speckle to the three channels of a TIFF image

library(GGally)
library(tiff)
source("imagematrix.R")
set.seed(1234567890, kind="Mersenne-Twister")

setwd(dirname(rstudioapi::getActiveDocumentContext()$path)) 
Clean <- readTIFF(source="../../Images/TIFF/10078675_15.tiff")
Clean.df <- data.frame(r=as.vector(Clean[,,1]),
                       g=as.vector(Clean[,,2]),
                       b=as.vector(Clean[,,3]))

summary(Clean.df)
ggpairs(Clean.df)

# The blue channel usually has the least amount of information
plot(imagematrix(Clean[,,3]))

# Inject single-look speckle
SpeckledBlue <- Clean[,,3]*rexp(n=prod(dim(Clean[,,3])), rate=1)
plot(imagematrix(clipping(SpeckledBlue)))
