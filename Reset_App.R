observeEvent(input$reset_clear_app,
             {
               # Delete all scenarios that are currently stored in memory.
               ns <- length(scenario_names)
               if (ns > 0)
               {
                 for (i in 1:ns)
                 {
                   delete_scenario(scenario_names[i])
                 }
               }
               
               updateTextInput(session, "currentScenarioName", value = "Baseline")
               updateTextAreaInput(session, inputId = "textBaselineDescription", value = "")
               output$text_load_fhm <- NULL
               
               updateSelectInput(session, "baselines",
                                 choices = "")
               
               updateSelectInput(session, "downloadScenario",
                                 choices = "")
               
               updateSelectInput(session, "deleteScenario",
                                 choices = "")
               
               updateCheckboxGroupInput(session, "Check_Scenario_Names_Run",
                                        choices = "")
               
               updateCheckboxInput(session, 
                                   inputId = "All_Runs",
                                   value = FALSE)
               
               updateCheckboxGroupInput(session, "Check_Scenario_Names",
                                        choices = "")
               
               shinyjs::hide(id = "All")
               shinyjs::hide(id = "Visualization_GRS")
               shinyjs::hide(id = "Visualization_SPB")
               shinyjs::hide(id = "Visualization_SDEC")
               shinyjs::hide(id = "Show_SDEC")
               shinyjs::hide(id = "Show_GP")
               shinyjs::hide(id = "Species_Growth_out_Main")
               shinyjs::hide(id = "Species_Growth_Trajectory_out_Main")
               shinyjs::hide(id = "Species_Survival_Trajectory_out_Main")
               shinyjs::hide(id = "Species_Length_Mass_out_Main")
               shinyjs::hide(id = "Species_Survival_out_Main")
               shinyjs::hide(id = "Species_Reproduction_out_Main")
               shinyjs::hide(id = "Growth_out_Main")
               shinyjs::hide(id = "Survival_out_Main")
               shinyjs::hide(id = "Reproduction_out_Main")
               shinyjs::hide(id = "SpawningProb_out_Main")
               shinyjs::hide(id = "SurvivalDecrement_out_Main")
               shinyjs::hide(id = "GrowthPercents_out_Main")
               shinyjs::hide(id = "ExposureConcentration_out_Main")
               
               shinyjs::hide(id = "BuildBaselineScenario")
               shinyjs::hide(id = "base_name")
               shinyjs::hide(id = "options")
               shinyjs::hide(id = "scenario_options")
               shinyjs::hide(id = "baseline_visualize")
               shinyjs::hide(id = "life_history_table_main")
               shinyjs::hide(id = "Spawning_Prob_main")
               
               shinyjs::hide(id = "HideAddStressorScenarioButton")
               shinyjs::hide(id = "underlying_scenario")
               shinyjs::hide(id = "stressorType")
               shinyjs::hide(id = "stressorNameDescription")
               
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
               shinyjs::hide(id = "run_simulations_section")
               output$Summary_Table_out <- NULL
               
               shinyjs::hide(id = "HideDeleteScenarioSelection")
               shinyjs::hide(id = "DeleteScenarioButton")
               shinyjs::hide(id = "HideExportScenarioButton")
               shinyjs::hide(id = "ExportScenarioButton")
               shinyjs::hide(id = "DownloadScenarioButton")
               
               shinyjs::hide(id = "ImportScenarioButton")
               output$textImportedScenario <- NULL
               
               # Delete all run jobs that are currently stored in memory.
               nr <- length(runID)
               if (nr > 0)
               {
                 for (i in 1:nr)
                 {
                   nsr <- length(names(modelRuns[[runID[i]]]))
                   snames <- names(modelRuns[[runID[i]]])
                   for (j in 1:nsr)
                   {
                     delete_Results(runID[i], snames[j])
                   }
                 }
               }
               
               
               updateCheckboxGroupInput(session, "Check_Scenario_Names_Results",
                                        choices = "")
               
               summaryMatrix_flag <- FALSE
               
               updateCheckboxInput(session, 
                                   inputId = "All_Results",
                                   value = FALSE)
               
               updateSelectInput(session, "downloadResults",
                                 choices = "")
               
               updateSelectInput(session, "selectResultsName",
                                 choices = "")
               
               updateSelectInput(session, "selectResultsRunID",
                                 choices = "")
               
               updateSelectInput(session, "selectRunID",
                                 choices = "")
               
               updateSelectInput(session, "selectAssociatedScenario",
                                 choices = "")
               
               shinyjs::hide(id = "Results_Options")
               shinyjs::hide(id = "scenario_summary_results_main")
               shinyjs::hide(id = "dailyPopulation_out_Main")
               shinyjs::hide(id = "populationBiomass_out_Main")
               shinyjs::hide(id = "meanSize_out_Main")
               shinyjs::hide(id = "growthPotential_out_Main")
               shinyjs::hide(id = "transitionalKernel_out_Main")
               shinyjs::hide(id = "summaryMatrix_out_Main")
               
               shinyjs::hide(id = "HideAddSimulationRunButton")
               shinyjs::hide(id = "Run_Scenarios_Options")
               shinyjs::hide(id = "Run_Parameters_Distributions")
               shinyjs::hide(id = "run_simulations_section")
               shinyjs::hide(id = "Predetermined_Initial_Distribution_Main")
               
               shinyjs::hide(id = "HideSelectionRunID")
               shinyjs::hide(id = "AssociatedScenarioButton")
               shinyjs::hide(id = "DownloadResultsButton")
               
               shinyjs::hide(id = "Imported_Results_RunID")
               shinyjs::hide(id = "Imported_Results_ScenarioName")
               shinyjs::hide(id = "Imported_Results_NameRunID")
               
               shinyjs::hide(id = "HideSelectionResultsRunId")
               shinyjs::hide(id = "ResultsNameButton")
               shinyjs::hide(id = "DeleteResultsButton")
               
               if (ns > 0 || nr > 0)
               {
                 showModal(modalDialog(div(paste("The app has been reset to its default state. All scenarios and runs have been deleted.", sep=""), 
                                           style="font-size:200%"),
                                       size = "l",
                                       footer = modalButton(div("Close",style="font-size:160%"))), session)
               }else
               {
                 showModal(modalDialog(div(paste("The app is already in its default state. No scenarios or runs are currently stored in memory.", sep=""), 
                                           style="font-size:200%"),
                                       size = "l",
                                       footer = modalButton(div("Close",style="font-size:160%"))), session)
               }
              
               
               output$textMessageResetApp <- NULL
             }
)

