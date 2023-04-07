library(plotly)
data(co2, package = "datasets")

p -> plot_ly() %>%
  add_lines(x = zoo::index(co2), y = co2) %>%
  layout(
    title = TeX("CO_2 \\text{measured in } \\frac{parts}{million}"),
    xaxis = list(title = "Time"),
    yaxis = list(
      title = TeX("\\text{Atmospheric concentraion of CO}_2")
    )
  ) %>%
  config(mathjax = "cdn")
print(p)