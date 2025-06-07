####################################################################################################
# Build baseline scenario
####################################################################################################
observeEvent(input$add_BaselineScenario,
             {
               shinyjs::show(id = "BuildBaselineScenario")
               shinyjs::show(id = "base_name")
               
               updateTextInput(session, "currentScenarioName", value = "")
               updateTextAreaInput(session, inputId = "textBaselineDescription", value = "")
               output$text_load_fhm <- NULL
               updateSelectInput(session, "species",
                                 selected = "None Selected")
               updateSwitchInput(session, 
                                 inputId = "display_SpeciesParameters",
                                 value = FALSE)
               updateSwitchInput(session, 
                                 inputId = "display_LifeHistory",
                                 value = FALSE)
               
               updateSwitchInput(session,
                                 inputId = "plot_all_on_off",
                                 value = FALSE)
               updateSwitchInput(session,
                                 inputId = "plot_clear_species_growth",
                                 value = FALSE)
               updateSwitchInput(session,
                                 inputId = "plot_clear_species_growth_trajectory",
                                 value = FALSE)
               updateSwitchInput(session,
                                 inputId = "plot_clear_species_survival_trajectory",
                                 value = FALSE)
               updateSwitchInput(session,
                                 inputId = "plot_clear_species_length_mass",
                                 value = FALSE)
               updateSwitchInput(session,
                                 inputId = "plot_clear_species_survival",
                                 value = FALSE)
               updateSwitchInput(session,
                                 inputId = "plot_clear_species_reproduction",
                                 value = FALSE)
               
               shinyjs::hide(id = "Species_Growth_out_Main")
               shinyjs::hide(id = "Species_Growth_Trajectory_out_Main")
               shinyjs::hide(id = "Species_Survival_Trajectory_out_Main")
               shinyjs::hide(id = "Species_Length_Mass_out_Main")
               shinyjs::hide(id = "Species_Survival_out_Main")
               shinyjs::hide(id = "Species_Reproduction_out_Main")
               
               shinyjs::enable(id = "currentScenarioName")
               shinyjs::enable(id = "textBaselineDescription")
               # shinyjs::enable(id = "submit_name")
               shinyjs::enable(id = "load_fhm_parameters")
               shinyjs::enable(id = "species")
               # shinyjs::enable(id = "upload_history_pars")
               # shinyjs::enable(id = "download_history_parameters")
               # shinyjs::enable(id = "show_species_profile_modal")
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
      CurrentBaselineScenarioName <<- input$currentScenarioName
      # enter_baseline_scenario_name(input$currentScenarioName, input$textBaselineDescription)
      # scenario_name <- input$currentScenarioName
      # output$text_basename <- renderText(
      #   {
      #     paste("This scenario has been named '", TemporaryBaselineScenarioName, "'.",sep="")
      #   }
      # )
      shinyjs::show(id = "base_name")

      updateSelectInput(session, "species", selected = "None Selected")

    }
    shinyjs::hide(id = "options")
    shinyjs::hide(id = "scenario_options")
    shinyjs::hide(id = "baseline_visualize")
    shinyjs::hide(id = "life_history_table_main")
    shinyjs::hide(id = "Spawning_Prob_main")
    shinyjs::hide(id = "species_profile_html")
    shinyjs::hide(id = "baseline_selection_name")
    shinyjs::hide(id = "upload_new_exposure_concentration")
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
    shinyjs::hide(id = "species_parameters_table_main")
    shinyjs::hide(id = "Species_Growth_out_Main")
    shinyjs::hide(id = "Species_Growth_Trajectory_out_Main")
    shinyjs::hide(id = "Species_Survival_Trajectory_out_Main")
    shinyjs::hide(id = "Species_Length_Mass_out_Main")
    shinyjs::hide(id = "Species_Survival_out_Main")
    shinyjs::hide(id = "Species_Reproduction_out_Main")
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
# observeEvent(input$display_LifeHistory,
#              {
#                output$life_history_table <- DT::renderDataTable({
#                  if (input$species == 'New')
#                  {
#                    file_history <- input$upload_history_pars$datapath
#                    if (is.null(file_history)){
#                      return()
#                    }
#                  }
#                  return_history_pars(CurrentBaselineScenarioName)
#                },  options = list(scrollX = TRUE))
#                shinyjs::show(id = "life_history_table_main")
#              }
# )
observeEvent(input$display_SpeciesParameters,
             {
               if (input$display_SpeciesParameters)
               {
                 output$species_parameters_table <- DT::renderDataTable({
                   return_species_pars(CurrentSpeciesName)
                 }, options = list(pageLength = 25))
                 shinyjs::show("species_parameters_table_main")
               }else
               {
                 shinyjs::hide("species_parameters_table_main")
               }
             },
             ignoreInit = TRUE
)

observeEvent(input$display_LifeHistory,
             {
               if (input$display_LifeHistory)
               {
                 output$life_history_table <- DT::renderDataTable({
                   if (input$species == 'New')
                   {
                     file_history <- input$upload_history_pars$datapath
                     
                     shinyjs::hide(id = "Species_Growth_out_Main")
                     shinyjs::hide(id = "Species_Growth_Trajectory_out_Main")
                     shinyjs::hide(id = "Species_Survival_Trajectory_out_Main")
                     shinyjs::hide(id = "Species_Length_Mass_out_Main")
                     shinyjs::hide(id = "Species_Survival_out_Main")
                     shinyjs::hide(id = "Species_Reproduction_out_Main")
                     
                     updateSwitchInput(session,
                                       inputId = "plot_all_on_off",
                                       value = FALSE)
                     updateSwitchInput(session,
                                       inputId = "plot_clear_species_growth",
                                       value = FALSE)
                     updateSwitchInput(session,
                                       inputId = "plot_clear_species_growth_trajectory",
                                       value = FALSE)
                     updateSwitchInput(session,
                                       inputId = "plot_clear_species_survival_trajectory",
                                       value = FALSE)
                     updateSwitchInput(session,
                                       inputId = "plot_clear_species_length_mass",
                                       value = FALSE)
                     updateSwitchInput(session,
                                       inputId = "plot_clear_species_survival",
                                       value = FALSE)
                     updateSwitchInput(session,
                                       inputId = "plot_clear_species_reproduction",
                                       value = FALSE)
                     if (is.null(file_history)){
                       return()
                     }
                   }
                   return_history_pars(CurrentBaselineScenarioName)
                 },  options = list(scrollX = TRUE))
                 shinyjs::show(id = "life_history_table_main")
               }else
               {
                 shinyjs::hide(id = "life_history_table_main")
               }
               
             },
             ignoreInit = TRUE)


####################################################################################################
# Species-specific plots
####################################################################################################
# All on/off switch
observeEvent(input$plot_all_on_off,
             {
               if (input$plot_all_on_off)
               {
                 if (input$species != "New")
                 {
                   updateSwitchInput(session,
                                     inputId = "plot_clear_species_growth",
                                     value = TRUE)
                   updateSwitchInput(session,
                                     inputId = "plot_clear_species_growth_trajectory",
                                     value = TRUE)
                   updateSwitchInput(session,
                                     inputId = "plot_clear_species_survival_trajectory",
                                     value = TRUE)
                   updateSwitchInput(session,
                                     inputId = "plot_clear_species_length_mass",
                                     value = TRUE)
                   updateSwitchInput(session,
                                     inputId = "plot_clear_species_survival",
                                     value = TRUE)
                   updateSwitchInput(session,
                                     inputId = "plot_clear_species_reproduction",
                                     value = TRUE)
                 }else
                 {
                   updateSwitchInput(session,
                                     inputId = "plot_clear_species_growth",
                                     value = FALSE)
                   updateSwitchInput(session,
                                     inputId = "plot_clear_species_growth_trajectory",
                                     value = FALSE)
                   updateSwitchInput(session,
                                     inputId = "plot_clear_species_survival_trajectory",
                                     value = FALSE)
                   updateSwitchInput(session,
                                     inputId = "plot_clear_species_length_mass",
                                     value = FALSE)
                   updateSwitchInput(session,
                                     inputId = "plot_clear_species_survival",
                                     value = FALSE)
                   updateSwitchInput(session,
                                     inputId = "plot_clear_species_reproduction",
                                     value = FALSE)
                 }
               }else
               {
                 updateSwitchInput(session,
                                   inputId = "plot_clear_species_growth",
                                   value = FALSE)
                 updateSwitchInput(session,
                                   inputId = "plot_clear_species_growth_trajectory",
                                   value = FALSE)
                 updateSwitchInput(session,
                                   inputId = "plot_clear_species_survival_trajectory",
                                   value = FALSE)
                 updateSwitchInput(session,
                                   inputId = "plot_clear_species_length_mass",
                                   value = FALSE)
                 updateSwitchInput(session,
                                   inputId = "plot_clear_species_survival",
                                   value = FALSE)
                 updateSwitchInput(session,
                                   inputId = "plot_clear_species_reproduction",
                                   value = FALSE)
               }
             }
)

# Species growth
observeEvent(input$plot_clear_species_growth,
             {
               if (input$plot_clear_species_growth)
               {
                 if (input$species != "New")
                 {
                   output$Species_Growth_out <- renderPlot(
                     {
                       index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
                       sname <- species_library$common_name[index]
                       FishToxTranslator::PlotGrowth(forProfile = TRUE, species = sname)
                     }
                   )
                   shinyjs::show(id = "Species_Growth_out_Main")
                 }else
                 {
                   shinyjs::hide(id = "Species_Growth_out_Main")
                 }
               }else
               {
                 shinyjs::hide(id = "Species_Growth_out_Main")
               }
             },
             ignoreInit = TRUE)


output$SGrowthPlot <- renderUI(
  {
    plotOutput("plotSpeciesGrowth", height = "800px")
  }
)

output$plotSpeciesGrowth <- renderPlot(
  FishToxTranslator::PlotGrowth(forProfile = TRUE, 
                                species = species_library$common_name[which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)])
)


