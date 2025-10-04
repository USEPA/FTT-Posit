################################################################################
#  Events associated with the deletion of scenarios.
################################################################################
observe({
  if (input$deleteScenario == "None Selected" ||
      input$deleteScenario == "")
  {
    shinyjs::hide(id = "DeleteScenarioButton")
  } else
  {
    shinyjs::show(id = "DeleteScenarioButton")
  }
})

observeEvent(input$Delete_Scenario, {
  inputScenarioToBeDeleted <- input$deleteScenario
  if (inputScenarioToBeDeleted  == "None Selected")
  {
    output$textMessageDeleteScenario <- renderText({
      paste(
        "Please select one of the scenarios from the drop-down menu.",
        "To close this window click the 'Close' button below."
      )
    })
    shinyjs::disable(id = "actionDeleteScenario")
  } else
  {
    output$textMessageDeleteScenario <- renderText({
      text1 <- paste("Are you sure you want to delete the ",
                     inputScenarioToBeDeleted,
                     " scenario?")
      paste(
        text1,
        "Click 'Delete and Confirm' to delete the chosen scenario.",
        "Click the 'Close' button or 'X' (top right corner) to exit this window.",
        sep = "\n"
      )
    })
    
    shinyjs::enable(id = "actionDeleteScenario")
    
  }
  
})

observeEvent(input$actionDeleteScenario, {
  delete_scenario(input$deleteScenario)
  
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
                           "Check_Scenario_Names_Run",
                           choices = as.list(scenario_names))
  
  updateCheckboxInput(session, inputId = "All_Runs", value = FALSE)
  
  updateCheckboxGroupInput(session, "Check_Scenario_Names", choices = as.list(scenario_names))
  
  shinyjs::disable(id = "actionDeleteScenario")
  
  if (length(scenario_names) == 0)
  {
    shinyjs::hide(id = "Visualization_GRS")
    shinyjs::hide(id = "Visualization_SPB")
    shinyjs::hide(id = "Visualization_SDEC")
    shinyjs::hide(id = "Show_SDEC")
    shinyjs::hide(id = "Show_GP")
    shinyjs::hide(id = "Growth_out_Main")
    shinyjs::hide(id = "Survival_out_Main")
    shinyjs::hide(id = "Reproduction_out_Main")
    shinyjs::hide(id = "SpawningProb_out_Main")
    shinyjs::hide(id = "SurvivalDecrement_out_Main")
    shinyjs::hide(id = "GrowthPercents_out_Main")
    shinyjs::hide(id = "ExposureConcentration_out_Main")
    shinyjs::hide(id = "HideDeleteScenarioSelection")
    shinyjs::hide(id = "HideExportScenarioButton")
    shinyjs::hide(id = "ExportScenarioButton")
    shinyjs::hide(id = "DownloadScenarioButton")
    shinyjs::hide(id = "HideAddStressorScenarioButton")
    shinyjs::hide(id = "underlying_scenario")
    
    shinyjs::hide(id = "BuildBaselineScenario")
    shinyjs::hide(id = "base_name")
    shinyjs::hide(id = "options")
    shinyjs::hide(id = "scenario_options")
    shinyjs::hide(id = "baseline_visualize")
    shinyjs::hide(id = "life_history_table_main")
    shinyjs::hide(id = "Spawning_Prob_main")
    
    shinyjs::hide(id = "baseline_selection_name")
    shinyjs::hide(id = "underlying_scenario")
    shinyjs::hide(id = "stressorType")
    shinyjs::hide(id = "Winter_Options")
    shinyjs::hide(id = "Density_Dependence_Options")
    shinyjs::hide(id = "predetermined_growth_effects")
    shinyjs::hide(id = "upload_new_exposure_concentration")
    shinyjs::hide(id = "exposure_conc")
    shinyjs::hide(id = "chemicalEffectType")
    shinyjs::hide(id = "chemicalID")
    shinyjs::hide(id = "tcem")
    shinyjs::hide(id = "predetermined_effects")
    shinyjs::hide(id = "guts")
    shinyjs::hide(id = "stressor_verification")
    shinyjs::hide(id = "stressor_table_main")
    shinyjs::hide(id = "Exposure_Concentration_Main")
    shinyjs::hide(id = "TCEM_Main")
    shinyjs::hide(id = "Survival_Decrement_Main")
    shinyjs::hide(id = "Growth_Percent_Main")
    shinyjs::hide(id = "Winter_Survival_Main")
    shinyjs::hide(id = "Predetermined_Initial_Distribution_Main")
    shinyjs::hide(id = "Summary_Table_Main")
    shinyjs::hide(id = "HideAddSimulationRunButton")
    shinyjs::hide(id = "Run_Scenarios_Options")
    shinyjs::hide(id = "Run_Parameters_Distributions")
    shinyjs::hide(id = "run_simulations_section")
    output$Summary_Table_out <- NULL
    
    shinyjs::hide(id = "HideDeleteScenarioSelection")
    shinyjs::hide(id = "DeleteScenarioButton")
    shinyjs::hide(id = "HideExportScenarioButton")
    shinyjs::hide(id = "ExportScenarioButton")
    shinyjs::hide(id = "DownloadScenarioButton")
  }
  
})


################################################################################
#  Functions used for the deletion of scenarios.
################################################################################
delete_scenario <- function(inputScenarioToDelete)
{
  # Remove scenario from parameter list
  parameters[which(names(parameters) %in% inputScenarioToDelete)] <<- NULL
  
  # Remove scenario from list of scenario Names
  scenario_names <<- scenario_names[-which(scenario_names == inputScenarioToDelete)]
}