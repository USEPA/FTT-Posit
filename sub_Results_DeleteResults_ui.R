################################################################################
# HTML elements for the deletion of simulation results.
################################################################################
delete_results_button <- actionButton(inputId = "Delete_Results",
                                      label = "Delete Results",
                                      class = "actButton")


delete_results_modal_window <- bsModal(
  id = "DeleteResultsPopup",
  title = "Delete Results",
  trigger = "Delete_Results",
  size = "large",
  verbatimTextOutput("textMessageDeleteResults"),
  fluidRow(
    column(
      width = 8,
      actionButton(
        inputId = 'actionDeleteResults',
        label = 'Delete and Confirm',
        width = '200px',
        class = "actButton"
      )
    ),
    column(
      width = 2,
      offset = 1,
      modalButton(label = "Close")
    )
  ),
  tags$head(
    tags$style("#DeleteResultsPopup .modal-footer{display:none}")
  )
)


################################################################################
# Layout for the deletion of simulation results.
################################################################################
subDeleteResults <- tabPanel("Delete Results", sidebarLayout(
  sidebarPanel(
    shinyjs::hidden(div(
      id = "HideSelectionResultsRunId",
      h4("Select run ID"),
      selectInput(
        inputId = "selectResultsRunID",
        label = "",
        choices = ""
      )
    )),
    
    h4(""),
    
    shinyjs::hidden(div(
      id = "ResultsNameButton",
      h4("Select Associated Scenario Name"),
      selectInput(
        inputId = "selectResultsName",
        label = "",
        choices = ""
      )
    )),
    h4(""),
    
    shinyjs::hidden(div(id = "DeleteResultsButton", delete_results_button))
  ),
  
  mainPanel(delete_results_modal_window)
))