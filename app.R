library(shiny)
library(tibble)

route_table <-
  tibble::deframe(
    tibble::tribble(
      ~group, ~route,
      "Default", "bike-share",
      "Solutions Engineer", "shiny-session-info"
    )
  )

ui <- fluidPage(
  singleton(
    tags$head(tags$script(src = "redirect.js"))
  )
)

server <- function(input, output, session) {
  observe({
    route <- paste0(
      Sys.getenv("CONNECT_SERVER"), route_table[session$groups]
    )
    print(route)

    session$sendCustomMessage(
      type = "reroute",
      message = route
    )
  })
}

shinyApp(ui, server)