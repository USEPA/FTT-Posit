subtab1 <- tabPanel("Build a Baseline Life History Scenario",
                    sidebarLayout(
                      sidebarPanel(
                        add_baseline_scenario_button,
                        
                        shinyjs::hidden((
                          div(
                            id = "BuildBaselineScenario",
                            baseline_scenario_name,
                            h4(""),
                            baseline_description_textArea,
                            h4(""),
                            submit_baselinename_button,
                            h5(baseline_name_out_text)
                          )
                        )),
                        
                        shinyjs::hidden(
                          div(
                            id = "base_name",
                            hr(),
                            h4("Define Species"),
                            br(),
                            choose_species_DropDownMenu
                          )
                        ),
                        
                        h4(""),
                        shinyjs::hidden(
                          div(
                            id = "options",
                            h4("Gather life history parameters"),
                            h4(""),
                            
                            conditionalPanel(
                              condition = "input.species == 'Fathead Minnow'",
                              load_fhm_parameters_button,
                              load_fhm_parameters_out_text
                            ),
                            
                            conditionalPanel(
                              condition = "input.species == 'New'",
                              h4(
                                "If entering new data, open template file first, enter data under corresponding headers,
                                                  and save the file to disk. Then proceed to upload the data into memory."
                              ),
                              fluidRow(
                                column(width = 7, upload_history_button),
                                column(width = 4, offset = 1, download_history_button)
                              )
                            )
                          )
                        ),
                        
                        shinyjs::hidden(
                          div(
                            id = "scenario_options",
                            hr(),
                            h4("Generate spawning probabilities"),
                            h4(""),
                            spawning_alg_button,
                            h5(spawning_alg_out_text)
                          )
                        ),
                        
                        shinyjs::hidden(
                          div(
                            id = "baseline_visualize",
                            hr(),
                            display_life_history_table_button,
                            h4(""),
                            hr(),
                            hyperlink_newtab_button,
                            h4(""),
                            hyperlink_visualization_button,
                            h4(""),
                            hyperlink_run_button,
                            h4("")
                          )
                        ),
                        
                        width = 4
                      ),
                      
                      mainPanel(shinyjs::hidden(
                        div(
                          id = "life_history_table_main",
                          DT::dataTableOutput(outputId = "life_history_table",
                                              width = "100%")
                        )
                      ),
                      
                      shinyjs::hidden(
                        div(id = "Spawning_Prob_main",
                            plotOutput(outputId = "Spawning_Prob_out"))
                      ),
                      
                      width = 8)
                    ))

