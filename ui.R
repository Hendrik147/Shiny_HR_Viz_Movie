library(ggvis)

# For dropdown menu
actionLink <- function(inputId, ...) {
  tags$a(href='javascript:void',
         id=inputId,
         class='action-button',
         ...)
}

shinyUI(fluidPage(
  titlePanel("Overview of Flexitime usage"),
  fluidRow(
    column(3,
      wellPanel(
        h4("Filter"),
        sliderInput("flexileave2015", "Flexileave 2015", 0, 14, 0, step = 1),
        sliderInput("certifiedsickleave2015", "Certified sickleave 2015", 0, 230, 0, step = 1),
        sliderInput("uncertifiedsickleave2015", "Uncertified sickleave 2015", 0, 13, 0, step = 1),
        sliderInput("daysnotrecorded2015", "Days not recorded 2015", 0, 110, 0, step = 10),
        sliderInput("excess2015", "Excess 2015", -100, 1500, 0, step = 50),
        
        selectInput("contract", "Contract",
          c("All", sort(unique(all_flexitimes$Contract)))),
        
        selectInput("grade", "Grade",
                    c("All", sort(unique(all_flexitimes$Grade)))),
        
        textInput("number", "SAP Personnelnumber"),
        textInput("last", "Initial of Last Name")
      ),
      wellPanel(
        selectInput("xvar", "X-axis variable", axis_vars, selected = "Flexileave2015"),
        selectInput("yvar", "Y-axis variable", axis_vars, selected = "Uncertifiedsickleave2015"),
      tags$small(paste0(
        "Note: AD and AST are Temporary agent grades.",
        " FG are Contract agent grades.",
        " SNE is the only National expert grade.",
        " Interims should not have an FG grade."
      ))
    )
  ),
    column(9,
      ggvisOutput("plot1"),
      wellPanel(
        span("Number of staff members selected:",
          textOutput("n_flexitimes")
        )
      )
    )
  )
))
