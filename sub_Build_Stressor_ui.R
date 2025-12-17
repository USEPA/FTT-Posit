################################################################################
# HTML elements for stressor-building scenario.
################################################################################
add_stressor_scenario_button <-
  actionButton(inputId = "add_StressorScenario",
               label = "Add Stressor Scenario",
               class = "actButton")

export_scenario_button <- actionButton(inputId = "Export_Scenario",
                                       label = "Export Scenario",
                                       class = "actButton")

export_scenario_out_text <- textOutput("text_export_scenario")

import_scenario_button <- actionButton(
  inputId = "Import_Scenario",
  label = "Import Scenario",
  width = '250px',
  class = "actButton"
)

submit_stressorName_button <-
  actionButton(
    inputId = "submit_stressorName",
    label = "Submit stressor information",
    width = '250px',
    class = "actButton"
  )

underlying_scenario_text_out <- textOutput("underlying_scenario")


stressorName_out_text <- textOutput("text_stressorName")

stressor_name_button_element <- textInput(inputId = "stressorName",
                                          label = "Name the stressor scenario",
                                          value = "")


stressor_name_button <- helper(
  stressor_name_button_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Stressor Name",
  content = "Choose a name for the stressor scenario you are creating."
)


stressor_description_textArea <-
  textAreaInput(
    inputId = "textStressorDescription",
    label = "Enter description of stressor scenario",
    value = "",
    height = '50px'
  )

stressor_type_button_element <-
  selectInput(
    inputId = "stressor_type",
    label = "Choose Stressor Type",
    choices = c(
      "None Selected",
      "Chemical: Survival",
      "Chemical: Growth",
      "Non-chemical: Winter",
      "Non-chemical: Density Dependent Growth Response"
    )
  )


stressor_type_button <- helper(
  stressor_type_button_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Stressor Type",
  content = "Select type of stressor."
)


choose_Exposure_Concentration_dropdownmenu <-
  selectInput(
    inputId = "expconc_profile",
    label = "Choose Exposure Concentration Profile",
    choices = c("None Selected", "New")
  )

download_exposure_concentration_element <-
  downloadButton(
    outputId = "download_exposure_concentration",
    label = "Get template",
    width = '125px',
    class = "download_Button"
  )


download_exposure_concentration <-
  helper(
    download_exposure_concentration_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Download Exposure Concentration",
    content = "Open template file for entering chemical exposure concentrations."
  )


upload_exposure_concentration_element <-
  fileInput(
    inputId = "upload_exposure_concentrations",
    label = NULL,
    accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv"),
    width = '300px',
    buttonLabel = "Upload",
    placeholder = "No file selected",
    multiple = FALSE
  )

upload_exposure_concentration <-
  helper(
    upload_exposure_concentration_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Upload Exposure Concentration",
    content = "Load into memory existing file with chemical exposure concentrations."
  )


select_chemical_effect_type_element <-
  selectInput(
    inputId = "effect_type",
    label = "Choose Chemical Effect Type",
    choices = c(
      "None Selected",
      "Threshold Effects Model: TCEM",
      "Pre-determined effects"
    )
  )


select_chemical_effect_type <-
  helper(
    select_chemical_effect_type_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Chemical Effect Type",
    content = "Choose the type of chemical effect."
  )


tcem_param1_element <- numericInput(
  inputId = "tcem_lc_conc",
  label = "",
  value = 2.5,
  min = 0.0,
  step = 0.05
)


tt_tcm1 <-
  paste(
    as.character(parameters_master$id[which(parameters_master$id == 'lc_conc')]),
    ": ",
    as.character(parameters_master$description[which(parameters_master$id == 'lc_conc')])
  )


tcem_param1 <- helper(
  tcem_param1_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "TCEM Lethal Concentration",
  content = tt_tcm1
)


tt_tcm2 <-
  paste(
    as.character(parameters_master$id[which(parameters_master$id == 'lc_percent')]),
    ": ",
    as.character(parameters_master$description[which(parameters_master$id == 'lc_percent')])
  )

lbl_tcm <-
  as.character(parameters_master$name[which(parameters_master$id == 'lc_percent')])

tcem_param2_element <- numericInput(
  inputId = "tcem_lc_percent",
  label = lbl_tcm,
  value = 0.5,
  max = 1.0,
  min = 0.0,
  step = 0.05
)


