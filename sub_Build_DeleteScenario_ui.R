####################################################################################################
# HTML elements for deleting scenarios.
####################################################################################################
delete_scenario_button <- actionButton(
  inputId = "Delete_Scenario",
  label = "Delete Scenario",
  width = '150px',
  style = "color: #fff; background-color: blue; border-color: #2e6da4;"
)

delete_scenario_modal_window <- bsModal(
  id = "DeleteScenarioPopup",
  title = "Delete Scenario",
  trigger = "Delete_Scenario",
  size = "l",
  verbatimTextOutput("textMessageDeleteScenario"),
  fluidRow(
    column(
      width = 8,
      actionButton(
        inputId = 'actionDeleteScenario',
        label = 'Confirm and Delete',
        width = '175px',
        style =
          "color: #fff; background-color: blue; border-color: #2e6da4"
      )
    ),
    column(
      width = 2,
      offset = 1,
      modalButton(label = "Close")
    )
  ),
  tags$head(
    tags$style("#DeleteScenarioPopup .modal-footer{display:none}")
  )
)


################################################################################
# Layout for deleting scenarios.
################################################################################
subDelete <- tabPanel("Delete Scenario", sidebarLayout(
  sidebarPanel(shinyjs::hidden(
    div(
      id = "HideDeleteScenarioSelection",
      h4("Select scenario you wish to delete"),
      selectInput(
        inputId = "deleteScenario",
        label = "",
        choices = ""
      )
    )
  ), h4(""), shinyjs::hidden(
    div(id = "DeleteScenarioButton", delete_scenario_button)
  )),
  
  mainPanel(delete_scenario_modal_window)
))