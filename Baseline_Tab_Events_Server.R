####################################################################################################
# Build baseline scenario
####################################################################################################
observeEvent(input$add_BaselineScenario,
             {
               shinyjs::show(id = "BuildBaselineScenario")
               shinyjs::hide(id = "base_name")
               
               updateTextInput(session, "currentScenarioName", value = "Baseline")
               updateTextAreaInput(session, inputId = "textBaselineDescription", value = "")
               output$text_basename <- NULL
               output$text_load_fhm <- NULL
               output$text_spawning_alg <- NULL
               updateSelectInput(session, "species",
                                 selected = "None Selected")
               
               shinyjs::enable(id = "currentScenarioName")
               shinyjs::enable(id = "textBaselineDescription")
               shinyjs::enable(id = "submit_name")
               shinyjs::enable(id = "load_fhm_parameters")
               shinyjs::enable(id = "species")
               shinyjs::enable(id = "upload_history_pars")
               shinyjs::enable(id = "download_history_parameters")
               shinyjs::enable(id = "spawn_algorithm")
               shinyBS::addTooltip(session,
                                   "spawn_algorithm", 
                                   "A spawning algorithm generates daily spawning probabilities based on the iteroparous or semelparous life history parameters supplied",
                                   "right", 
                                   options = list(container = "body"))
               bs_spawning_alg_button <- bsTooltip("spawn_algorithm",
                                                   "A spawning algorithm generates daily spawning probabilities based on the iteroparous or semelparous life history parameters supplied",
                                                   "right", 
                                                   options = list(container = "body"))
             })

###################################################################################################
# Submit baseline name
###################################################################################################
observeEvent(
  input$submit_name,
  {
    if (is.null(input$currentScenarioName) || (trimws(input$currentScenarioName) == ""))
    {
      shinyjs::info("Input textbox is empty. Please enter a name.")
    }else if (verifyScenarioName(input$currentScenarioName))
    {
      msg <- paste(input$currentScenarioName,
                   " has been assigned before. Please enter a different name.")
      shinyjs::info(msg)
    }else
    {
      TemporaryBaselineScenarioName <<- input$currentScenarioName
      # enter_baseline_scenario_name(input$currentScenarioName, input$textBaselineDescription)
      # scenario_name <- input$currentScenarioName
      output$text_basename <- renderText(
        {
          paste("This scenario has been named '", TemporaryBaselineScenarioName, "'.",sep="")
        }
      )
      shinyjs::show(id = "base_name")

      updateSelectInput(session, "species", selected = "None Selected")

#      updateSelectInput(session, "baselines",
#                        choices = c("None Selected", scenario_names),
#                        selected = "None Selected")
      
#      updateSelectInput(session, "downloadScenario",
#                        choices = c("None Selected", scenario_names),
#                        selected = "None Selected")
      
#      updateSelectInput(session, "deleteScenario",
#                        choices = c("None Selected", scenario_names),
#                        selected = "None Selected")

#      updateSelectInput(session, inputId = "stressor_type",
#                        selected = "None Selected")#

#      updateCheckboxGroupInput(session, "Check_Scenario_Names",
#                               choices = as.list(scenario_names))

#      updateCheckboxGroupInput(session, "Check_Scenario_Names_Run",
#                               choices = as.list(scenario_names))


#      subElement1 <- paste("#Check_Scenario_Names_Results input[value=", scenario_names,"]")
#      delay(1, shinyjs::disable(selector = subElement1))

#      updateTextInput(session, inputId = "stressorName", value = "")

#      output$text_load_fhm <- NULL

#      output$text_stressorName <- NULL
      
#      output$text_runid <- NULL
    }
    shinyjs::hide(id = "options")
    shinyjs::hide(id = "scenario_options")
    shinyjs::hide(id = "baseline_visualize")
    shinyjs::hide(id = "life_history_table_main")
    shinyjs::hide(id = "Spawning_Prob_main")
    shinyjs::hide(id = "baseline_selection_name")
    shinyjs::hide(id = "exposure_conc")
    shinyjs::hide(id = "chemicalEffectType")
    shinyjs::hide(id = "chemicalID")
    shinyjs::hide(id = "tcem")
    shinyjs::hide(id = "Winter_Options")
    shinyjs::hide(id = "predetermined_effects")
    shinyjs::hide(id = "guts")
    shinyjs::hide(id = "stressorType")
    shinyjs::hide(id = "stressor_verification")
    shinyjs::hide(id = "stressor_table_main")
    shinyjs::hide(id = "Exposure_Concentration_Main")
    shinyjs::hide(id = "TCEM_Main")
    shinyjs::hide(id = "Survival_Decrement_Main")
    shinyjs::hide(id = "Winter_Survival_Main")
  }
)

