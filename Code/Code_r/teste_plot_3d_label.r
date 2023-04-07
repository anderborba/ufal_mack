library(plotly)
fig <- plot_ly(
  x = c(1, 2, 3, 4), 
  y = c(1, 4, 9, 16),
  name = TeX("\\alpha_{1c} = 352 \\pm 11 \\text{ km s}^{-1}"))
fig <- fig %>% add_trace(
  x = c(1, 2, 3, 4), 
  y = c(0.5, 2, 4.5, 8),
  name = TeX("\\beta_{1c} = 25 \\pm 11 \\text{ km s}^{-1}"))
fig <- fig %>% layout(
  xaxis = list(
    title = TeX("\\sqrt{(n_\\text{c}(t|{T_\\text{early}}))}")),
  yaxis = list(
    title = TeX("d, r \\text{ (solar radius)}")))
fig <- fig %>% config(mathjax = 'cdn')

print(fig)


