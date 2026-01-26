################################################################################
# Events used for the handling of importing simulation results.
################################################################################
observeEvent(input$Import_Results, {
  shinyjs::show(id = "UploadResultsButton")
  reset(id = "importResults")
  shinyjs::hide(id = "ImportResultsButton")
  shinyjs::hide(id = "Imported_Results_ScenarioName")
  
  output$textImportedResults <- NULL
  updateTextInput(session, inputId = "ImportedResults", value = "")
  
  shinyjs::enable(id = "importResults")
  shinyjs::enable(id = "submit_ImportedResults_ScenarioName")
  shinyjs::enable(id = "ImportedResults")
})

observeEvent(input$importResults, {
  extract_runID_scenarioName(input$importResults$datapath)
  
  output$textImportedResults <- NULL
  
  if (runID_Exists == TRUE &&
      scenarioName_Exists == TRUE)
  {
    msg <- paste(
      "The run ID ",
      submittedRunID,
      " and the scenario name ",
      submittedResultsName,
      " are already taken. The run ID will be kept but the scenario name will have to be changed. Please enter a new scenario name for the imported results."
    )
    shinyjs::info(msg)
    shinyjs::hide(id = "Imported_Results_RunID")
    shinyjs::show(id = "Imported_Results_ScenarioName")
    shinyjs::hide(id = "Imported_Results_NameRunID")
    
  } else
  {
    submit_results_runID(submittedRunID, input$importResults$datapath)
    submit_results_name(submittedResultsName, input$importResults$datapath)
    
    shinyjs::show(id = "HideSelectionRunID")
    shinyjs::show(id = "HideSelectionResultsRunId")
    shinyjs::show(id = "Results_Options")
    updateCheckboxGroupInput(session,
                             "Check_Scenario_Names_Results",
                             choices = names(unlist(modelRuns, recursive = F)))
    
    updateCheckboxInput(session, inputId = "All_Results", value = FALSE)
    
    updateSelectInput(
      session,
      "selectRunID",
      choices = c("None Selected", as.list(runID)),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      inputId = "selectAssociatedScenario",
      choices = c("None Selected", as.list(names(modelRuns[[submittedRunID]]))),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      "selectResultsRunID",
      choices = c("None Selected", as.list(runID)),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      inputId = "selectResultsName",
      choices = c("None Selected", as.list(names(modelRuns[[submittedRunID]]))),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      "deleteResults",
      choices = c("None Selected", as.list(names(
        unlist(modelRuns, recursive = F)
      ))),
      selected = "None Selected"
    )
    
    shinyjs::disable(id = "importResults")
    shinyjs::disable(id = "ImportedResults")
    shinyjs::disable(id = "submit_ImportedResults_ScenarioName")
    runID_Exists <<- FALSE
    scenarioName_Exists <<- FALSE
  }
  
})

observeEvent(input$submit_ImportedResults_ScenarioName, {
  enteredScenarioName <- input$ImportedResults
  if (is.null(enteredScenarioName) ||
      (trimws(enteredScenarioName) == ""))
  {
    shinyjs::info("Input textbox is empty. Please enter a scenario name.")
    
  } else if (verifyResultsScenarioName(enteredScenarioName))
  {
    msg <- paste("The name ",
                 enteredScenarioName,
                 " is already taken. Please enter a different name.")
    shinyjs::info(msg)
    
  } else
  {
    submit_results_name(enteredScenarioName, input$importResults$datapath)
    
    output$textImportedResults <- renderText({
      paste(
        "The results with run ID ",
        submittedRunID,
        " and name ",
        enteredScenarioName,
        " have been successfully uploaded to the app."
      )
    })
    
    
    updateCheckboxGroupInput(session,
                             "Check_Scenario_Names_Results",
                             choices = names(unlist(modelRuns, recursive = F)))
    
    updateCheckboxInput(session, inputId = "All_Results", value = FALSE)
    
    updateSelectInput(
      session,
      "selectRunID",
      choices = c("None Selected", as.list(runID)),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      inputId = "selectAssociatedScenario",
      choices = c("None Selected", as.list(names(modelRuns[[submittedRunID]]))),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      "selectResultsRunID",
      choices = c("None Selected", as.list(runID)),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      inputId = "selectResultsName",
      choices = c("None Selected", as.list(names(modelRuns[[submittedRunID]]))),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      "deleteResults",
      choices = c("None Selected", as.list(names(
        unlist(modelRuns, recursive = F)
      ))),
      selected = "None Selected"
    )
    
    shinyjs::show(id = "Results_Options")
    shinyjs::show(id = "HideSelectionRunID")
    shinyjs::show(id = "HideSelectionResultsRunId")
    shinyjs::disable(id = "importResults")
    shinyjs::disable(id = "ImportedResults")
    shinyjs::disable(id = "submit_ImportedResults_ScenarioName")
    runID_Exists <<- FALSE
    scenarioName_Exists <<- FALSE
    
  }
  
})

