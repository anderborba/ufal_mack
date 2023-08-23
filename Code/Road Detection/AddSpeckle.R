# Adding speckle to the three channels of a TIFF image

library(rstudioapi)
library(tiff)
library(GGally)

setwd(dirname(getActiveDocumentContext()$path)) 
Clean <- readTIFF(source="../../Images/TIFF/10078675_15.tiff")
Clean.df <- data.frame(r=as.vector(Clean[,,1]),
                       g=as.vector(Clean[,,2]),
                       b=as.vector(Clean[,,3]))
summary(Clean.df)
ggpairs(Clean.df)
