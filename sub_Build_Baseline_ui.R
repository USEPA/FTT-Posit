##################################################################################################
# HTML elements for baseline-building scenario.
##################################################################################################
add_baseline_scenario_button_element <-
  actionButton(inputId = "add_BaselineScenario",
               label = "Add Baseline Scenario",
               class = "actButton")

add_baseline_scenario_button <- helper(
  add_baseline_scenario_button_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Add Scenario Name",
  content = GUI_Tooltip[GUI_Tooltip$Name == "add_baseline_scenario", ]$tooltip
)

baseline_scenario_name_element <-
  textInput(inputId = "currentScenarioName",
            label = "Name scenario",
            value = "")


baseline_scenario_name <- helper(
  baseline_scenario_name_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Baseline Scenario Name",
  content = GUI_Tooltip[GUI_Tooltip$Name == "name_baseline_scenario", ]$tooltip
)

baseline_description_textArea_element <-
  textAreaInput(
    inputId = "textBaselineDescription",
    label = "Enter description of scenario",
    value = "",
    height = '50px'
  )

baseline_description_textArea <- helper(
  baseline_description_textArea_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Description of Scenario",
  content = GUI_Tooltip[GUI_Tooltip$Name == "enter_description_of_scenario", ]$tooltip
)

choose_species_DropDownMenu_element <-
  selectInput(
    inputId = "species",
    label = "Choose Species",
    choices = c(
      "None Selected",
      as.character(species_library$common_name),
      "New"
    )
  )


choose_species_DropDownMenu <-
  helper(
    choose_species_DropDownMenu_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Fish Species",
    content = GUI_Tooltip[GUI_Tooltip$Name == "choose_species", ]$tooltip
  )

load_fhm_parameters_button_element <-
  actionButton(inputId = "load_fhm_parameters",
               label = "Create Scenario",
               class = "actButton")

load_fhm_parameters_button <-
  helper(
    load_fhm_parameters_button_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Load Species Parameters",
    content = GUI_Tooltip[GUI_Tooltip$Name == "load_species_parameters", ]$tooltip
  )

load_fhm_parameters_out_text <- textOutput("text_load_fhm")

download_history_button_element <-
  downloadButton(outputId = "download_history_parameters",
                 label = "Get template file",
                 class = "download_Button")

download_history_button <- helper(
  download_history_button_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Template File",
  content = "Open template file for entering new species parameters."
)


upload_history_button_element <-
  fileInput(
    inputId = "upload_history_pars",
    label = NULL,
    accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv"),
    width = '300px',
    buttonLabel = "Upload life history Data",
    placeholder = "No file selected"
  )


upload_history_button <- helper(
  upload_history_button_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "New Species Parameters File",
  content = "Select file with new species parameters from disk and upload it into memory."
)

species_profile_textLabel_element <-
  h4("Species Life History Parameters")

species_profile_textLabel <- helper(
  species_profile_textLabel_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Species Profile Data",
  content = "Table containing a list of all the parameters available for a given fish species."
)

baseline_scenario_complete_text_out <-
  htmlOutput("baseline_scenario_complete")

export_species_profile_button <-
  actionButton(
    inputId = "show_species_profile_modal",
    label = div("Generate Visual Species Profile (PDF)", icon("download")),
    width = "100%",
    class = "actButtonD1"
  )

dSP_button <- downloadButton(
  outputId = 'downloadSpeciesProfile',
  label = 'PDF',
  class = "download_Button"
)

# species_profile_modal_window <- shinyBS::bsModal(
#   id = "species_profile_Popup",
#   title = "Species Profile",
#   trigger = "show_species_profile_modal",
#   size = "large",
#   tags$head(tags$style("#species_profile_Popup .modal-footer{ display:none}")),
#   uiOutput("moreControls"),
#   downloadButton(
#     outputId = 'downloadSpeciesProfile',
#     label = 'PDF',
#     class = "download_Button"
#   )
# )


# Switches and download GUI elements for species-specific plots