observeEvent(input$submit_ImportedResults_runID, {
  enteredRunID <- input$submit_ImportedResults_runID
  
  if (is.null(enteredRunID) ||
      (trimws(enteredRunID) == ""))
  {
    shinyjs::info("Input textbox is empty. Please enter a run ID.")
    
  } else if (verifyResultsRunID(enteredRunID))
  {
    msg <- paste("The run ID ",
                 enteredRunID,
                 " is already taken. Please enter a different run ID.")
    shinyjs::info(msg)
    
  } else
  {
    submit_results_runID(enteredRunID, input$importResults$datapath)
    
    output$textImportedResults <- renderText({
      paste(
        "The results with run ID ",
        enteredRunID,
        " and name ",
        submittedResultsName,
        " have been successfully uploaded to the app."
      )
    })
    
    updateCheckboxGroupInput(session,
                             "Check_Scenario_Names_Results",
                             choices = names(unlist(modelRuns, recursive = F)))
    
    updateCheckboxInput(session, inputId = "All_Results", value = FALSE)
    
    updateSelectInput(
      session,
      "selectRunID",
      choices = c("None Selected", as.list(runID)),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      inputId = "selectAssociatedScenario",
      choices = c("None Selected", as.list(names(modelRuns[[enteredRunID]]))),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      "selectResultsRunID",
      choices = c("None Selected", as.list(runID)),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      inputId = "selectResultsName",
      choices = c("None Selected", as.list(names(modelRuns[[enteredRunID]]))),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      "deleteResults",
      choices = c("None Selected", as.list(names(
        unlist(modelRuns, recursive = F)
      ))),
      selected = "None Selected"
    )
    
    shinyjs::show(id = "Results_Options")
    shinyjs::show(id = "HideSelectionRunID")
    shinyjs::show(id = "HideSelectionResultsRunId")
    
  }
  
})

observeEvent(input$submit_ImportedResults_NameRunID, {
  enteredRunID <- input$ResultsRunId
  enteredResultsName <- input$ResultsName
  
  if (is.null(enteredRunID) ||
      (trimws(enteredRunID) == "") ||
      is.null(enteredResultsName) ||
      (trimws(enteredResultsName) == ""))
  {
    shinyjs::info(
      "One or two of the input textboxes is(are) empty. Please enter the requested information."
    )
    
  } else if (verifyResultsRunID(enteredRunID) &&
             verifyResultsScenarioName(enteredResultsName))
  {
    msg <- paste(
      "The run ID ",
      enteredRunID,
      " and the name ",
      enteredResultsName,
      " are already taken. Please enter a different run ID and name."
    )
    shinyjs::info(msg)
    
  } else if (verifyResultsRunID(enteredRunID))
  {
    msg <- paste("The run ID ",
                 enteredRunID,
                 " is already taken. Please enter a different run ID.")
    shinyjs::info(msg)
    
  } else if (verifyResultsScenarioName(enteredResultsName))
  {
    msg <- paste("The name ",
                 enteredScenarioName,
                 " is already taken. Please enter a different name.")
    shinyjs::info(msg)
  } else
  {
    submit_imported_NameRunID(enteredRunID,
                              enteredResultsName,
                              input$importResults$datapath)
    
    output$textImportedResults <- renderText({
      paste(
        "The results with run ID ",
        enteredRunID,
        " and name ",
        enteredResultsName,
        " have been successfully uploaded to the app."
      )
    })
    
    updateCheckboxGroupInput(session,
                             "Check_Scenario_Names_Results",
                             choices = names(unlist(modelRuns, recursive = F)))
    
    updateCheckboxInput(session, inputId = "All_Results", value = FALSE)
    
    updateSelectInput(
      session,
      "selectRunID",
      choices = c("None Selected", as.list(runID)),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      inputId = "selectAssociatedScenario",
      choices = c("None Selected", as.list(names(modelRuns[[enteredRunID]]))),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      "selectResultsRunID",
      choices = c("None Selected", as.list(runID)),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      inputId = "selectResultsName",
      choices = c("None Selected", as.list(names(modelRuns[[enteredRunID]]))),
      selected = "None Selected"
    )
    
    updateSelectInput(
      session,
      "deleteResults",
      choices = c("None Selected", as.list(names(
        unlist(modelRuns, recursive = F)
      ))),
      selected = "None Selected"
    )
    
    shinyjs::show(id = "Results_Options")
    shinyjs::show(id = "HideSelectionRunID")
    shinyjs::show(id = "HideSelectionResultsRunId")
    
  }
  
})


