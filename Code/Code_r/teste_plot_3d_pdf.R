library(plotly)

## Not run: 
# NOTE: in a headless environment, you may need to set `more_args="--enable-webgl"`
# to export webgl correctly
p <- plot_ly(z = ~volcano) %>% add_surface()
orca(p, "surface-plot.svg")

#' # launch the server
server <- orca_serve()

# export as many graphs as you'd like
server$export(qplot(1:10), "test1.pdf")
server$export(plot_ly(x = 1:10, y = 1:10), "test2.pdf")

# the underlying process is exposed as a field, so you
# have full control over the external process
server$process$is_alive()

# convenience method for closing down the server
server$close()

# remove the exported files from disk
unlink("test1.pdf")
unlink("test2.pdf")

## End(Not run)