tcem_param2 <- helper(
  tcem_param2_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "TCEM Lethal Concentration Percent",
  content = tt_tcm2
)


run_tcem_button <- actionButton(
  inputId = "run_tcem",
  label = "Run TCEM Algorithm",
  width = '250px',
  class = "actButton"
)

tcem_out_text <- htmlOutput("text_tcem")


download_predeterminedEffects_button_element <-
  downloadButton(
    outputId = "download_predetermined_effects",
    label = "Get template",
    width = '125px',
    class = "download_Button"
  )


download_predeterminedEffects_button <-
  helper(
    download_predeterminedEffects_button_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Pre-determined Effects Template File",
    content = "Open template file for entering predetermined effects. File is of CSV type."
  )


download_predeterminedGrowthEffects_button_element <-
  downloadButton(
    outputId = "download_predetermined_growth_effects",
    label = "Get template",
    width = '125px',
    class = "download_Button"
  )


download_predeterminedGrowthEffects_button <-
  helper(
    download_predeterminedGrowthEffects_button_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Predetermined Growth Effects Template File",
    content = "Open template file for entering predetermined growth effects. File is of CSV type."
  )


upload_predeterminedEffects_button_element <-
  fileInput(
    inputId = "upload_predetermined_effects",
    label = NULL,
    accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv"),
    width = '500px',
    buttonLabel = "Upload predetermined effects",
    placeholder = "No file selected"
  )


upload_predeterminedEffects_button <-
  helper(
    upload_predeterminedEffects_button_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Existing Predetermined Effects File",
    content = "Load existing file with predetermined effects into memory. Browse and select file from local drive."
  )


upload_predeterminedGrowthEffects_button_element <-
  fileInput(
    inputId = "upload_predetermined_growth_effects",
    label = NULL,
    accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv"),
    width = '500px',
    buttonLabel = "Upload growth effects",
    placeholder = "No file selected"
  )


upload_predeterminedGrowthEffects_button <-
  helper(
    upload_predeterminedGrowthEffects_button_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Existing Predetermined Growth Effects File",
    content = "Load existing file with predetermined growth effects into memory. Browse and select file from local drive."
  )



chemical_id_textInput_element <- textInput(
  inputId = "chemical_id",
  label = as.character(parameters_master$name[which(parameters_master$id == 'chem_id')]),
  value = ""
)


chemical_id_textInput <- helper(
  chemical_id_textInput_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Chemical ID",
  content = paste(
    as.character(parameters_master$id[which(parameters_master$id == 'chem_id')]),
    ": ",
    as.character(parameters_master$description[which(parameters_master$id == 'chem_id')])
  )
)


chemID_out_text <- textOutput("text_chemicalID")

enter_chemicalID_button <-
  actionButton(
    inputId = "store_chemicalID",
    label = "Store Chemical ID",
    width = '250px',
    class = "actButton"
  )

guts_out_text <- textOutput(("text_guts"))

density_dependence_rate_element <-
  numericInput(
    inputId = "density_dependence_rate",
    label = as.character(parameters_master$name[which(parameters_master$id == 'dd_g')]),
    value = parameters[[CurrentStressorScenarioName]]$value[which(parameters[[CurrentStressorScenarioName]]$id == 'dd_g')]
  )


density_dependence_rate_out_text <-
  textOutput("density_dependence_rate")

density_dependence_rate <- helper(
  density_dependence_rate_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Density Dependence Rate",
  content = as.character(parameters_master$description[which(parameters_master$id == 'dd_g')])
)


winter_start_element <- numericInput(
  inputId = "start_winter",
  label = as.character(parameters_master$name[which(parameters_master$id == 'winter_start')]),
  value = 355
)

winter_out_text1 <- textOutput("firstDay_winter")

winter_start <- helper(
  winter_start_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "First Day of Winter",
  content = paste(
    as.character(parameters_master$id[which(parameters_master$id == 'winter_start')]),
    ": ",
    as.character(parameters_master$description[which(parameters_master$id == 'winter_start')])
  )
)


winter_end_element <- numericInput(
  inputId = "end_winter",
  label = as.character(parameters_master$name[which(parameters_master$id == 'winter_end')]),
  value = 91
)