################################################################################
# Functions used for the importing of simulation results.
################################################################################
extract_runID_scenarioName <- function(input_file)
{
  print(input_file)
  
  # Reads in the metadata worksheet of the excel file
  metaDataIn <- read_excel(input_file, sheet = "Metadata")
  
  # Extracts the imported RunID and scenarioName
  submittedRunID <<- as.character(subset(metaDataIn, Field == "Run ID", select = Value))
  
  submittedResultsName <<- as.character(subset(metaDataIn, Field == "Scenario Name", select = Value))
  
  # Need to check if importedRunID is in runID
  runID_Exists <<- submittedRunID %in% runID
  
  # Need to check if importedScenarioName is in scenario_names
  scenarioName_Exists <<- submittedResultsName %in% names(modelRuns[[submittedRunID]])
  # scenarioName_Exists <<- submittedResultsName %in% scenario_names
  
}

submit_results_name <- function(inputScenarioName, input_file)
{
  # Assign name of imported scenario to temporary variable
  submittedResultsName  <<- inputScenarioName
  
  # scenario_names <<- cbind(scenario_names, submittedResultsName)
  
  # Reads in the metadata worksheet of the excel file
  metaDataIn <- read_excel(input_file, sheet = "Metadata")
  
  # Extracts the Scenario description
  importedScenarioDesc <- as.character(subset(metaDataIn, Field == "Scenario Description", select = Value))
  
  # Once Scenario Name is submitted, append importedScenarioDesc to scenarioDescriptions list
  scenarioDescriptions[[submittedResultsName]] <<- importedScenarioDesc
  
  # Reads in ModelRunInfo worksheet
  modelRunInfoIn <<- as.data.frame(read_excel(input_file, sheet = "ModelRunInfo"))
  
  # Creates list space to store imported modelRunInfo
  modelRunInfo[[submittedRunID]] <<- list(modelRunParams = data.frame(),
                                          modelRunScenarios = c())
  
  # Adds modelRunInfo imported to modelRunInfo list
  modelRunInfo[[submittedRunID]][["modelRunParams"]] <<- modelRunInfoIn
  modelRunInfo[[submittedRunID]][["modelRunScenarios"]] <<- cbind(modelRunInfo[[submittedRunID]][["modelRunScenarios"]], submittedResultsName)
  
  # Reads in the modelRuns data from worksheet of the excel file
  dailySummaryIn <- as.data.frame(read_excel(input_file, sheet = "dailySummary"))
  midpointsIn <- unname(as.vector(t(
    read_excel(input_file, sheet = "midpoints")
  )))
  sizesIn <- as.list(unname(as.data.frame(t(
    read_excel(input_file, sheet = "sizes")
  ))))
  annualKernelIn <- unname(as.matrix(read_excel(input_file, sheet = "annualKernel")))
  
  # Once everything is read in, append to modelOutputsList
  
  modelRuns[[submittedRunID]][[submittedResultsName]][["dailySummary"]] <<- dailySummaryIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["midpoints"]] <<- midpointsIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["sizes"]] <<- sizesIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["cumulativeTransitionKernel"]] <<- annualKernelIn
  
}