observeEvent(input$export_species_growth_modal,
             {
               if (input$species != "New")
               {
                 shinyjs::enable(id = "downloadPlotSpeciesGrowth")
               }
             }
)

output$downloadPlotSpeciesGrowth <- downloadHandler(
  filename <- function()
  {
    index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
    sname <- species_library$common_name[index]
    paste(sname, "_Growth", ".png", sep = "")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
    sname <- species_library$common_name[index]
    FishToxTranslator::PlotGrowth(forProfile = TRUE, species = sname)
    dev.off()
  },
  contentType = "png"
) 

# Species growth trajectory
observeEvent(input$plot_clear_species_growth_trajectory,
             {
               if (input$plot_clear_species_growth_trajectory)
               {
                 if (input$species != "New")
                 {
                   output$Species_Growth_Trajectory_out <- renderPlot(
                     {
                       index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
                       sname <- species_library$common_name[index]
                       FishToxTranslator::PlotGrowthTrajectory(species = sname)
                     }
                   )
                   shinyjs::show(id = "Species_Growth_Trajectory_out_Main")
                 }else
                 {
                   shinyjs::hide(id = "Species_Growth_Trajectory_out_Main")
                 }
               }else
               {
                 shinyjs::hide(id = "Species_Growth_Trajectory_out_Main")
               }
             },
             ignoreInit = TRUE)