subtab2 <- tabPanel("Build a Stressor Scenario",
                    sidebarLayout(
                      sidebarPanel(
                        shinyjs::hidden(
                          div(id = "HideAddStressorScenarioButton",
                              add_stressor_scenario_button,
                              h4(""))
                        ),
                        
                        shinyjs::hidden(
                          div(
                            id = "underlying_scenario",
                            tags$div(
                              title = "Select a scenario you would like to apply a stressor to.  The underlying scenario will serve as the basis for the stressor scenario parameters.",
                              selectInput(
                                inputId = "baselines",
                                label = "Select Underlying Scenario",
                                choices = ""
                              ),
                              shinyjs::hidden(div(id = "stressorType",
                                                  stressor_type_button)),
                              shinyjs::hidden(
                                div(
                                  id = "stressorNameDescription",
                                  h4(""),
                                  stressor_name_button,
                                  h4(""),
                                  stressor_description_textArea,
                                  h4(""),
                                  submit_stressorName_button,
                                  stressorName_out_text,
                                  h4("")
                                )
                              )
                            ),
                            underlying_scenario_text_out
                            
                          )
                          
                        ),
                        h4(""),
                        shinyjs::hidden(
                          div(
                            id = "baseline_selection_name",
                            shinyjs::hidden(
                              div(id = "upload_new_exposure_concentration",
                                  choose_Exposure_Concentration_dropdownmenu)
                            ),
                            h4(""),
                            shinyjs::hidden(div(id = "exposure_conc",
                                                fluidRow(
                                                  column(
                                                    width = 12,
                                                    upload_exposure_concentration,
                                                    download_exposure_concentration
                                                  )
                                                ))),
                            br(),
                            shinyjs::hidden(div(id = "chemicalEffectType",
                                                select_chemical_effect_type)),
                            shinyjs::hidden(
                              div(
                                id = "chemicalID",
                                chemical_id_textInput,
                                h4(""),
                                enter_chemicalID_button,
                                h5(chemID_out_text),
                                h4("")
                              ),
                              div(
                                id = "tcem",
                                hr(),
                                h4("Provide the TCEM Parameters"),
                                tcem_param2,
                                h4(""),
                                tcem_param1,
                                h4(""),
                                run_tcem_button,
                                h5(tcem_out_text)
                              ),
                              div(
                                id = "predetermined_effects",
                                hr(),
                                h4("Upload the predetermined effects data"),
                                fluidRow(
                                  column(
                                    width = 12,
                                    upload_predeterminedEffects_button,
                                    download_predeterminedEffects_button
                                  )
                                )
                              ),
                              
                              div(
                                id = "predetermined_growth_effects",
                                hr(),
                                h4("Upload the predetermined growth effects data"),
                                fluidRow(
                                  column(
                                    width = 12,
                                    upload_predeterminedGrowthEffects_button,
                                    download_predeterminedGrowthEffects_button
                                  )
                                )
                              ),
                              
                              div(id = "guts",
                                  guts_out_text)
                            ),
                            
                            
                            shinyjs::hidden(
                              div(
                                id = "Winter_Options",
                                hr(),
                                h4("Provide the Winter Parameters"),
                                winter_start,
                                h5(winter_out_text1),
                                
                                br(),
                                winter_end,
                                h5(winter_out_text2),
                                
                                br(),
                                winter_zparam,
                                
                                br(),
                                store_winter_parameters_button
                              )
                            ),
                            
                            shinyjs::hidden(
                              div(
                                id = "Density_Dependence_Options",
                                hr(),
                                h4("Provide the Density Dependent Growth Parameters"),
                                density_dependence_rate,
                                br(),
                                store_density_dependence_parameters_button,
                                h5(density_dependence_rate_out_text)
                              )
                            ),
                            
                            
                            shinyjs::hidden(
                              div(
                                id = "stressor_verification",
                                
                                h4(""),
                                hr(),
                                h4(""),
                                display_stressor_table_button,
                                h4(""),
                                hyperlink_stressor_newtab_button,
                                h4(""),
                                hyperlink_run_stressor_button
                              )
                            )
                            
                          )
                        ),
                        width = 4
                      ),
                      mainPanel(
                        shinyjs::hidden(div(
                          id = "stressor_table_main",
                          DT::dataTableOutput("stressor_table")
                        )),
                        
                        shinyjs::hidden(div(
                          id = "Exposure_Concentration_Main",
                          plotOutput(outputId = "Exposure_Concentration_out")
                        )),
                        
                        shinyjs::hidden(div(id = "TCEM_Main",
                                            plotOutput(outputId = "TCEM_out"))),
                        
                        shinyjs::hidden(div(
                          id = "Survival_Decrement_Main",
                          plotOutput(outputId = "Survival_Decrement_out")
                        )),
                        
                        shinyjs::hidden(div(
                          id = "Growth_Percent_Main",
                          plotOutput(outputId = "Growth_Percent_out")
                        )),
                        
                        shinyjs::hidden(div(
                          id = "Winter_Survival_Main",
                          plotOutput(outputId = "Winter_Survival_out")
                        )),
                        
                        
                        width = 8
                      )
                    ))

subtab3 <- tabPanel("Export Scenario",
                    sidebarLayout(
                      sidebarPanel(
                        shinyjs::hidden(div(id = "HideExportScenarioButton",
                                            export_scenario_button)),
                        
                        shinyjs::hidden(div(
                          id = "ExportScenarioButton",
                          h4("Select scenario to download"),
                          selectInput(
                            inputId = "downloadScenario",
                            label = "",
                            choices = ""
                          )
                        )),
                        
                        h4(""),
                        shinyjs::hidden(div(
                          id = "DownloadScenarioButton",
                          downloadButton(
                            outputId = "Download_Scenario",
                            label = "Download Scenario",
                            width = '275px',
                            style = "color: #fff; background-color: gray; border-color: #2e6da4"
                          )
                          # export_scenario_out_text
                        ))
                        
                      ),
                      
                      mainPanel()
                    ))