winter_out_text2 <- textOutput("lastDay_winter")

winter_end <- helper(
  winter_end_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Last Day of Winter",
  content = paste(
    as.character(parameters_master$id[which(parameters_master$id == 'winter_end')]),
    ": ",
    as.character(parameters_master$description[which(parameters_master$id == 'winter_end')])
  )
)


label_zparam <-
  paste(
    as.character(parameters_master$id[which(parameters_master$id == 'z_winter')]),
    ": ",
    as.character(parameters_master$description[which(parameters_master$id == 'z_winter')])
  )

winter_zparam_element <- numericInput(
  inputId = "winter_cutoff",
  label = as.character(parameters_master$name[which(parameters_master$id == 'z_winter')]),
  value = 16,
  min = 0.0
)


winter_zparam <- helper(
  winter_zparam_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Winter Cutoff",
  content = label_zparam
)


store_winter_parameters_button <-
  actionButton(
    inputId = "store_winter_params",
    label = "Store Winter Parameters",
    width = '250px',
    class = "actButton"
  )

store_density_dependence_parameters_button <-
  actionButton(
    inputId = "store_density_dependent_params",
    label = "Store Density Dependent Parameters",
    width = '250px',
    class = "actButton"
  )

display_stressor_table_button_element <-
  switchInput(
    inputId = "display_stressor_table",
    label = "Table",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

display_stressor_table_button <-
  helper(
    display_stressor_table_button_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Stressor Parameters",
    content = "Stressor Parameters Table"
  )

stressor_scenario_complete_text_out <-
  htmlOutput("stressor_scenario_complete")

hyperlink_stressor_newtab_button <-
  actionLink(
    inputId = "hyperlink_stressor_newtab",
    label = "Move to visualizing scenario(s)",
    width = '300px',
    style = "#002966; background-color: #f2f2f2; border-color: #2e6da4;"
  )

hyperlink_run_stressor_button <-
  actionLink(
    inputId = "hyperlink_run_stressor",
    label = "Move to running scenario(s)",
    width = '300px',
    style = "#002966; background-color: #f2f2f2; border-color: #2e6da4;"
  )

visualize_stressor_text_out <- textOutput("text_visualize_stressor")

run_stressor_text_out <- textOutput("text_run_stressor")


################################################################################
# Layout for stressor-building scenario.
################################################################################
subStressor <- tabPanel("Build a Stressor Scenario",
                        sidebarLayout(
                          sidebarPanel(
                            shinyjs::hidden(
                              div(id = "HideAddStressorScenarioButton", add_stressor_scenario_button, h4(""))
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
                                  shinyjs::hidden(div(id = "stressorType", stressor_type_button)),
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
                                  div(id = "upload_new_exposure_concentration", choose_Exposure_Concentration_dropdownmenu)
                                ),
                                h4(""),
                                shinyjs::hidden(div(id = "exposure_conc", fluidRow(
                                  column(width = 7, upload_exposure_concentration),
                                  column(
                                    width = 4,
                                    offset = 1,
                                    download_exposure_concentration
                                  )
                                ))),
                                br(),
                                shinyjs::hidden(div(id = "chemicalEffectType", select_chemical_effect_type)),
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
                                  
                                  div(id = "guts", guts_out_text)
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
                                    br(),
                                    h4("Stressor Parameters Table"),
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
                              id = "stressor_table_main", DT::dataTableOutput("stressor_table")
                            )),
                            
                            shinyjs::hidden(div(
                              id = "Exposure_Concentration_Main", plotOutput(outputId = "Exposure_Concentration_out")
                            )),
                            
                            shinyjs::hidden(div(id = "TCEM_Main", plotOutput(outputId = "TCEM_out"))),
                            
                            shinyjs::hidden(div(
                              id = "Survival_Decrement_Main", plotOutput(outputId = "Survival_Decrement_out")
                            )),
                            
                            shinyjs::hidden(div(
                              id = "Growth_Percent_Main", plotOutput(outputId = "Growth_Percent_out")
                            )),
                            
                            shinyjs::hidden(div(
                              id = "Winter_Survival_Main", plotOutput(outputId = "Winter_Survival_out")
                            )),
                            
                            
                            width = 8
                          )
                        ))