output$SGrowthTrajectoryPlot <- renderUI(
  {
    plotOutput("plotSpeciesGrowthTrajectory", height = "800px")
  }
)

output$plotSpeciesGrowthTrajectory <- renderPlot(
  FishToxTranslator::PlotGrowthTrajectory(species = species_library$common_name[which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)])
)


observeEvent(input$export_species_growth_trajectory_modal,
             {
               if (input$species != "New")
               {
                 shinyjs::enable(id = "downloadPlotSpeciesGrowthTrajectory")
               }
             }
)

output$downloadPlotSpeciesGrowthTrajectory <- downloadHandler(
  filename <- function()
  {
    index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
    sname <- species_library$common_name[index]
    paste(sname, "_Growth_Trajectory", ".png", sep = "")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
    sname <- species_library$common_name[index]
    FishToxTranslator::PlotGrowthTrajectory(species = sname)
    dev.off()
  },
  contentType = "png"
) 

# Species survival trajectory
observeEvent(input$plot_clear_species_survival_trajectory,
             {
               if (input$plot_clear_species_survival_trajectory)
               {
                 if (input$species != "New")
                 {
                   output$Species_Survival_Trajectory_out <- renderPlot(
                     {
                       index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
                       sname <- species_library$common_name[index]
                       FishToxTranslator:::PlotSurvivalTrajectory(species = sname)
                     }
                   )
                   shinyjs::show(id = "Species_Survival_Trajectory_out_Main")
                 }else
                 {
                   shinyjs::hide(id = "Species_Survival_Trajectory_out_Main")
                 }
               }else
               {
                 shinyjs::hide(id = "Species_Survival_Trajectory_out_Main")
               }
             },
             ignoreInit = TRUE)