submit_results_runID <- function(inputRunID, input_file)
{
  # Assign run ID of imported scenario to temporary variable
  submittedRunID <<- inputRunID
  
  runID <<- cbind(runID, submittedRunID)
  
  # Reads in the metadata worksheet of the excel file
  metaDataIn <- read_excel(input_file, sheet = "Metadata")
  
  # Extracts the Scenario description
  importedScenarioDesc <- as.character(subset(metaDataIn, Field == "Scenario Description", select = Value))
  
  # Once Scenario Name is submitted, append importedScenarioDesc to scenarioDescriptions list
  scenarioDescriptions[[submittedResultsName]] <<- importedScenarioDesc
  
  # Reads in ModelRunInfo worksheet
  modelRunInfoIn <<- as.data.frame(read_excel(input_file, sheet = "ModelRunInfo"))
  
  # Creates list space to store imported modelRunInfo
  modelRunInfo[[submittedRunID]] <<- list(modelRunParams = data.frame(),
                                          modelRunScenarios = c())
  
  # Adds modelRunInfo imported to modelRunInfo list
  modelRunInfo[[submittedRunID]][["modelRunParams"]] <<- modelRunInfoIn
  modelRunInfo[[submittedRunID]][["modelRunScenarios"]] <<- cbind(modelRunInfo[[submittedRunID]][["modelRunScenarios"]], submittedResultsName)
  
  # Reads in the modelRuns data from worksheet of the excel file
  dailySummaryIn <- as.data.frame(read_excel(input_file, sheet = "dailySummary"))
  midpointsIn <- unname(as.vector(t(
    read_excel(input_file, sheet = "midpoints")
  )))
  sizesIn <- as.list(unname(as.data.frame(t(
    read_excel(input_file, sheet = "sizes")
  ))))
  annualKernelIn <- unname(as.matrix(read_excel(input_file, sheet = "annualKernel")))
  
  # Once everything is read in, append to modelOutputsList
  
  modelRuns[[submittedRunID]][[submittedResultsName]][["dailySummary"]] <<- dailySummaryIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["midpoints"]] <<- midpointsIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["sizes"]] <<- sizesIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["cumulativeTransitionKernel"]] <<- annualKernelIn
  
}

submit_imported_NameRunID <- function(inputRunID,
                                      inputScenarioName,
                                      input_file)
{
  # Assign run ID of imported scenario to temporary variable
  submittedRunID <<- inputRunID
  
  runID <<- cbind(runID, submittedRunID)
  
  # Assign name of imported scenario to temporary variable
  submittedResultsName  <<- inputScenarioName
  
  # Reads in the metadata worksheet of the excel file
  metaDataIn <- read_excel(input_file, sheet = "Metadata")
  
  # Extracts the Scenario description
  importedScenarioDesc <- as.character(subset(metaDataIn, Field == "Scenario Description", select = Value))
  
  # Once Scenario Name is submitted, append importedScenarioDesc to scenarioDescriptions list
  scenarioDescriptions[[submittedResultsName]] <<- importedScenarioDesc
  
  # Reads in ModelRunInfo worksheet
  modelRunInfoIn <<- as.data.frame(read_excel(input_file, sheet = "ModelRunInfo"))
  
  # Creates list space to store imported modelRunInfo
  modelRunInfo[[submittedRunID]] <<- list(modelRunParams = data.frame(),
                                          modelRunScenarios = c())
  
  # Adds modelRunInfo imported to modelRunInfo list
  modelRunInfo[[submittedRunID]][["modelRunParams"]] <<- modelRunInfoIn
  modelRunInfo[[submittedRunID]][["modelRunScenarios"]] <<- cbind(modelRunInfo[[submittedRunID]][["modelRunScenarios"]], submittedResultsName)
  
  # Reads in the modelRuns data from worksheet of the excel file
  dailySummaryIn <- as.data.frame(read_excel(input_file, sheet = "dailySummary"))
  midpointsIn <- unname(as.vector(t(
    read_excel(input_file, sheet = "midpoints")
  )))
  sizesIn <- as.list(unname(as.data.frame(t(
    read_excel(input_file, sheet = "sizes")
  ))))
  annualKernelIn <- unname(as.matrix(read_excel(input_file, sheet = "annualKernel")))
  
  # Once everything is read in, append to modelOutputsList
  
  modelRuns[[submittedRunID]][[submittedResultsName]][["dailySummary"]] <<- dailySummaryIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["midpoints"]] <<- midpointsIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["sizes"]] <<- sizesIn
  modelRuns[[submittedRunID]][[submittedResultsName]][["cumulativeTransitionKernel"]] <<- annualKernelIn
  
}

verifyResultsScenarioName <- function(inputScenarioName)
{
  inputScenarioName %in% scenario_names
}

verifyResultsRunID <- function(inputRunID)
{
  inputRunID %in% runID
}