observeEvent(input$baselines,
  {

    chosen_scenario_name <- input$baselines
    if("survival_decrement" %in% colnames(parameters[[chosen_scenario_name]]))
    {
      output$underlying_scenario <- renderText(
        {
          paste("If a chemical stressor is chosen to overlay on a chemical stressor scenario,
                the underlying chemical stressor effects will be overwritten.")
        }
      )
    }

  }
)

####################################################################################################
# Display Tables
####################################################################################################
observeEvent(input$display_LifeHistory,
             {
               output$life_history_table <- DT::renderDataTable({
                 if (input$species == 'New')
                 {
                   file_history <- input$upload_history_pars$datapath
                   if (is.null(file_history)){
                     return()
                   }
                 }
                 return_history_pars(CurrentBaselineScenarioName)
               },  options = list(scrollX = TRUE))
               shinyjs::show(id = "life_history_table_main")
             }
)


####################################################################################################
# Download/Upload Events
####################################################################################################
observeEvent(input$upload_history_pars,
             {
               assign_history_pars(TemporaryBaselineScenarioName, input$upload_history_pars$datapath)
               label_str <- paste("View complete ", TemporaryBaselineScenarioName, " parameters")
               updateActionButton(session, "display_LifeHistory", label = label_str)
             }
)

observeEvent(input$upload_scenario_pars,
             {
               assign_scenario_pars(TemporaryBaselineScenarioName, input$upload_scenario_pars$name)
             }
)

# observeEvent(input$download_history_parameters,
#              {
#                template_file <- LifeHistory_Parameters()
#                # shell.exec(template_file)
#                file.show(template_file)
#              }
# 
# )

# Download life history parameters template for baseline scenario.
output$download_history_parameters <- downloadHandler(
  filename = function() {
    paste("lifeHistoryTemplate_", Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    template_file <- LifeHistory_Parameters()
    write.csv(template_file, file, row.names = FALSE)
  }
)

output$download_baseline_parameters_button <- renderUI(
  {
    TextVariable <- paste("Download complete ", 
                          input$currentScenarioName, 
                          " scenario parameters set")
    downloadButton(outputId = "download_baseline_parameters",
                   label = TextVariable,
                   #width = '250px'
                   style="color: #fff; font-size: 75%; background-color: gray; border-color: #2e6da4")
  }
)

# Downloadable csv of selected dataset
output$download_baseline_parameters <- downloadHandler(
  filename = function() {
    paste("baseline_scenario_parameters-", Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    df_params <- parameters[[TemporaryBaselineScenarioName]]
    write.csv(df_params, file, row.names = FALSE)
  }
)


####################################################################################################
# Spawning Algorithm
####################################################################################################
observeEvent(input$spawn_algorithm,
             {
               enter_baseline_scenario_name(TemporaryBaselineScenarioName, input$textBaselineDescription)
               
               run_spawning_algorithm(TemporaryBaselineScenarioName)

               output$text_spawning_alg <- renderText(
                 {
                   paste("Spawning algorithm for '", TemporaryBaselineScenarioName, "' has completed.", sep="")
                 }
               )

               output$Spawning_Prob_out <- renderPlot(
                 {
                   plot_spawning_probabilities(TemporaryBaselineScenarioName)
                 }
               )

               updateSelectInput(session, "baselines",
                                 choices = c("None Selected", scenario_names),
                                 selected = "None Selected")
               
               updateSelectInput(session, "downloadScenario",
                                 choices = c("None Selected", scenario_names),
                                 selected = "None Selected")
               
               updateSelectInput(session, "deleteScenario",
                                 choices = c("None Selected", scenario_names),
                                 selected = "None Selected")
               
               updateSelectInput(session, inputId = "stressor_type",
                                 selected = "None Selected")
               
               updateCheckboxGroupInput(session, "Check_Scenario_Names",
                                        choices = as.list(scenario_names))
               
               # updateCheckboxGroupInput(session, "Check_Scenario_Names_Run",
               #                          choices = as.list(scenario_names))
               
               
               subElement1 <- paste("#Check_Scenario_Names_Results input[value=", scenario_names,"]")
               delay(1, shinyjs::disable(selector = subElement1))
               
               updateTextInput(session, inputId = "stressorName", value = "")
               
               output$text_load_fhm <- NULL
               
               output$text_stressorName <- NULL
               
               output$text_runid <- NULL
               
               shinyjs::show(id = "Spawning_Prob_main")

               shinyjs::show(id = "baseline_visualize")

               shinyjs::show(id = "Visualization_GRS")

               shinyjs::show(id = "Visualization_SPB")
               
               shinyjs::show(id = "scenario_options")
               shinyjs::show(id = "HideExportScenarioButton")
               shinyjs::show(id = "HideDeleteScenarioSelection")
               shinyjs::show(id = "HideAddStressorScenarioButton")
               shinyjs::show(id = "HideAddSimulationRunButton")
               
               shinyjs::disable(id = "currentScenarioName")
               shinyjs::disable(id = "textBaselineDescription")
               shinyjs::disable(id = "submit_name")
               shinyjs::disable(id = "load_fhm_parameters")
               shinyjs::disable(id = "species")
               shinyjs::disable(id = "upload_history_pars")
               shinyjs::disable(id = "download_history_parameters")
               shinyjs::disable(id = "spawn_algorithm")
               shinyBS::removeTooltip(session, "spawn_algorithm")
               
               output$textMessageResetApp <- renderText(
                 {
                   text1 <- paste("The following scenarios and runs will be deleted upon clicking the Reset App button.")
                   ns <- length(scenario_names)
                   nr <- length(runID)
                   text2 <- ""
                   text3 <- ""
                   if (ns > 0 || nr > 0)
                   {
                     if (ns > 0)
                     {
                       for (i in 1:ns)
                       {
                         if (i == 1)
                         {
                           text2 <- paste("Scenarios: ", scenario_names[1])
                         }else
                         {
                           text2 <- paste(text2, ",", scenario_names[i])
                         }
                         
                       }
                     }
                     
                     if (nr > 0)
                     {
                       lr <- names(unlist(modelRuns, recursive = F))
                       for (i in 1:nr)
                       {
                         if (i == 1)
                         {
                           text3 <- paste("Runs: ", lr[1])
                         }else
                         {
                           text3 <- paste(text3, ",", lr[i])
                         }
                         
                       }
                     }
                     
                     paste(text1, text2, text3, sep = "\n")
                   }
                   
                 }
                 
               )
               
               showModal(modalDialog(div(paste("The ", CurrentBaselineScenarioName," scenario is now complete.", sep=""), 
                                         style="font-size:200%"),
                                     size = "l",
                                     footer = modalButton(div("Close",style="font-size:160%"))), session)

             }

)


####################################################################################################
# Export Events
####################################################################################################
observeEvent(input$export_baseline,
             {
               export_baseline_parameters(TemporaryBaselineScenarioName)
               shinyjs::info("Exported baseline parameters to CSV file.")
             }
)

####################################################################################################
# Load/store parameters
####################################################################################################
observeEvent(input$load_fhm_parameters,
             {
               load_fhm_parameters(TemporaryBaselineScenarioName, input$species)
               output$text_load_fhm <- renderText(
                 {
                   paste("Fathead Minnow parameters have been loaded into memory.")
                 }
               )
               label_str <- paste("View complete ", TemporaryBaselineScenarioName, " parameters")
               updateActionButton(session, "display_LifeHistory", label = label_str)
#               shinyjs::show(id = "HideExportScenarioButton")
             }
)

observeEvent(input$set_parameters,
             {
               set_all_parameters(TemporaryBaselineScenarioName)
               output$text_set_parameters <- renderText(
                 {
                   paste("All parameters have been stored in the code.")
                 }
               )
#               updateSelectInput(session, "baselines",
#                                 choices = c("None Selected", scenario_names))
             }
)

# Show/Hide events associated with the baseline scenario tab.
observe({
  if (input$species == "None Selected")
  {
    shinyjs::hide(id ="options")
    shinyjs::hide(id = "scenario_options")
    shinyjs::hide(id = "life_history_table_main")
    shinyjs::hide(id = "Spawning_Prob_main")
    shinyjs::hide(id = "baseline_visualize")
  }

})

observe(
  {
    if (input$species == "Fathead Minnow")
    {
      output$text_load_fhm <- NULL
      shinyjs::show(id ="options")
      shinyjs::hide(id = "scenario_options")
      shinyjs::hide(id = "life_history_table_main")
      shinyjs::hide(id = "Spawning_Prob_main")
      shinyjs::hide(id = "baseline_visualize")
    }
  }
)

observe(
  {
    if (input$species == "New")
    {
      reset("upload_history_pars")
      shinyjs::show(id ="options")
      shinyjs::hide(id = "scenario_options")
      shinyjs::hide(id = "life_history_table_main")
      shinyjs::hide(id = "Spawning_Prob_main")
      shinyjs::hide(id = "baseline_visualize")
    }
  }
)


#observe({
#  if (input$baselines != "None Selected" && input$baselines != "")
#  {
#    shinyjs::hide(id ="baseline_selection_name")
#  }else
#  {
#    shinyjs::hide(id = "baseline_selection_name")
#  }
#})

observeEvent(input$load_fhm_parameters,
  {
    shinyjs::show(id = "scenario_options")
    shinyjs::hide(id = "baseline_visualize")
#    shinyjs::show(id = "HideExportScenarioButton")
#    shinyjs::show(id = "HideDeleteScenarioSelection")
#    shinyjs::show(id = "HideAddStressorScenarioButton")
#    shinyjs::show(id = "HideAddSimulationRunButton")
  }
)

observeEvent(input$upload_history_pars,
  {
    shinyjs::show(id = "scenario_options")
    shinyjs::hide(id = "baseline_visualize")
#    shinyjs::show(id = "HideExportScenarioButton")
#    shinyjs::show(id = "HideDeleteScenarioSelection")
#    shinyjs::show(id = "HideAddStressorScenarioButton")
#    shinyjs::show(id = "HideAddSimulationRunButton")
  }
)

####################################################################################################
#  Hyperlink to a new tab
####################################################################################################
observeEvent(input$hyperlink_newtab,
             {
               newtab <- "Build a Stressor Scenario"
               updateTabItems(session, "tabsetPanel_scenarios", newtab)
             }
)

observeEvent(input$hyperlink_visualization_newtab,
             {
               newtab <- "Visualize Scenarios"
               updateNavbarPage(session, "fish_toxicity_app", newtab)
             }
)

observeEvent(input$hyperlink_run_newtab,
  {
    newtab <- "Run Scenarios"
    updateNavbarPage(session, "fish_toxicity_app", newtab)
  }
)
