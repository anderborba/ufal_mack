library(plotly)
set.seed(123)

n <- 100
theta <- runif(n, 0, 2*pi)
u <- runif(n, -1, 1)

p <- plot_ly(x = ~sqrt(1 - u^2) * cos(theta), y = ~sqrt(1 - u^2) * sin(theta), z = ~u) %>%
  layout(
    title = "Layout options in a 3d scatter plot",
    scene = list(
      xaxis = list(title = "Cos"),
      yaxis = list(title = "Sin"),
      zaxis = list(title = "Z")
    ))

# Create a shareable link to your chart
# Set up API credentials: https://plot.ly/r/getting-started
#chart_link = api_create(p, filename="scatter3d-axis-labels")
#hart_link