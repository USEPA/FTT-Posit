################################################################################
#  HTML elements for the resetting of the Shiny app.
################################################################################
reset_clear_button <- actionButton(inputId = "reset_clear_app",
                                   label = "Reset App",
                                   class = "actButton")


################################################################################
# Layout for the resetting of the Shiny app.
################################################################################
tabReset <- tabPanel(
  "Reset/Clear App",
  
  div(
    helper(
      shiny_tag = h3("Reset"),
      icon = "question-circle",
      colour = helper_Color,
      type = "inline",
      title = "Reset App",
      content = "The reset/clear tab contains a button that will remove all scenarios and results currently stored in memory and will restore the app to its original state."
    ),
    style = 'width:90px'
  ),
  
  reset_clear_button,
  h4(""),
  verbatimTextOutput("textMessageResetApp"),
  tags$head(tags$style(
    HTML("#textMessageResetApp {font-size: 20px;}")
  ))
)