output$SSurvivalTrajectoryPlot <- renderUI(
  {
    plotOutput("plotSpeciesSurvivalTrajectory", height = "800px")
  }
)

output$plotSpeciesSurvivalTrajectory <- renderPlot(
  FishToxTranslator:::PlotSurvivalTrajectory(species = species_library$common_name[which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)])
)


observeEvent(input$export_species_survival_trajectory_modal,
             {
               if (input$species != "New")
               {
                 shinyjs::enable(id = "downloadPlotSpeciesSurvivalTrajectory")
               }
             }
)

output$downloadPlotSpeciesSurvivalTrajectory <- downloadHandler(
  filename <- function()
  {
    index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
    sname <- species_library$common_name[index]
    paste(sname, "_Survival_Trajectory", ".png", sep = "")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
    sname <- species_library$common_name[index]
    FishToxTranslator:::PlotSurvivalTrajectory(species = sname)
    dev.off()
  },
  contentType = "png"
) 

# Species length to mass
observeEvent(input$plot_clear_species_length_mass,
             {
               if (input$plot_clear_species_length_mass)
               {
                 if (input$species != "New")
                 {
                   output$Species_Length_Mass_out <- renderPlot(
                     {
                       index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
                       sname <- species_library$common_name[index]
                       FishToxTranslator::PlotLengthToMass(species = sname)
                     }
                   )
                   shinyjs::show(id = "Species_Length_Mass_out_Main")
                 }else
                 {
                   shinyjs::hide(id = "Species_Length_Mass_out_Main")
                 }
               }else
               {
                 shinyjs::hide(id = "Species_Length_Mass_out_Main")
               }
             },
             ignoreInit = TRUE)


output$SLengthMassPlot <- renderUI(
  {
    plotOutput("plotSpeciesLengthMass", height = "800px")
  }
)

output$plotSpeciesLengthMass <- renderPlot(
  FishToxTranslator::PlotLengthToMass(species = species_library$common_name[which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)])
)


observeEvent(input$export_species_length_mass_modal,
             {
               if (input$species != "New")
               {
                 shinyjs::enable(id = "downloadPlotSpeciesLengthMass")
               }
             }
)

output$downloadPlotSpeciesLengthMass <- downloadHandler(
  filename <- function()
  {
    index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
    sname <- species_library$common_name[index]
    paste(sname, "_Length_Mass", ".png", sep = "")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
    sname <- species_library$common_name[index]
    FishToxTranslator::PlotLengthToMass(species = sname)
    dev.off()
  },
  contentType = "png"
) 

# Species survival
observeEvent(input$plot_clear_species_survival,
             {
               if (input$plot_clear_species_survival)
               {
                 if (input$species != "New")
                 {
                   output$Species_Survival_out <- renderPlot(
                     {
                       index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
                       sname <- species_library$common_name[index]
                       FishToxTranslator::PlotSurvival(forProfile = TRUE, species = sname)
                     }
                   )
                   shinyjs::show(id = "Species_Survival_out_Main")
                 }else
                 {
                   shinyjs::hide(id = "Species_Survival_out_Main")
                 }
               }else
               {
                 shinyjs::hide(id = "Species_Survival_out_Main")
               }
             },
             ignoreInit = TRUE)


output$SSurvivalPlot <- renderUI(
  {
    plotOutput("plotSpeciesSurvival", height = "800px")
  }
)

output$plotSpeciesSurvival <- renderPlot(
  FishToxTranslator::PlotSurvival(forProfile = TRUE, species = species_library$common_name[which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)])
)


observeEvent(input$export_species_survival_modal,
             {
               if (input$species != "New")
               {
                 shinyjs::enable(id = "downloadPlotSpeciesSurvival")
               }
             }
)

output$downloadPlotSpeciesSurvival <- downloadHandler(
  filename <- function()
  {
    index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
    sname <- species_library$common_name[index]
    paste(sname, "_Survival", ".png", sep = "")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
    sname <- species_library$common_name[index]
    FishToxTranslator::PlotSurvival(forProfile = TRUE, species = sname)
    dev.off()
  },
  contentType = "png"
) 

