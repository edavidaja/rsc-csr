library(shiny)
library(tibble)


route_table <- tibble::tribble(
  ~group, ~route,
  "Solutions Engineer", "bike-share",
  "Default", "connectwidgets-bookmark"
) |> tibble::deframe()



ui <- fluidPage(
  
)

server <- function(input, output, session) {
  
  observe({
    route <- paste0(
      Sys.getenv("CONNECT_SERVER"), route_table[session$group]
    )
    
    session$sendCustomMessage(
      type = "reroute",
      message = route
      )
  })
  
}

shinyApp(ui, server)