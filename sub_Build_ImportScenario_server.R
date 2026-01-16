################################################################################
# Events associated with the importing of scenarios.
################################################################################
observeEvent(input$Import_Scenario, {
  shinyjs::show(id = "UploadScenarioButton")
  reset(id = "importScenario")
  shinyjs::hide(id = "ImportScenarioButton")
  
  output$textImportedScenario <- NULL
  
  shinyjs::enable(id = "importScenario")
  shinyjs::enable(id = "submit_ImportedScenario_name")
  shinyjs::enable(id = "ImportedScenario")
})

observeEvent(input$submit_ImportedScenario_name, {
  input_Imported_Scenario <- input$ImportedScenario
  if (is.null(input_Imported_Scenario) ||
      (trimws(input_Imported_Scenario) == ""))
  {
    shinyjs::info("Input textbox is empty. Please enter a name.")
    
  } else if (verifyScenarioName(input_Imported_Scenario))
  {
    msg <- paste(
      "The name ",
      input_Imported_Scenario,
      " is already taken. Please enter a different name."
    )
    shinyjs::info(msg)
    
  } else
  {
    submit_imported_scenarioName(input_Imported_Scenario, input$importScenario$datapath)
    
    output$textImportedScenario <- renderText({
      paste(
        "The scenario ",
        input_Imported_Scenario,
        " has been successfully imported.",
        sep = ""
      )
    })
    
    updateTextInput(session, inputId = "ImportedScenario", value = "")
    
    updateSelectInput(
      session,
      "baselines",
      choices = c("None Selected", scenario_names),
      selected = input$baselines
    )
    
    updateSelectInput(
      session,
      "downloadScenario",
      choices = c("None Selected", scenario_names),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      "deleteScenario",
      choices = c("None Selected", scenario_names),
      selected = "None Selected"
    )
    
    updateCheckboxGroupInput(session,
                             "Check_Scenario_Names",
                             choices = as.list(scenario_names))
    
    shinyjs::show(id = "Visualization_GRS")
    
    shinyjs::show(id = "Visualization_SPB")
    
    shinyjs::show(id = "HideExportScenarioButton")
    
    shinyjs::show(id = "HideDeleteScenarioSelection")
    
    shinyjs::show(id = "HideAddStressorScenarioButton")
    
    shinyjs::show(id = "HideAddSimulationRunButton")
    
    shinyjs::disable(id = "importScenario")
    shinyjs::disable(id = "submit_ImportedScenario_name")
    shinyjs::disable(id = "ImportedScenario")
    
  }
  
})

observeEvent(input$importScenario, {
  ImportedScenarioName <- extract_name_imported_scenario(input$importScenario$datapath)
  
  result <- tolower(ImportedScenarioName) %in% tolower(scenario_names)
  
  if (result == TRUE)
  {
    shinyjs::show(id = "ImportScenarioButton")
    
    msg <- paste(
      "The name ",
      ImportedScenarioName,
      " is already taken. Please enter a new name for the imported scenario."
    )
    shinyjs::info(msg)
    
  } else
  {
    submit_imported_scenarioName(ImportedScenarioName, input$importScenario$datapath)
    
    output$textImportedScenario <- renderText({
      paste("The scenario ",
            ImportedScenarioName,
            " has been successfully imported.",
            sep = "")
    })
    
    updateSelectInput(
      session,
      "baselines",
      choices = c("None Selected", scenario_names),
      selected = input$baselines
    )
    
    updateSelectInput(
      session,
      "downloadScenario",
      choices = c("None Selected", scenario_names),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      "deleteScenario",
      choices = c("None Selected", scenario_names),
      selected = "None Selected"
    )
    
    updateCheckboxGroupInput(session,
                             "Check_Scenario_Names",
                             choices = as.list(scenario_names))
    
    updateCheckboxGroupInput(session,
                             "Check_Scenario_Names_Run",
                             choices = as.list(scenario_names))
    
    updateCheckboxInput(session, inputId = "All_Runs", value = FALSE)
    
    shinyjs::show(id = "Visualization_GRS")
    
    shinyjs::show(id = "Visualization_SPB")
    
    shinyjs::show(id = "HideExportScenarioButton")
    
    shinyjs::show(id = "HideDeleteScenarioSelection")
    
    shinyjs::show(id = "HideAddStressorScenarioButton")
    
    shinyjs::show(id = "HideAddSimulationRunButton")
    
    shinyjs::disable(id = "importScenario")
    shinyjs::disable(id = "submit_ImportedScenario_name")
    shinyjs::disable(id = "ImportedScenario")
  }
  
})


################################################################################
# Functions used for the importing of scenarios.
################################################################################

#-------------------------------------------------------------------------------
# This function adds imported scenario name to list
#-------------------------------------------------------------------------------
submit_imported_scenarioName <- function(importedScenarioName, input_file)
{
  scenario_names <<- c(scenario_names, importedScenarioName)
  
  # Reads in the metadata worksheet of the excel file
  metaDataIn <- read_excel(input_file, sheet = "Metadata")
  
  # Extracts the Scenario description
  importedScenarioDesc <- as.character(subset(metaDataIn, Field == "Scenario Description", select = Value))
  
  # Once Scenario Name is submitted, append importedScenarioDesc to scenarioDescriptions list
  scenarioDescriptions[[importedScenarioName]] <<- importedScenarioDesc
  
  # Reads in the parameters worksheet of the excel file
  parametersIn <- as.data.frame(read_excel(input_file, sheet = "Parameters"))
  
  # Once Scenario Name is submitted, append parametersIn to parameters list
  parameters[[importedScenarioName]] <<- parametersIn
  
}

extract_name_imported_scenario <- function(input_file)
{
  # Reads in the metadata worksheet of the excel file
  metaDataIn <- read_excel(input_file, sheet = "Metadata")
  
  # Extracts the Scenario name
  importedScenarioName <- as.character(subset(metaDataIn, Field == "Scenario Name", select = Value))
  
  return(importedScenarioName)
}