# Species reproduction
observeEvent(input$plot_clear_species_reproduction,
             {
               if (input$plot_clear_species_reproduction)
               {
                 if (input$species != "New")
                 {
                   output$Species_Reproduction_out <- renderPlot(
                     {
                       index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
                       sname <- species_library$common_name[index]
                       FishToxTranslator::PlotReproduction(forProfile = TRUE, species = sname)
                     }
                   )
                   shinyjs::show(id = "Species_Reproduction_out_Main")
                 }else
                 {
                   shinyjs::hide(id = "Species_Reproduction_out_Main")
                 }
               }else
               {
                 shinyjs::hide(id = "Species_Reproduction_out_Main")
               }
             },
             ignoreInit = TRUE)


output$SReproductionPlot <- renderUI(
  {
    plotOutput("plotSpeciesReproduction", height = "800px")
  }
)

output$plotSpeciesReproduction <- renderPlot(
  FishToxTranslator::PlotReproduction(forProfile = TRUE, species = species_library$common_name[which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)])
)


observeEvent(input$export_species_reproduction_modal,
             {
               if (input$species != "New")
               {
                 shinyjs::enable(id = "downloadPlotSpeciesReproduction")
               }
             }
)

output$downloadPlotSpeciesReproduction <- downloadHandler(
  filename <- function()
  {
    index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
    sname <- species_library$common_name[index]
    paste(sname, "_Reproduction", ".png", sep = "")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    index <- which(species_library$common_name == CurrentSpeciesName, arr.ind = TRUE)
    sname <- species_library$common_name[index]
    FishToxTranslator::PlotReproduction(forProfile = TRUE, species = sname)
    dev.off()
  },
  contentType = "png"
) 

####################################################################################################
# Download/Upload Events
####################################################################################################
observeEvent(input$upload_history_pars,
             {
               assign_history_pars(TemporaryBaselineScenarioName, input$upload_history_pars$datapath)
               label_str <- paste("View complete ", TemporaryBaselineScenarioName, " parameters")
               # updateActionButton(session, "display_LifeHistory", label = label_str)
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
  },
  contentType = "csv"
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
  },
  contentType = "csv"
)


