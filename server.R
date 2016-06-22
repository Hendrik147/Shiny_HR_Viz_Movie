library(ggvis)
library(dplyr)
library(data.table)

shinyServer(function(input, output, session) {

  # Filter staff, returning a data frame
  flexitimes <- reactive({
    # Due to dplyr issue #318, we need temp variables for input values
    flexileave2015 <- input$flexileave2015
    certifiedsickleave2015 <- input$certifiedsickleave2015
    uncertifiedsickleave2015 <- input$uncertifiedsickleave2015
    daysnotrecorded2015 <- input$daysnotrecorded2015
    excess2015 <- input$excess2015
  
    # Apply filters
    m <- all_flexitimes %>%
      filter(
        Flexileave2015 >= flexileave2015,
        Excess2015 >= excess2015,
        Certifiedsickleave2015 >= certifiedsickleave2015,
        Uncertifiedsickleave2015 >= uncertifiedsickleave2015,
        Daysnotrecorded2015 >= daysnotrecorded2015
        
      ) %>%
    arrange(Flexileave2015)
    
    # Optional: filter by Contract
    if (input$contract != "All") {
      #contract <- paste0("%", input$contract, "%")
      m <- m %>% filter(Contract == input$contract)
    }
    # Optional: filter by Grade
    if (input$grade != "All") {
      grade <- paste0("%", input$grade, "%")
      m <- m %>% filter(Grade == input$grade)
    }
    
    # Optional: filter by Number
    if (!is.null(input$number) && input$number != "") {
      number <- paste0("%", input$number, "%")
      m <- m %>% filter(Number == input$number)
    }
    
    # Optional: filter by Last Name
    if (!is.null(input$last) && input$last != "") {
      last <- paste0("%", input$last, "%")
      m <- m %>% filter(Last == input$last)
    }
  m <- as.data.frame(m)
  m
    })

  # Function for generating tooltip text
  flexitime_tooltip <- function(x) {
    if (is.null(x)) return(NULL)
    if (is.null(x$Number)) return(NULL)

    # Pick out the staff with this Number
    all_flexitimes <- isolate(flexitimes())
    flexitime <- all_flexitimes[all_flexitimes$Number == x$Number, ]

    paste0("<b>", flexitime$First, flexitime$Last, "</b><br>",
      flexitime$Grade, "<br>",
      flexitime$Contract
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
        key := ~ Number) %>%
      add_tooltip(flexitime_tooltip, "hover") %>%
      add_axis("x", title = xvar_name) %>%
      add_axis("y", title = yvar_name) %>%
      set_options(width = 500, height = 500)
  })

  vis %>% bind_shiny("plot1")

  output$n_flexitimes <- renderText({ nrow(flexitimes()) })
})
