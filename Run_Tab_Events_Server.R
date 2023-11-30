observeEvent(input$add_SimulationRun,
             {
               shinyjs::show(id = "Run_Scenarios_Options")
               shinyjs::hide(id = "Run_Parameters_Distributions")
               shinyjs::hide(id = "run_simulations_section")
               
               updateCheckboxGroupInput(session, "Check_Scenario_Names_Run",
                                        choices = as.list(scenario_names))
               
               updateCheckboxInput(session, 
                                   inputId = "All_Runs",
                                   value = FALSE)
               
               updateTextInput(session,
                               inputId = "runid",
                               value = "")
               
               output$text_runid <- NULL
               
               updateNumericInput(session,
                                  inputId = "initial_population",
                                  value = 100)
               
               updateNumericInput(session,
                                  inputId = "num_size_classes",
                                  value = 100)
               
               updateNumericInput(session,
                                  inputId = "solver_order",
                                  value = 3)
               
               updateSelectInput(session,
                                 inputId = "initial_distribution",
                                 selected = "None Selected")
               
               shinyjs::enable(id = "Check_Scenario_Names_Run")
               shinyjs::enable((id = "All_Runs"))
               shinyjs::enable(id = "runid")
               shinyjs::enable(id = "enter_runid")
               shinyjs::enable(id = "num_size_classes")
               shinyjs::enable(id = "solver_order")
               shinyjs::enable(id = "initial_population")
               shinyjs::enable(id = "initial_distribution")
               shinyjs::enable(id = "download_predetermined_dist")
               shinyjs::enable(id = "upload_predetermined_dist")
               shinyjs::enable(id = "run_simulations")
               
               # Delete temporarily created files.
               unlink(file.path(tempdir(), "*"))
             }
  
)


# This line of code limits the number of characters that the user can enter in the 
# run ID's textInput box to 5.
shinyjs::runjs("$('#runid').attr('maxlength', 5)")

####################################################################################################
# Run ID submission event.
####################################################################################################
observeEvent(input$enter_runid,
             {
               enteredRunID <- input$runid
               if (is.null(enteredRunID) || (trimws(enteredRunID) == ""))
               {
                 shinyjs::info("Input textbox is empty. Please enter a batch run ID.")
                 
               }else if (verifyRunID(enteredRunID))
               {
                 msg <- paste(enteredRunID,
                              " has been assigned before. Please enter a different run ID.")
                 shinyjs::info(msg)
                 
               }else
               {
                 enter_run_id(enteredRunID)
                 output$text_runid <- renderText(
                   {
                     paste("This run has been named ", enteredRunID, ".")
                   }
                 )
                 shinyjs::show(id = "Run_Parameters_Distributions")
               }
               
             }
)

########################################################################################################
#  Download Events
########################################################################################################