####################################################################################################
# Spawning Algorithm
####################################################################################################
observeEvent(input$load_fhm_parameters,
             {
               if (is.null(input$currentScenarioName) || (trimws(input$currentScenarioName) == ""))
               {
                 shinyjs::info("Input textbox is empty. Please enter a name.")
                 shinyjs::hide(id = "baseline_visualize")
               }else if (verifyScenarioName(input$currentScenarioName))
               {
                 msg <- paste(input$currentScenarioName,
                              " has been assigned before. Please enter a different name.")
                 shinyjs::info(msg)
                 shinyjs::hide(id = "baseline_visualize")
               }else
               {
                 TemporaryBaselineScenarioName <<- input$currentScenarioName
                 CurrentBaselineScenarioName <<- input$currentScenarioName
                 # output$text_basename <- renderText(
                 #   {
                 #     paste("This scenario has been named '", TemporaryBaselineScenarioName, "'.",sep="")
                 #   }
                 # )
                 
                 load_fhm_parameters(TemporaryBaselineScenarioName, input$species)
                 CurrentSpeciesName <<- input$species
                 output$text_load_fhm <- renderText(
                   {
                     paste("This scenario has been named '", TemporaryBaselineScenarioName, "'. ", 
                           CurrentSpeciesName, " parameters have been loaded into memory, and the ",
                           "spawning algorithm for '", TemporaryBaselineScenarioName, "'",
                           " has completed.",
                            sep="")
                   }
                 )
                 label_str <- paste("View complete ", TemporaryBaselineScenarioName, " parameters")
                 
                 enter_baseline_scenario_name(TemporaryBaselineScenarioName, input$textBaselineDescription)
                 
                 run_spawning_algorithm(TemporaryBaselineScenarioName)
                 
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
                 
                 updateCheckboxInput(session, 
                                     inputId = "All_Runs",
                                     value = FALSE)
                 
                 updateSwitchInput(session, 
                                   inputId = "display_LifeHistory",
                                   value = TRUE)
                 
                 subElement1 <- paste("#Check_Scenario_Names_Results input[value=", scenario_names,"]")
                 delay(1, shinyjs::disable(selector = subElement1))
                 
                 updateTextInput(session, inputId = "stressorName", value = "")
                 
                 output$text_stressorName <- NULL
                 
                 output$text_runid <- NULL
                 
                 shinyjs::show(id = "Spawning_Prob_main")
                 
                 shinyjs::show(id = "species_profile_html")
                 
                 shinyjs::show(id = "baseline_visualize")
                 
                 shinyjs::show(id = "Visualization_GRS")
                 
                 shinyjs::show(id = "Visualization_SPB")
                 
                 shinyjs::show(id = "scenario_options")
                 shinyjs::show(id = "HideExportScenarioButton")
                 shinyjs::show(id = "HideDeleteScenarioSelection")
                 shinyjs::show(id = "HideAddStressorScenarioButton")
                 shinyjs::show(id = "HideAddSimulationRunButton")
                 
                 shinyjs::enable(id = "show_species_profile_modal")
                 shinyjs::disable(id = "currentScenarioName")
                 shinyjs::disable(id = "textBaselineDescription")
                 # shinyjs::disable(id = "submit_name")
                 shinyjs::disable(id = "load_fhm_parameters")
                 shinyjs::disable(id = "species")
                 shinyjs::disable(id = "upload_history_pars")
                 shinyjs::disable(id = "download_history_parameters")
                 
                 updateSwitchInput(session, 
                                   inputId = "display_SpeciesParameters",
                                   value = FALSE)
                 
                 updateSwitchInput(session,
                                   inputId = "plot_all_on_off",
                                   value = FALSE)
                 updateSwitchInput(session,
                                   inputId = "plot_clear_species_growth",
                                   value = FALSE)
                 updateSwitchInput(session,
                                   inputId = "plot_clear_species_growth_trajectory",
                                   value = FALSE)
                 updateSwitchInput(session,
                                   inputId = "plot_clear_species_survival_trajectory",
                                   value = FALSE)
                 updateSwitchInput(session,
                                   inputId = "plot_clear_species_length_mass",
                                   value = FALSE)
                 updateSwitchInput(session,
                                   inputId = "plot_clear_species_survival",
                                   value = FALSE)
                 updateSwitchInput(session,
                                   inputId = "plot_clear_species_reproduction",
                                   value = FALSE)
                 
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
                 
               

             }
             
)

################################################################################
#  Render R markdown document
################################################################################

# output$rmark <- renderUI({
#   tags$iframe(srcdoc = HTML(readLines(rmarkdown::render("Species_Profile.Rmd"))), 
#               seamless = "seamless", height = 1200, width = 1480)})

generate_species_markdown <- reactive({
  req(input$species)
  if (length(input$species) >= 1)
  {
    return(TRUE)
  }else 
  {
    return(FALSE)
  }
})

output$rmark <- renderUI(
  {
    if (generate_species_markdown() == TRUE)
    {
      path_rmd <- "Species_Profile.Rmd"

      # Render into www folder.
      system.name <- Sys.info()[["sysname"]]
      fish_name <- sub(" ", "_", CurrentSpeciesName)
      path_html <- ifelse(system.name=="Windows", paste("www\\",fish_name,"_Profile.html",sep = ""),paste("www/",fish_name,"_Profile.html",sep = ""))
      render(
         path_rmd,
         output_format = "html_document",
         output_file = path_html,
         envir = new.env()
      )
      tags$iframe(
        style = "border-width: 0;",
        width = "100%",
        height = 1200,
        src = paste(fish_name,"_Profile.html",sep = "")
        # Filename relative to the www folder.
        # src = basename(path_html)

      )
    }
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
# observeEvent(input$load_fhm_parameters,
#              {
#                load_fhm_parameters(TemporaryBaselineScenarioName, input$species)
#                CurrentSpeciesName <<- input$species
#                output$text_load_fhm <- renderText(
#                  {
#                    paste(CurrentSpeciesName, " parameters have been loaded into memory.")
#                  }
#                )
#                label_str <- paste("View complete ", TemporaryBaselineScenarioName, " parameters")
#                # updateActionButton(session, "display_LifeHistory", label = label_str)
#                # shinyjs::show(id = "HideExportScenarioButton")
#              }
# )

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
    shinyjs::hide(id = "species_profile_html")
    shinyjs::hide(id = "baseline_visualize")
    shinyjs::hide(id = "species_parameters_table_main")
    
    shinyjs::hide(id = "Species_Growth_out_Main")
    shinyjs::hide(id = "Species_Growth_Trajectory_out_Main")
    shinyjs::hide(id = "Species_Survival_Trajectory_out_Main")
    shinyjs::hide(id = "Species_Length_Mass_out_Main")
    shinyjs::hide(id = "Species_Survival_out_Main")
    shinyjs::hide(id = "Species_Reproduction_out_Main")
    
    updateSwitchInput(session, 
                      inputId = "display_SpeciesParameters",
                      value = FALSE)
    updateSwitchInput(session,
                      inputId = "plot_all_on_off",
                      value = FALSE)
    updateSwitchInput(session,
                      inputId = "plot_clear_species_growth",
                      value = FALSE)
    updateSwitchInput(session,
                      inputId = "plot_clear_species_growth_trajectory",
                      value = FALSE)
    updateSwitchInput(session,
                      inputId = "plot_clear_species_survival_trajectory",
                      value = FALSE)
    updateSwitchInput(session,
                      inputId = "plot_clear_species_length_mass",
                      value = FALSE)
    updateSwitchInput(session,
                      inputId = "plot_clear_species_survival",
                      value = FALSE)
    updateSwitchInput(session,
                      inputId = "plot_clear_species_reproduction",
                      value = FALSE)
  }

})