# All on/off switch
plot_all_on_off_button <-
  switchInput(
    inputId = "plot_all_on_off",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

# Incremental Growth
plot_clear_species_growth_button <-
  switchInput(
    inputId = "plot_clear_species_growth",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

export_species_growth_button <-
  actionButton(
    inputId = "export_species_growth_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

dSG_button <- downloadButton(
  outputId = 'downloadPlotSpeciesGrowth',
  label = 'PNG',
  class = "download_Button"
)

# species_growth_modal_window <- bsModal(
#   id = "species_growth_Popup",
#   title = "Species Growth",
#   trigger = "export_species_growth_modal",
#   size = "large",
#   uiOutput("SGrowthPlot"),
#   downloadButton(
#     outputId = 'downloadPlotSpeciesGrowth',
#     label = 'PNG',
#     class = "download_Button"
#   )
# )

# Growth Trajectory
plot_clear_species_growth_trajectory_button <-
  switchInput(
    inputId = "plot_clear_species_growth_trajectory",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

export_species_growth_trajectory_button <-
  actionButton(
    inputId = "export_species_growth_trajectory_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

dSGT_button <- downloadButton(
  outputId = 'downloadPlotSpeciesGrowthTrajectory',
  label = 'PNG',
  class = "download_Button"
)  
  
# species_growth_trajectory_modal_window <- bsModal(
#   id = "species_growth_trajectory_Popup",
#   title = "Species Growth Trajectory",
#   trigger = "export_species_growth_trajectory_modal",
#   size = "large",
#   uiOutput("SGrowthTrajectoryPlot"),
#   downloadButton(
#     outputId = 'downloadPlotSpeciesGrowthTrajectory',
#     label = 'PNG',
#     class = "download_Button"
#   )
# )

# Survival Trajectory
plot_clear_species_survival_trajectory_button <-
  switchInput(
    inputId = "plot_clear_species_survival_trajectory",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

export_species_survival_trajectory_button <-
  actionButton(
    inputId = "export_species_survival_trajectory_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

dSST_button <- downloadButton(
  outputId = 'downloadPlotSpeciesSurvivalTrajectory',
  label = 'PNG',
  class = "download_Button"
)

# species_survival_trajectory_modal_window <- bsModal(
#   id = "species_survival_trajectory_Popup",
#   title = "Species Survival Trajectory",
#   trigger = "export_species_survival_trajectory_modal",
#   size = "large",
#   uiOutput("SSurvivalTrajectoryPlot"),
#   downloadButton(
#     outputId = 'downloadPlotSpeciesSurvivalTrajectory',
#     label = 'PNG',
#     class = "download_Button"
#   )
# )

# Length to Mass
plot_clear_species_length_mass_button <-
  switchInput(
    inputId = "plot_clear_species_length_mass",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

export_species_length_mass_button <-
  actionButton(
    inputId = "export_species_length_mass_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

dSLM_button <- downloadButton(
  outputId = 'downloadPlotSpeciesLengthMass',
  label = 'PNG',
  class = "download_Button"
)

# species_length_mass_modal_window <- bsModal(
#   id = "species_length_mass_Popup",
#   title = "Species Length to Mass",
#   trigger = "export_species_length_mass_modal",
#   size = "large",
#   uiOutput("SLengthMassPlot"),
#   downloadButton(
#     outputId = 'downloadPlotSpeciesLengthMass',
#     label = 'PNG',
#     class = "download_Button"
#   )
# )

# Survival
plot_clear_species_survival_button <-
  switchInput(
    inputId = "plot_clear_species_survival",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

export_species_survival_button <-
  actionButton(
    inputId = "export_species_survival_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

dSS_button <-   downloadButton(
  outputId = 'downloadPlotSpeciesSurvival',
  label = 'PNG',
  class = "download_Button"
)

# species_survival_modal_window <- bsModal(
#   id = "species_survival_Popup",
#   title = "Species Survival",
#   trigger = "export_species_survival_modal",
#   size = "large",
#   uiOutput("SSurvivalPlot"),
#   downloadButton(
#     outputId = 'downloadPlotSpeciesSurvival',
#     label = 'PNG',
#     class = "download_Button"
#   )
# )

# Reproduction
plot_clear_species_reproduction_button <-
  switchInput(
    inputId = "plot_clear_species_reproduction",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

export_species_reproduction_button <-
  actionButton(
    inputId = "export_species_reproduction_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

dSR_button <-   downloadButton(
  outputId = 'downloadPlotSpeciesReproduction',
  label = 'PNG',
  class = "download_Button"
)

# species_reproduction_modal_window <- bsModal(
#   id = "species_reproduction_Popup",
#   title = "Species Reproduction",
#   trigger = "export_species_reproduction_modal",
#   size = "large",
#   uiOutput("SReproductionPlot"),
#   downloadButton(
#     outputId = 'downloadPlotSpeciesReproduction',
#     label = 'PNG',
#     class = "download_Button"
#   )
# )

# Species Parameters Table
display_species_parameters_table_button_element <-
  switchInput(
    inputId = "display_SpeciesParameters",
    label = "Table",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

display_species_parameters_table_button <-
  helper(
    display_species_parameters_table_button_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Species Parameters",
    content = "Table containing a list of all the parameters available for a given fish species."
  )

hyperlink_newtab_button <- actionLink(
  inputId = "hyperlink_newtab",
  label = "Move to creating a stressor scenario",
  width = '300px',
  style = "#002966; background-color: #f2f2f2; border-color: #2e6da4;"
)

hyperlink_visualization_button <-
  actionLink(
    inputId = "hyperlink_visualization_newtab",
    label = "Move to visualizing a baseline scenario",
    width = '300px',
    style = "#002966; background-color: #f2f2f2; border-color: #2e6da4;"
  )

hyperlink_run_button <- actionLink(
  inputId = "hyperlink_run_newtab",
  label = "Move to running a baseline scenario",
  width = '300px',
  style = "#002966; background-color: #f2f2f2; border-color: #2e6da4;"
)


visualize_text_out <- textOutput("text_visualize")

run_baseline_text_out <- textOutput("text_run_baseline")

display_life_history_table_button_element <-
  switchInput(
    inputId = "display_LifeHistory",
    label = "Table",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

display_life_history_table_button <-
  helper(
    display_life_history_table_button_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Scenario Parameters",
    content = GUI_Tooltip[GUI_Tooltip$Name == "view_complete_baseline_parameters", ]$tooltip
  )

###############################################################################
# Layout for baseline-building scenario. 
###############################################################################
subBaseline <- tabPanel("Build a Baseline Life History Scenario",
                        sidebarLayout(
                          sidebarPanel(
                            add_baseline_scenario_button,
                            
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
                                br(),
                                h4(""),
                                
                                conditionalPanel(
                                  condition = "input.species != 'New'",
                                  h4("Visualize Chosen Species Data", class = "header4"),
                                  br(),
                                  species_profile_textLabel,
                                  fluidRow(
                                    column(width = 6, display_species_parameters_table_button_element),
                                    column(width = 6, export_species_profile_button)
                                  ),
                                  # fluidRow(
                                  #   column(width = 4, species_profile_modal_window),
                                  #   column(width = 8, h4(""))
                                  # ),
                                  fluidRow(column(width = 12, h4(
                                    "Show or Hide all Plots at once"
                                  ))),
                                  fluidRow(column(
                                    width = 12, align = "left", plot_all_on_off_button
                                  )),
                                  fluidRow(column(width = 12, h4(
                                    "Growth Increments by Size"
                                  ))),
                                  fluidRow(
                                    column(
                                      width = 6,
                                      align = "left",
                                      plot_clear_species_growth_button
                                    ),
                                    column(
                                      width = 6,
                                      align = "right",
                                      export_species_growth_button
                                    )
                                  ),
                                  fluidRow(column(
                                    width = 12, h4("Yearly Growth Trajectory by Day")
                                  )),
                                  fluidRow(
                                    column(
                                      width = 6,
                                      align = "left",
                                      plot_clear_species_growth_trajectory_button
                                    ),
                                    column(
                                      width = 6,
                                      align = "right",
                                      export_species_growth_trajectory_button
                                    )
                                  ),
                                  fluidRow(column(
                                    width = 12, h4("Yearly Survival Trajectory by Day")
                                  )),
                                  fluidRow(
                                    column(
                                      width = 6,
                                      align = "left",
                                      plot_clear_species_survival_trajectory_button
                                    ),
                                    column(
                                      width = 6,
                                      align = "right",
                                      export_species_survival_trajectory_button
                                    )
                                  ),
                                  fluidRow(column(
                                    width = 12, h4("Allometry: Length (TL) to Mass")
                                  )),
                                  fluidRow(
                                    column(
                                      width = 6,
                                      align = "left",
                                      plot_clear_species_length_mass_button
                                    ),
                                    column(
                                      width = 6,
                                      align = "right",
                                      export_species_length_mass_button
                                    )
                                  ),
                                  fluidRow(column(width = 12, h4(
                                    "Survival Probability by Size"
                                  ))),
                                  fluidRow(
                                    column(
                                      width = 6,
                                      align = "left",
                                      plot_clear_species_survival_button
                                    ),
                                    column(
                                      width = 6,
                                      align = "right",
                                      export_species_survival_button
                                    )
                                  ),
                                  fluidRow(column(
                                    width = 12, h4("Daily Maximum Reproduction by Size")
                                  )),
                                  fluidRow(
                                    column(
                                      width = 6,
                                      align = "left",
                                      plot_clear_species_reproduction_button
                                    ),
                                    column(
                                      width = 6,
                                      align = "right",
                                      export_species_reproduction_button
                                    )
                                  ),
                                  br(),
                                  shinyjs::hidden((
                                    div(
                                      id = "BuildBaselineScenario",
                                      baseline_scenario_name,
                                      h4(""),
                                      baseline_description_textArea,
                                      h4("")
                                      # submit_baselinename_button,
                                      # h5(baseline_name_out_text)
                                    )
                                  )),
                                  br(),
                                  fluidRow(column(width = 12, load_fhm_parameters_button)),
                                  br(),
                                  fluidRow(column(width = 12, load_fhm_parameters_out_text))
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
                                id = "baseline_visualize",
                                hr(),
                                h4("Scenario Parameters"),
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
                          
                          mainPanel(
                            shinyjs::hidden(
                              div(
                                id = "species_parameters_table_main",
                                DT::dataTableOutput(outputId = "species_parameters_table", width = "100%")
                              )
                            ),
                            
                            shinyjs::hidden(div(
                              id = "Species_Growth_out_Main", plotOutput(outputId = "Species_Growth_out")
                            )),
                            
                            # species_growth_modal_window,
                            
                            shinyjs::hidden(div(
                              id = "Species_Growth_Trajectory_out_Main", plotOutput(outputId = "Species_Growth_Trajectory_out")
                            )),
                            
                            # species_growth_trajectory_modal_window,
                            
                            shinyjs::hidden(div(
                              id = "Species_Survival_Trajectory_out_Main", plotOutput(outputId = "Species_Survival_Trajectory_out")
                            )),
                            
                            # species_survival_trajectory_modal_window,
                            
                            shinyjs::hidden(div(
                              id = "Species_Length_Mass_out_Main", plotOutput(outputId = "Species_Length_Mass_out")
                            )),
                            
                            # species_length_mass_modal_window,
                            
                            shinyjs::hidden(div(
                              id = "Species_Survival_out_Main", plotOutput(outputId = "Species_Survival_out")
                            )),
                            
                            # species_survival_modal_window,
                            
                            shinyjs::hidden(div(
                              id = "Species_Reproduction_out_Main", plotOutput(outputId = "Species_Reproduction_out")
                            )),
                            
                            # species_reproduction_modal_window,
                            
                            shinyjs::hidden(div(
                              id = "life_history_table_main",
                              DT::dataTableOutput(outputId = "life_history_table", width = "100%")
                            )),
                            shinyjs::hidden(div(
                              id = "Spawning_Prob_main", plotOutput(outputId = "Spawning_Prob_out")
                            )),
                            width = 8
                          )
                        ))
