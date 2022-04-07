library(plotly)
require(latex2exp)

x0 <- seq(1,100,by=0.1)
z0<-x0^2%*%t(x0)
p <- plot_ly(
  x = x0, 
  y = x0,
  z = z0)%>%
  add_surface() %>%
  layout(
    title = TeX("\\text{Graph of } f(x,y)=x^2*y"),
    scene = list(
      xaxis = list(title = "x"),
      yaxis = list(title = "y" ),  
      zaxis = list(title = TeX("f(x,y)=x^2*y"))
    ))#%>%
#  config(mathjax = 'cdn')
