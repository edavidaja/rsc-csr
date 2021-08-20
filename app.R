library(shiny)
library(tibble)

route_table <- tibble::tribble(
  ~user, ~route,
  "cole@rstudio.com", "shiny-shell",
  "david@rstudio.com", "plumbertableaux"
) |> tibble::deframe()

ui <- fluidPage()

server <- function(input, output, session) {
  
  observe({
    route <- paste0(
      Sys.getenv("CONNECT_SERVER"), route_table[session$user]
    )
    print(route)
    
    session$sendCustomMessage(
      type = "reroute",
      message = route
      )
  })
  
}

shinyApp(ui, server)