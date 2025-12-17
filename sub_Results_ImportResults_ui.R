################################################################################
#  HTML elements for the importing of simulation results.
################################################################################
import_results_button <- actionButton(inputId = "Import_Results",
                                      label = "Import Results",
                                      class = "actButton")


################################################################################
#  Layout for the importing of simulation results.
################################################################################
subImportResults <- tabPanel("Import Results", sidebarLayout(
  sidebarPanel(
    import_results_button,
    
    shinyjs::hidden(
      div(
        id = "UploadResultsButton",
        h4("Click 'Upload Results' to browse for results to be imported."),
        upload_scenario <-
          fileInput(
            inputId = "importResults",
            label = NULL,
            accept = c(
              "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
              "Microsoft Excel (OpenXML)",
              ".xlsx"
            ),
            width = '400px',
            buttonLabel = "Upload Results",
            placeholder = "No file selected",
            multiple = FALSE
          )
      )
    ),
    
    shinyjs::hidden(
      div(
        id = "Imported_Results_RunID",
        textInput(inputId = "ImportedResultsRunID", label = ""),
        h4(""),
        actionButton(
          inputId = "submit_ImportedResults_runID",
          label = "Submit New Run ID",
          width = '250px',
          style = "color: #fff; background-color: #337ab7; border-color: #2e6da4"
        ),
        h4("")
      )
    ),
    
    shinyjs::hidden(
      div(
        id = "Imported_Results_ScenarioName",
        textInput(inputId = "ImportedResults", label = ""),
        h4(""),
        actionButton(
          inputId = "submit_ImportedResults_ScenarioName",
          label = "Submit New Scenario Name",
          width = '250px',
          style = "color: #fff; background-color: #337ab7; border-color: #2e6da4"
        ),
        h4("")
      )
    ),
    
    shinyjs::hidden(
      div(
        id = "Imported_Results_NameRunID",
        textInput(inputId = "ResultsRunId", label = "New Run ID"),
        h4(""),
        textInput(inputId = "ResultsName", label = "New Results Name"),
        h4(""),
        actionButton(
          inputId = "submit_ImportedResults_NameRunID",
          label = "Submit New Scenario Name and Run ID",
          width = '250px',
          style = "color: #fff; background-color: #337ab7; border-color: #2e6da4"
        ),
        h4("")
      )
    ),
    
    textOutput("textImportedResults")
    
  ),
  
  mainPanel()
))