# Download predetermined initial distribution for running scenarios.
output$download_predetermined_dist <- downloadHandler(
  filename = function() {
    paste("Predetermined_Initial_Dist_", Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    template_file <- generate_PredeterminedDist_Template(input$num_size_classes)
    write.csv(template_file, file, row.names = FALSE)
  }
)

observeEvent(input$upload_predetermined_dist,
             {
               output$Predetermined_Initial_Distribution_out <- renderPlot(
                 {
                   assign_plot_Predetermined_Initial_Distribution(input$upload_predetermined_dist$datapath)
                   updateNumericInput(session,
                                      inputId = "num_size_classes",
                                      value = length(inputz_t_0))
                 }
               )
               shinyjs::show(id = "Predetermined_Initial_Distribution_Main")
               shinyjs::show(id = "run_simulations_section")
               shinyjs::disable(id = "num_size_classes")
             }
)

observeEvent(input$initial_distribution,
             {
               if (input$initial_distribution == "Uniform")
               {
                 shinyjs::show(id = "run_simulations_section")
                 shinyjs::hide(id = "Predetermined_Initial_Distribution_Main")
                 shinyjs::enable(id = "num_size_classes")

               }else if (input$initial_distribution == "None Selected")
               {
                 shinyjs::hide(id = "run_simulations_section")
                 shinyjs::hide(id = "Predetermined_Initial_Distribution_Main")
                 shinyjs::enable(id = "num_size_classes")

               }else if (input$initial_distribution == "Predetermined")
               {
                 shinyjs::hide(id = "run_simulations_section")
                 reset("upload_predetermined_dist")
                 shinyjs::disable(id = "num_size_classes")
               }
             },
             ignoreInit = TRUE
)

observeEvent(input$run_simulations,
  {
    if (is.null(input$Check_Scenario_Names_Run))
    {
      shinyjs::info("Error: no scenarios were selected. Please select one or more scenarios.")
      return(NULL)
    }
    
    icons <- paste(trimws(currentRunID), 
                   ".", 
                   trimws(input$Check_Scenario_Names_Run), 
                   sep = "",
                   collapse = ', ')
    show_modal_spinner(spin="fingerprint",
                       text=HTML(paste(" The following scenarios are running: ", icons, "",
                                       "Model runs can take up to 5 minutes each. An alert window will be created when runs are completed.",
                                       sep = '<br/>')))

    if (input$initial_distribution == 'Predetermined')
    {
      run_predetermined_dist_simulation(input$Check_Scenario_Names_Run, input$num_size_classes, input$solver_order, input$upload_predetermined_dist$datapath, input$upload_predetermined_dist$name)

    }else if (input$initial_distribution == 'Uniform')
    {
      run_uniform_dist_simulation(input$Check_Scenario_Names_Run, input$initial_population, input$num_size_classes, input$solver_order)
    }
    
    remove_modal_spinner()
    # removeModal(session)
    shinyjs::disable(id = "Check_Scenario_Names_Run")
    shinyjs::disable(id = "All_Runs")
    shinyjs::disable(id = "runid")
    shinyjs::disable(id = "enter_runid")
    shinyjs::disable(id = "num_size_classes")
    shinyjs::disable(id = "solver_order")
    shinyjs::disable(id = "initial_population")
    shinyjs::disable(id = "initial_distribution")
    shinyjs::disable(id = "download_predetermined_dist")
    shinyjs::disable(id = "upload_predetermined_dist")
    shinyjs::disable(id = "run_simulations")
    
    shinyjs::show(id = "Results_Options")
    shinyjs::show(id = "HideSelectionResultsRunId")
    shinyjs::show(id = "HideSelectionRunID")
    shinyjs::info("All simulations have completed running.")
    shinyjs::hide(id = "scenario_summary_results_main")
    shinyjs::hide(id = "dailyPopulation_out_Main")
    shinyjs::hide(id = "populationBiomass_out_Main")
    shinyjs::hide(id = "meanSize_out_Main")
    shinyjs::hide(id = "growthPotential_out_Main")
    shinyjs::hide(id = "transitionalKernel_out_Main")
    shinyjs::hide(id = "summaryMatrix_out_Main")
    
    updateCheckboxGroupInput(session, 
                             inputId = "Check_Scenario_Names_Results",
                             choices = names(unlist(modelRuns, recursive = F)),
                             selected = NULL)
    
    updateCheckboxInput(session, 
                        inputId = "All_Results",
                        value = FALSE)
    
    updateSelectInput(session, "selectRunID",
                      choices = c("None Selected", as.list(runID)),
                      selected = "None Selected")
    
    updateSelectInput(session, "selectResultsRunID",
                      choices = c("None Selected", as.list(runID)),
                      selected = "None Selected")
    
    updateSelectInput(session, "deleteResults",
                      choices = c("None Selected", as.list(names(unlist(modelRuns, recursive = F)))),
                      selected = "None Selected")
    
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
            for (i in 1:length(lr))
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

  }

)

observe({
  updateCheckboxGroupInput(session,
                           "Check_Scenario_Names_Run",
                           choices = as.list(scenario_names),
                           selected = if(input$All_Runs) choices = as.list(scenario_names))
})

observeEvent(input$Check_Scenario_Names_Run,
  {
    selectedScenarios <- input$Check_Scenario_Names_Run
    notSelected <- scenario_names[which((!names(modelOutputs) %in% selectedScenarios))]
    if (length(notSelected) > 0)
    {
      updateCheckboxGroupInput(session, inputId = "Check_Scenario_Names_Results",
                               choices = names(unlist(modelRuns, recursive = F)),
                               selected = NULL)
      
      updateCheckboxInput(session, 
                          inputId = "All_Results",
                          value = FALSE)

      subElement1 <- paste("#Check_Scenario_Names_Results input[value=", notSelected,"]")
      delay(1, shinyjs::disable(selector = subElement1))

      subElement2 <- paste("#Check_Scenario_Names_Results input[value=", selectedScenarios,"]")
      delay(1, shinyjs::enable(selector = subElement2))


    }else
    {
      updateCheckboxGroupInput(session, inputId = "Check_Scenario_Names_Results",
                               choices = names(unlist(modelRuns, recursive = F)),
                               selected = NULL)
      
      updateCheckboxInput(session, 
                          inputId = "All_Results",
                          value = FALSE)

      subElement2 <- paste("#Check_Scenario_Names_Results input[value=", selectedScenarios,"]")
      delay(1, shinyjs::enable(selector = subElement2))

    }
  },
  ignoreNULL = FALSE
)




