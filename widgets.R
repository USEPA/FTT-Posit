##################################################################################################
# Baseline buttons/widgets
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
            value = "Baseline")
                                            

baseline_scenario_name <- helper(
  baseline_scenario_name_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Baseline Scenario Name",
  content = GUI_Tooltip[GUI_Tooltip$Name == "name_baseline_scenario", ]$tooltip
)

submit_baselinename_button_element <- actionButton(inputId = "submit_name",
                                                   label = "Submit \"Baseline\" scenario information",
                                                   class = "actButton")
                                           
submit_baselinename_button <- helper(
  submit_baselinename_button_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Submit Baseline Scenario",
  content = GUI_Tooltip[GUI_Tooltip$Name == "submit_baseline_scenario", ]$tooltip
)

baseline_name_out_text <- textOutput("text_basename")

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
               label = "Load Fathead Minnow Parameters",
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


spawning_alg_button_element <-
  actionButton(inputId = "spawn_algorithm",
               label = "Run Spawning Algorithm",
               class = "actButton")

spawning_alg_button <- helper(
  spawning_alg_button_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Spawning Algorithm",
  content = GUI_Tooltip[GUI_Tooltip$Name == "run_spawning_algorithm", ]$tooltip
)

spawning_alg_out_text <- textOutput("text_spawning_alg")

baseline_scenario_complete_text_out <-
  htmlOutput("baseline_scenario_complete")

export_species_profile_button <-
  actionButton(
    inputId = "show_species_profile_modal",
    label = "Display Species Profile",
    width = "100%",
    class = "actButton"
  )