subtab4 <- tabPanel("Import Scenario",
                    sidebarLayout(
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

subtab5 <- tabPanel("Delete Scenario",
                    sidebarLayout(
                      sidebarPanel(shinyjs::hidden(
                        div(
                          id = "HideDeleteScenarioSelection",
                          h4("Select scenario you wish to delete"),
                          selectInput(
                            inputId = "deleteScenario",
                            label = "",
                            choices = ""
                          )
                        )
                      ),
                      h4(""),
                      shinyjs::hidden(
                        div(id = "DeleteScenarioButton",
                            delete_scenario_button)
                      )),
                      
                      mainPanel(delete_scenario_modal_window)
                    ))

subtab41 <- tabPanel("Visualize Results",
                     sidebarLayout(
                       sidebarPanel
                       (shinyjs::hidden(
                         div(
                           id = "Results_Options",
                           check_boxes_all_results,
                           br(),
                           check_boxes_scenarios_results,
                           hr(),
                           h4("Comparison of Scenario Results"),
                           hr(),
                           fluidRow(
                             column(width = 4, h4("Summary Results Table", class = "header4")),
                             column(
                               width = 4,
                               offset = 1,
                               plot_clear_summary_results_button
                             ),
                             column(
                               width = 2,
                               offset = 1,
                               export_summaryResults_button
                             )
                           ),
                           
                           br(),
                           
                           fluidRow(
                             column(width = 3, h4("Summary Matrix", class = "header4")),
                             column(
                               width = 3,
                               offset = 0,
                               plot_clear_summary_matrix_button
                             ),
                             column(width = 2, offset = 1, export_matrix_button),
                             column(
                               width = 2,
                               offset = 1,
                               export_summaryMatrixTable_button
                             )
                           ),
                           
                           hr(),
                           h4("View Selected Plots"),
                           hr(),
                           fluidRow(
                             column(width = 4, h4("Daily Population", class = "header4")),
                             column(
                               width = 4,
                               offset = 1,
                               plot_clear_dailyPopulation_button
                             ),
                             column(
                               width = 2,
                               offset = 1,
                               export_dailyPopulation_button
                             )
                           ),
                           
                           br(),
                           fluidRow(
                             column(width = 4, h4("Population Biomass", class = "header4")),
                             column(
                               width = 4,
                               offset = 1,
                               plot_clear_populationBiomass_button
                             ),
                             column(
                               width = 2,
                               offset = 1,
                               export_populationBiomass_button
                             )
                           ),
                           
                           br(),
                           fluidRow(
                             column(width = 4, h4("Mean Size", class = "header4")),
                             column(
                               width = 4,
                               offset = 1,
                               plot_clear_meanSize_button
                             ),
                             column(width = 2, offset = 1, export_meanSize_button)
                           ),
                           
                           br(),
                           fluidRow(
                             column(width = 4, h4("Growth Potential", class = "header4")),
                             column(
                               width = 4,
                               offset = 1,
                               plot_clear_growthPotential_button
                             ),
                             column(
                               width = 2,
                               offset = 1,
                               export_growthPotential_button
                             )
                           ),
                           
                           br(),
                           fluidRow(
                             column(width = 4, h4("Transitional Kernel", class = "header4")),
                             column(
                               width = 4,
                               offset = 1,
                               plot_clear_transitionalKernel_button
                             ),
                             column(
                               width = 2,
                               offset = 1,
                               export_transitionalKernel_button
                             )
                           ),
                           
                           br(),
                           hr(),
                           
                           fluidRow(
                             column(width = 6, h4("Export Results Report")),
                             column(
                               width = 6,
                               offset = 0,
                               export_results_report_button
                             )
                           )
                         )
                       ),
                         
                         width = 6),
                       
                       mainPanel
                       (
                         shinyjs::hidden(
                           div(id = "scenario_summary_results_main",
                               DT::dataTableOutput("scenario_summary_results_table"))
                         ),
                         
                         summaryResults_modal_window,
                         
                         shinyjs::hidden(div(
                           id = "summaryMatrix_out_Main",
                           plotOutput(
                             outputId = "summaryMatrix_out",
                             width = "1200px",
                             height = "1000px"
                           )
                         )),
                         
                         matrix_modal_window,
                         matrixTable_modal_window,
                         
                         shinyjs::hidden(div(
                           id = "dailyPopulation_out_Main",
                           plotOutput(outputId = "dailyPopulation_out")
                         )),
                         
                         dailyPopulation_modal_window,
                         
                         shinyjs::hidden(div(
                           id = "populationBiomass_out_Main",
                           plotOutput(outputId = "populationBiomass_out")
                         )),
                         
                         populationBiomass_modal_window,
                         
                         shinyjs::hidden(div(
                           id = "meanSize_out_Main",
                           plotOutput(outputId = "meanSize_out")
                         )),
                         
                         meanSize_modal_window,
                         
                         shinyjs::hidden(div(
                           id = "growthPotential_out_Main",
                           plotOutput(outputId = "growthPotential_out")
                         )),
                         
                         growthPotential_modal_window,
                         
                         shinyjs::hidden(div(
                           id = "transitionalKernel_out_Main",
                           plotOutput(outputId = "transitionalKernel_out")
                         )),
                         
                         transitionalKernel_modal_window,
                         
                         width = 6
                       )
                     ))

subtab42 <- tabPanel("Export Results",
                     sidebarLayout(
                       sidebarPanel(
                         shinyjs::hidden(div(
                           id = "HideSelectionRunID",
                           h4("Select run ID"),
                           selectInput(
                             inputId = "selectRunID",
                             label = "",
                             choices = ""
                           )
                         )),
                         h4(""),
                         
                         shinyjs::hidden(div(
                           id = "AssociatedScenarioButton",
                           h4("Select Associated Scenario"),
                           selectInput(
                             inputId = "selectAssociatedScenario",
                             label = "",
                             choices = ""
                           )
                         )),
                         h4(""),
                         
                         shinyjs::hidden(div(
                           id = "DownloadResultsButton",
                           downloadButton(
                             outputId = "Download_Results",
                             label = "Download Results",
                             width = '275px',
                             style = "color: #fff; background-color: gray; border-color: #2e6da4"
                           )
                         ))
                       ),
                       
                       mainPanel()
                     ))

subtab43 <- tabPanel("Import Results",
                     sidebarLayout(
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

subtab44 <- tabPanel("Delete Results",
                     sidebarLayout(
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
                         
                         shinyjs::hidden(div(id = "DeleteResultsButton",
                                             delete_results_button))
                       ),
                       
                       mainPanel(delete_results_modal_window)
                     ))