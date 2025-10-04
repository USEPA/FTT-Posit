################################################################################
# HTML elements and layout for import-building scenario.
################################################################################
subImport <- tabPanel("Import Scenario", sidebarLayout(
  sidebarPanel(
    import_scenario_button,
    
    shinyjs::hidden(
      div(
        id = "UploadScenarioButton",
        h4("Click 'Upload Scenario' to browse for scenario to be imported"),
        upload_scenario <-
          fileInput(
            inputId = "importScenario",
            label = NULL,
            accept = c(
              "application/vnd.openxmlformats-officedocument.spreadsheetml.sheet",
              "Microsoft Excel (OpenXML)",
              ".xlsx"
            ),
            width = '400px',
            buttonLabel = "Upload Scenario",
            placeholder = "No file selected",
            multiple = FALSE
          )
      )
    ),
    
    h4(""),
    shinyjs::hidden(
      div(
        id = "ImportScenarioButton",
        h4("Enter a new name for scenario to be imported"),
        textInput(inputId = "ImportedScenario", label = ""),
        h4(""),
        actionButton(
          inputId = "submit_ImportedScenario_name",
          label = "Submit New Scenario Name",
          width = '250px',
          style = "color: #fff; background-color: #337ab7; border-color: #2e6da4"
        )
      )
    ),
    
    h4(""),
    h5(textOutput(outputId = "textImportedScenario"))
  ),
  
  mainPanel()
))