observe(
  {
    if (input$species %in% species_library$common_name)
    {
      CurrentSpeciesName <<- input$species
      output$text_load_fhm <- NULL
      shinyjs::show(id = "options")
      shinyjs::hide(id = "scenario_options")
      shinyjs::hide(id = "life_history_table_main")
      shinyjs::hide(id = "Spawning_Prob_main")
      shinyjs::hide(id = "species_profile_html")
      shinyjs::hide(id = "baseline_visualize")
      
      shinyjs::hide(id = "Species_Growth_out_Main")
      shinyjs::hide(id = "Species_Growth_Trajectory_out_Main")
      shinyjs::hide(id = "Species_Survival_Trajectory_out_Main")
      shinyjs::hide(id = "Species_Length_Mass_out_Main")
      shinyjs::hide(id = "Species_Survival_out_Main")
      shinyjs::hide(id = "Species_Reproduction_out_Main")
      
      updateSwitchInput(session,
                        inputId = "plot_all_on_off",
                        value = FALSE)
      updateSwitchInput(session, 
                        inputId = "display_SpeciesParameters",
                        value = FALSE)
      updateSwitchInput(session,
                        inputId = "plot_clear_species_growth",
                        value = FALSE)
      updateSwitchInput(session,
                        inputId = "plot_clear_species_growth_trajectory",
                        value = FALSE)
      updateSwitchInput(session,
                        inputId = "plot_clear_species_survival_trajectory",
                        value = FALSE)
      updateSwitchInput(session,
                        inputId = "plot_clear_species_length_mass",
                        value = FALSE)
      updateSwitchInput(session,
                        inputId = "plot_clear_species_survival",
                        value = FALSE)
      updateSwitchInput(session,
                        inputId = "plot_clear_species_reproduction",
                        value = FALSE)
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
      shinyjs::hide(id = "species_profile_html")
      shinyjs::hide(id = "baseline_visualize")
      
      shinyjs::hide(id = "Species_Growth_out_Main")
      shinyjs::hide(id = "Species_Growth_Trajectory_out_Main")
      shinyjs::hide(id = "Species_Survival_Trajectory_out_Main")
      shinyjs::hide(id = "Species_Length_Mass_out_Main")
      shinyjs::hide(id = "Species_Survival_out_Main")
      shinyjs::hide(id = "Species_Reproduction_out_Main")
      
      updateSwitchInput(session,
                        inputId = "plot_all_on_off",
                        value = FALSE)
      updateSwitchInput(session, 
                        inputId = "display_SpeciesParameters",
                        value = FALSE)
      updateSwitchInput(session,
                        inputId = "plot_clear_species_growth",
                        value = FALSE)
      updateSwitchInput(session,
                        inputId = "plot_clear_species_growth_trajectory",
                        value = FALSE)
      updateSwitchInput(session,
                        inputId = "plot_clear_species_survival_trajectory",
                        value = FALSE)
      updateSwitchInput(session,
                        inputId = "plot_clear_species_length_mass",
                        value = FALSE)
      updateSwitchInput(session,
                        inputId = "plot_clear_species_survival",
                        value = FALSE)
      updateSwitchInput(session,
                        inputId = "plot_clear_species_reproduction",
                        value = FALSE)
    }
  }
)

observeEvent(input$load_fhm_parameters,
  {
    # shinyjs::show(id = "scenario_options")
    # shinyjs::show(id = "baseline_visualize")
  }
)

observeEvent(input$upload_history_pars,
  {
    shinyjs::show(id = "scenario_options")
    shinyjs::hide(id = "baseline_visualize")
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
