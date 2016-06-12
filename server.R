library(ggvis)
library(dplyr)

if (FALSE) library(RSQLite)

setwd("~/Developing Data Science Products/EMA")

base <- read.csv("REPORT_RESULTa.csv", sep=";")
base15 <- read.csv("REPORT_RESULT 2015a.csv", sep=";")
all_flexitimes <- merge(base, base15, by = "Personnel.Number..P.", all.x=TRUE)

shinyServer(function(input, output, session) {

  # Filter staff, returning a data frame
  flexitimes <- reactive({
    # Due to dplyr issue #318, we need temp variables for input values
    flexi.leave.2015 <- input$flexi.leave.2015
    certified.sickleave.2015 <- input$certified.sickleave.2015
    uncertified.sickleave.2015 <- input$uncertified.sickleave.2015
    days.not.recorded.2015 <- input$days.not.recorded.2015
    excess.2015 <- input$excess.2015
  
    # Apply filters
    m <- all_flexitimes %>%
      filter(
        Flexi.leave.2015 >= flexi.leave.2015,
        Certified.sickleave.2015 >= certified.sickleave.2015,
        Uncertified.sickleave.2015 >= uncertified.sickleave.2015,
        Days.not.recorded.2015 >= days.not.recorded.2015,
        Excess.2015 >= excess.2015
        
      ) %>%
      arrange(Pay.Scale.Group)
    
    # Optional: filter by Name.of.EE.subgroup
    if (input$name.of.EE.subgroup != "All") {
      name.of.EE.subgroup <- paste0("%", input$name.of.EE.subgroup, "%")
      m <- m %>% filter(Name.of.EE.subgroup %like% name.of.EE.subgroup)
    }
    # Optional: filter by Pay.Scale.Group
    if (input$pay.Scale.Group != "All") {
      pay.Scale.Group <- paste0("%", input$pay.Scale.Group, "%")
      m <- m %>% filter(Pay.Scale.Group %like% pay.Scale.Group)
    }
    
    # Optional: filter by Personnel.Number..P.
    if (!is.null(input$personnel.Number..P.) && input$personnel.Number..P. != "") {
      personnel.Number..P. <- paste0("%", input$personnel.Number..P., "%")
      m <- m %>% filter(Personnel.Number..P. %like% personnel.Number..P.)
    }
    
    # Optional: filter by Last.Name
    if (!is.null(input$last.Name) && input$last.Name != "") {
      last.Name <- paste0("%", input$last.Name, "%")
      m <- m %>% filter(Last.Name %like% last.Name)
    }
  m <- as.data.frame(m)
  m
    })

  # Function for generating tooltip text
  flexitime_tooltip <- function(x) {
    if (is.null(x)) return(NULL)
    if (is.null(x$Personnel.Number..P.)) return(NULL)

    # Pick out the staff with this Personnel.Number..P.
    all_flexitimes <- isolate(flexitimes())
    flexitime <- all_flexitimes[all_flexitimes$Personnel.Number..P. == x$Personnel.Number..P., ]

    paste0("<b>", flexitime$First.Name, flexitime$Last.Name, "</b><br>",
      flexitime$Pay.Scale.Group, "<br>",
      flexitime$Name.of.EE.subgroup
      )
  }

  # A reactive expression with the ggvis plot
  vis <- reactive({
    # Lables for axes
    xvar_name <- names(axis_vars)[axis_vars == input$xvar]
    yvar_name <- names(axis_vars)[axis_vars == input$yvar]

    # Normally we could do something like props(x = ~BoxOffice, y = ~Reviews),
    # but since the inputs are strings, we need to do a little more work.
    xvar <- prop("x", as.symbol(input$xvar))
    yvar <- prop("y", as.symbol(input$yvar))

    flexitimes %>%
      ggvis(x = xvar, y = yvar) %>%
      layer_points(size := 50, size.hover := 200,
        fillOpacity := 0.2, fillOpacity.hover := 0.5,
        key := ~ Personnel.Number..P.) %>%
      add_tooltip(flexitime_tooltip, "hover") %>%
      add_axis("x", title = xvar_name) %>%
      add_axis("y", title = yvar_name) %>%
      set_options(width = 500, height = 500)
  })

  vis %>% bind_shiny("plot1")

  output$n_flexitimes <- renderText({ nrow(flexitimes()) })
})