species_profile_modal_window <- bsModal(
  id = "species_profile_Popup",
  title = "Species Profile",
  trigger = "show_species_profile_modal",
  size = "large",
  tags$head(tags$style("#species_profile_Popup .modal-footer{ display:none}")),
  uiOutput("rmark"),
  downloadButton(
    outputId = 'downloadSpeciesProfile',
    label = 'Download',
    class = "download_Button"
  )
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

#display_life_history_table_button_element <-
#  actionButton(
#    inputId = "display_LifeHistory",
#    label = "Display Life-History Parameters Table",
#    width = '250px',
#    class = "actButton"
#  )

display_life_history_table_button_element <-
  switchInput(
    inputId = "display_LifeHistory",
    label = "Display",
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
    title = "Life History Parameters",
    content = GUI_Tooltip[GUI_Tooltip$Name == "view_complete_baseline_parameters", ]$tooltip
  )



##################################################################################################
# Stressor buttons/widgets
##################################################################################################
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
    width = '500px',
    buttonLabel = "Upload Exposure Concentrations",
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
    value = get(species_library$parameter_data)$value[which(parameters_master$id == 'dd_g')]
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

# display_stressor_table_button <-
#   actionButton(
#     inputId = "display_stressor_table",
#     label = "Display Stressor Parameters Table",
#     width = '250px',
#     class = "actButton"
#   )

display_stressor_table_button_element <-
  switchInput(
    inputId = "display_stressor_table",
    label = "Display",
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


##################################################################################################
# Visualize Scenario(s) buttons/widgets
##################################################################################################
check_boxes_all_scenarios <-
  checkboxInput("All", "Select All/None", value = FALSE)

list_scenarios <- list()
check_boxes_Scenarios <-
  checkboxGroupInput(
    "Check_Scenario_Names",
    "Select name(s):",
    width = '400px',
    selected = NULL,
    choiceNames = list_scenarios,
    choiceValues = list_scenarios
  )

slider_calendar_text_out <- textOutput("calendar_format")

slider_parameters_button <-
  sliderInput(
    inputId = "slider_parameters",
    label = "",
    min = 1,
    max = 365,
    value = 91
  )


day_selection_button <-
  numericInput(
    inputId = "slider_DaySelection",
    label = "Choose ordinal date",
    value = 91,
    min = 1,
    max = 365,
    step = 1,
    width = '100px'
  )

plot_clear_growth_button <-
  switchInput(
    inputId = "plot_clear_growth",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )


plot_clear_survival_button <-
  switchInput(
    inputId = "plot_clear_survival",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )


plot_clear_reproduction_button <-
  switchInput(
    inputId = "plot_clear_reproduction",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )


plot_clear_spawning_probabilities_button <-
  switchInput(
    inputId = "plot_clear_spawning_probabilities",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )


plot_clear_survival_decrements_button <-
  switchInput(
    inputId = "plot_clear_survival_decrements",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )


plot_clear_growth_percents_button <-
  switchInput(
    inputId = "plot_clear_growth_percents",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

plot_clear_exposure_concentrations_button <-
  switchInput(
    inputId = "plot_clear_exposure_concentrations",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )


export_growth_functions_button <-
  actionButton(
    inputId = "export_growth_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

export_survival_functions_button <-
  actionButton(
    inputId = "export_survival_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

export_reproduction_functions_button <-
  actionButton(
    inputId = "export_reproduction_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

export_spawning_functions_button <-
  actionButton(
    inputId = "export_spawning_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

export_survival_decrements_button <-
  actionButton(
    inputId = "export_survivalDecrement_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

export_growth_percents_button <-
  actionButton(
    inputId = "export_growthPercents_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )


export_exposure_concentrations_button <-
  actionButton(
    inputId = "export_exposureConcentration_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

growth_modal_window <- bsModal(
  id = "growthPopup",
  title = "Growth Functions",
  trigger = "export_growth_modal",
  size = "large",
  textOutput("textMessageGrowth"),
  plotOutput("plotGrowth"),
  downloadButton(
    outputId = 'downloadPlotGrowth',
    label = 'Download',
    class = "download_Button"
  )
)

survival_modal_window <- bsModal(
  id = "survivalPopup",
  title = "Survival Functions",
  trigger = "export_survival_modal",
  size = "large",
  textOutput("textMessageSurvival"),
  plotOutput("plotSurvival"),
  downloadButton(
    outputId = 'downloadPlotSurvival',
    label = 'Download',
    class = "download_Button"
  )
)

reproduction_modal_window <- bsModal(
  id = "reproductionPopup",
  title = "Reproduction Functions",
  trigger = "export_reproduction_modal",
  size = "large",
  textOutput("textMessageReproduction"),
  plotOutput("plotReproduction"),
  downloadButton(
    outputId = 'downloadPlotReproduction',
    label = 'Download',
    class = "download_Button"
  )
)

spawning_modal_window <- bsModal(
  id = "spawningPopup",
  title = "Spawning Probabilities",
  trigger = "export_spawning_modal",
  size = "large",
  textOutput("textMessageSpawning"),
  plotOutput("plotSpawning"),
  downloadButton(
    outputId = 'downloadPlotSpawning',
    label = 'Download',
    class = "download_Button"
  )
)

survivalDecrement_modal_window <-
  bsModal(
    id = "survivalDecrementPopup",
    title = "Survival Decrements",
    trigger = "export_survivalDecrement_modal",
    size = "large",
    textOutput("textMessageSurvivalDecrement"),
    plotOutput("plotSurvivalDecrement"),
    downloadButton(
      outputId = 'downloadPlotSurvivalDecrement',
      label = 'Download',
      class = "download_Button"
    )
  )

growthPercents_modal_window <- bsModal(
  id = "growthPercentsPopup",
  title = "Growth Percents",
  trigger = "export_growthPercents_modal",
  size = "large",
  textOutput("textMessageGrowthPercents"),
  plotOutput("plotGrowthPercents"),
  downloadButton(
    outputId = 'downloadPlotGrowthPercents',
    label = 'Download',
    class = "download_Button"
  )
)


expousureConcentration_modal_window <-
  bsModal(
    id = "ExposureConcentrationPopup",
    title = "Exposure Concentrations",
    trigger = "export_exposureConcentration_modal",
    size = "large",
    textOutput("textMessageExpousureConcentration"),
    plotOutput("plotExposureConcentration"),
    downloadButton(
      outputId = 'downloadPlotExposureConcentration',
      label = 'Download',
      class = "download_Button"
    )
  )


####################################################################################################
# Export Scenario Sub-tab
####################################################################################################
delete_scenario_button <- actionButton(
  inputId = "Delete_Scenario",
  label = "Delete Scenario",
  width = '150px',
  style = "color: #fff; background-color: blue; border-color: #2e6da4;"
)

delete_scenario_modal_window <- bsModal(
  id = "DeleteScenarioPopup",
  title = "Delete Scenario",
  trigger = "Delete_Scenario",
  size = "l",
  verbatimTextOutput("textMessageDeleteScenario"),
  fluidRow(
    column(
      width = 8,
      actionButton(
        inputId = 'actionDeleteScenario',
        label = 'Confirm and Delete',
        width = '175px',
        style =
          "color: #fff; background-color: blue; border-color: #2e6da4"
      )
    ),
    column(
      width = 2,
      offset = 1,
      modalButton(label = "Close")
    )
  ),
  tags$head(
    tags$style("#DeleteScenarioPopup .modal-footer{display:none}")
  )
)





####################################################################################################
# Run Models
####################################################################################################
add_simulation_run_button <-
  actionButton(
    inputId = "add_SimulationRun",
    label = "Add Simulation Run",
    width = '250px',
    class = "actButton"
  )

check_boxes_all_runs <-
  checkboxInput("All_Runs", "Select All/None", value = FALSE)

list_scenarios_runs <- list()
check_boxes_Scenarios_Run <-
  checkboxGroupInput(
    "Check_Scenario_Names_Run",
    "Select name(s):",
    width = '400px',
    selected = list_scenarios_runs,
    choiceNames = list_scenarios_runs,
    choiceValues = list_scenarios_runs
  )


num_size_classes_button_element <-
  numericInput(
    inputId = "num_size_classes",
    label = as.character(parameters_master$name[which(parameters_master$id == 'num_size_classes')]),
    value = 100,
    min = 80
  )


num_size_classes_button <- helper(
  num_size_classes_button_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Number of Size Classes",
  content = paste(
    as.character(parameters_master$id[which(parameters_master$id == 'num_size_classes')]),
    ": ",
    as.character(parameters_master$description[which(parameters_master$id == 'num_size_classes')])
  )
)


solver_order_button_element <-
  numericInput(
    inputId = "solver_order",
    label = as.character(parameters_master$name[which(parameters_master$id == 'solver_order')]),
    value = 3,
    min = 3
  )

solver_order_button <- helper(
  solver_order_button_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Solver Order",
  content = paste(
    as.character(parameters_master$id[which(parameters_master$id == 'solver_order')]),
    ": ",
    as.character(parameters_master$description[which(parameters_master$id == 'solver_order')])
  )
)


runid_textBox_element <- textInput(inputId = "runid",
                                   label = "Run ID",
                                   value = "")

runid_out_text <- textOutput("text_runid")

runid_textBox <- helper(
  runid_textBox_element,
  icon = "question-circle",
  colour = helper_Color,
  type = "inline",
  title = "Run ID",
  content = "A string, with a maximum of 5 characters, that is unique for each run."
)


runid_action_button <- actionButton(
  inputId = "enter_runid",
  label = "Submit Run ID",
  width = '250px',
  class = "actButton"
)

initial_population_button_element <-
  numericInput(
    inputId = "initial_population",
    label = as.character(parameters_master$name[which(parameters_master$name == 'Initial population')]),
    value = 100,
    min = 10
  )


initial_population_button <-
  helper(
    initial_population_button_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Initial Population",
    content = paste(
      as.character(parameters_master$id[which(parameters_master$name == 'Initial population')]),
      ": ",
      as.character(parameters_master$description[which(parameters_master$name == 'Initial population')])
    )
  )


select_initial_distribution_button_element <-
  selectInput(
    inputId = "initial_distribution",
    label = "Select Initial Distribution",
    choices = c("None Selected",
                "Uniform",
                "Predetermined")
  )


select_initial_distribution_button <-
  helper(
    select_initial_distribution_button_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Initial Distribution",
    content = "Select type of initial distribution."
  )


download_predeterminedDist_button_element <-
  downloadButton(
    outputId = "download_predetermined_dist",
    label = "Get template",
    width = '125px',
    class = "download_Button"
  )


download_predeterminedDist_button <-
  helper(
    download_predeterminedDist_button_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Download Predetermined Distribution",
    content = "Open template file for entering predetermined initial distributions."
  )


upload_predeterminedDist_button_element <-
  fileInput(
    inputId = "upload_predetermined_dist",
    label = NULL,
    accept = c("text/csv", "text/comma-separated-values,text/plain", ".csv"),
    width = '400px',
    buttonLabel = "Upload Predetermined Distribution",
    placeholder = "No file selected"
  )


upload_predeterminedDist_button <-
  helper(
    upload_predeterminedDist_button_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Upload Predetermined Distribution",
    content = "Load existing file with predetermined initial distributions into memory."
  )


run_simulations_button <- actionButton(
  inputId = "run_simulations",
  label = "Run Simulation(s)",
  width = '250px',
  class = "actButton"
)

run_simulations_text <- textOutput("run_simulations_message")


####################################################################################################
#  Results
####################################################################################################
check_boxes_all_results <-
  checkboxInput("All_Results", "Select All/None", value = FALSE)

list_scenarios_results <- list()
check_boxes_scenarios_results <-
  checkboxGroupInput(
    "Check_Scenario_Names_Results",
    "Select name(s):",
    width = '400px',
    selected = list_scenarios_results,
    choiceNames = list_scenarios_results,
    choiceValues = list_scenarios_results
  )

scenarios_summary_results_button <-
  actionButton(
    inputId = "summary_results_table",
    label = "View",
    class = "actButtonD1"
  )

clear_scenarios_summary_results_button <-
  actionButton(
    inputId = "clear_scenarios_summary_results",
    label = "Clear",
    width = '75px',
    style = "color: #fff; background-color: orange; border-color: #2e6da4;"
  )

plot_clear_summary_results_button <-
  switchInput(
    inputId = "plot_clear_summary_results_table",
    label = "View",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )


export_summaryResults_button <-
  actionButton(
    inputId = "export_summaryResults_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

summaryResults_modal_window <- bsModal(
  id = "summaryResultsPopup",
  title = "Summary Results Table",
  trigger = "export_summaryResults_modal",
  size = "large",
  textOutput("textMessageSummaryResults"),
  DT::dataTableOutput("plotSummaryResults"),
  downloadButton(
    outputId = 'downloadPlotSummaryResults',
    label = 'Download',
    class = "download_Button"
  )
)


plot_clear_dailyPopulation_button <-
  switchInput(
    inputId = "plot_clear_dailyPopulation",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

export_dailyPopulation_button <-
  actionButton(
    inputId = "export_dailyPopulation_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )


dailyPopulation_modal_window <-
  bsModal(
    id = "dailyPopulationPopup",
    title = "Daily Population",
    trigger = "export_dailyPopulation_modal",
    size = "large",
    textOutput("textMessageDailyPopulation"),
    plotOutput("plotDailyPopulation"),
    downloadButton(
      outputId = 'downloadPlotDailyPopulation',
      label = 'Download',
      class = "download_Button"
    )
  )


plot_clear_populationBiomass_button <-
  switchInput(
    inputId = "plot_clear_populationBiomass",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

export_populationBiomass_button <-
  actionButton(
    inputId = "export_populationBiomass_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

populationBiomass_modal_window <-
  bsModal(
    id = "populationBiomassPopup",
    title = "Population Biomass",
    trigger = "export_populationBiomass_modal",
    size = "large",
    textOutput("textMessagePopulationBiomass"),
    plotOutput("plotPopulationBiomass"),
    downloadButton(
      outputId = 'downloadPlotPopulationBiomass',
      label = 'Download',
      class = "download_Button"
    )
  )


plot_clear_meanSize_button <-
  switchInput(
    inputId = "plot_clear_meanSize",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

export_meanSize_button <-
  actionButton(
    inputId = "export_meanSize_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )

meanSize_modal_window <- bsModal(
  id = "meanSizePopup",
  title = "Mean Size",
  trigger = "export_meanSize_modal",
  size = "large",
  textOutput("textMessageMeanSize"),
  plotOutput("plotMeanSize"),
  downloadButton(
    outputId = 'downloadPlotMeanSize',
    label = 'Download',
    class = "download_Button"
  )
)


plot_clear_growthPotential_button <-
  switchInput(
    inputId = "plot_clear_growthPotential",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

export_growthPotential_button <-
  actionButton(
    inputId = "export_growthPotential_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )


growthPotential_modal_window <- bsModal(
  id = "growthPotentialPopup",
  title = "Growth Potential",
  trigger = "export_growthPotential_modal",
  size = "large",
  textOutput("textMessageGrowthPotential"),
  plotOutput("plotGrowthPotential"),
  downloadButton(
    outputId = 'downloadPlotGrowthPotential',
    label = 'Download',
    class = "download_Button"
  )
)


plot_clear_transitionalKernel_button <-
  switchInput(
    inputId = "plot_clear_transitionalKernel",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

export_transitionalKernel_button <-
  actionButton(
    inputId = "export_transitionalKernel_modal",
    label = NULL,
    class = "actButtonD1",
    icon = icon("download")
  )


transitionalKernel_modal_window <-
  bsModal(
    id = "transitionalKernelPopup",
    title = "Transitional Kernel",
    trigger = "export_transitionalKernel_modal",
    size = "large",
    textOutput("textMessageTransitionalKernel"),
    plotOutput("plotTransitionalKernel"),
    downloadButton(
      outputId = 'downloadPlotTransitionalKernel',
      label = 'Download',
      class = "download_Button"
    )
  )


plot_clear_summary_matrix_button <-
  switchInput(
    inputId = "plot_clear_summary_matrix",
    label = "Plot",
    value = FALSE,
    onStatus = "danger",
    offStatus = "info",
    size = "large",
    width = NULL
  )

export_matrix_button <-
  actionButton(
    inputId = "export_summaryMatrix_modal",
    label = "Plot",
    class = "actButtonD1",
    icon = icon("download")
  )

matrix_modal_window <- bsModal(
  id = "summaryMatrixPopup",
  title = "Summary Matrix",
  trigger = "export_summaryMatrix_modal",
  size = "large",
  textOutput("textMessageSummaryMatrix"),
  plotOutput("plotSummaryMatrix"),
  downloadButton(
    outputId = 'downloadPlotSummaryMatrix',
    label = 'Download',
    class = "download_Button"
  )
)


export_summaryMatrixTable_button <-
  actionButton(
    inputId = "export_summaryMatrixTable_modal",
    label = "Table",
    class = "actButtonD1",
    icon = icon("download")
  )


matrixTable_modal_window <- bsModal(
  id = "summaryMatrixTablePopup",
  title = "Summary Matrix Table",
  trigger = "export_summaryMatrixTable_modal",
  size = "large",
  textOutput("textMessageSummaryMatrixTable"),
  DT::dataTableOutput("plotSummaryMatrixTable"),
  downloadButton(
    outputId = 'downloadPlotSummaryMatrixTable',
    label = 'Download',
    class = "download_Button"
  )
)


export_results_report_button_element <-
  downloadButton(
    outputId = "Download_Results_Report",
    label = "Results",
    class = "download_Button"
  )


export_results_report_button <-
  helper(
    export_results_report_button_element,
    icon = "question-circle",
    colour = helper_Color,
    type = "inline",
    title = "Export Results Report",
    content = "Creates an excel workbook with all data and information for the currently selected scenario results."
  )


export_results_markdown_button <-
  actionButton(
    inputId = "show_results_markdown_modal",
    label = "Markdown",
    width = "100%",
    class = "actButtonD1"
  )

results_markdown_modal_window <- bsModal(
  id = "results_markdown_Popup",
  title = "Results",
  trigger = "show_results_markdown_modal",
  size = "large",
  tags$head(tags$style("#results_markdown_Popup .modal-footer{ display:none}")),
  uiOutput("results_markdown"),
  downloadButton(
    outputId = "downloadResultsMarkdown",
    label = "Download",
    class = "download_Button"
  )
)


delete_results_button <- actionButton(inputId = "Delete_Results",
                                      label = "Delete Results",
                                      class = "actButton")


delete_results_modal_window <- bsModal(
  id = "DeleteResultsPopup",
  title = "Delete Results",
  trigger = "Delete_Results",
  size = "large",
  verbatimTextOutput("textMessageDeleteResults"),
  fluidRow(
    column(
      width = 8,
      actionButton(
        inputId = 'actionDeleteResults',
        label = 'Delete and Confirm',
        width = '200px',
        class = "actButton"
      )
    ),
    column(
      width = 2,
      offset = 1,
      modalButton(label = "Close")
    )
  ),
  tags$head(
    tags$style("#DeleteResultsPopup .modal-footer{display:none}")
  )
)

import_results_button <- actionButton(inputId = "Import_Results",
                                      label = "Import Results",
                                      class = "actButton")


####################################################################################################
#  Reset/Clear App
####################################################################################################
reset_clear_button <- actionButton(inputId = "reset_clear_app",
                                   label = "Reset App",
                                   class = "actButton")
