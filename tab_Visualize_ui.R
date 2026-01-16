##################################################################################################
# HTML elements for the visualization of scenarios.
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

dGF_button <-   downloadButton(
  outputId = 'downloadPlotGrowth',
  label = 'Download',
  class = "download_Button"
)

# growth_modal_window <- bsModal(
#   id = "growthPopup",
#   title = "Growth Functions",
#   trigger = "export_growth_modal",
#   size = "large",
#   textOutput("textMessageGrowth"),
#   plotOutput("plotGrowth"),
#   downloadButton(
#     outputId = 'downloadPlotGrowth',
#     label = 'Download',
#     class = "download_Button"
#   )
# )

dSF_button <-   downloadButton(
  outputId = 'downloadPlotSurvival',
  label = 'Download',
  class = "download_Button"
)

# survival_modal_window <- bsModal(
#   id = "survivalPopup",
#   title = "Survival Functions",
#   trigger = "export_survival_modal",
#   size = "large",
#   textOutput("textMessageSurvival"),
#   plotOutput("plotSurvival"),
#   downloadButton(
#     outputId = 'downloadPlotSurvival',
#     label = 'Download',
#     class = "download_Button"
#   )
# )

dRF_button <-   downloadButton(
  outputId = 'downloadPlotReproduction',
  label = 'Download',
  class = "download_Button"
)

# reproduction_modal_window <- bsModal(
#   id = "reproductionPopup",
#   title = "Reproduction Functions",
#   trigger = "export_reproduction_modal",
#   size = "large",
#   textOutput("textMessageReproduction"),
#   plotOutput("plotReproduction"),
#   downloadButton(
#     outputId = 'downloadPlotReproduction',
#     label = 'Download',
#     class = "download_Button"
#   )
# )

dSPF_button <-   downloadButton(
  outputId = 'downloadPlotSpawning',
  label = 'Download',
  class = "download_Button"
)

# spawning_modal_window <- bsModal(
#   id = "spawningPopup",
#   title = "Spawning Probabilities",
#   trigger = "export_spawning_modal",
#   size = "large",
#   textOutput("textMessageSpawning"),
#   plotOutput("plotSpawning"),
#   downloadButton(
#     outputId = 'downloadPlotSpawning',
#     label = 'Download',
#     class = "download_Button"
#   )
# )

dSDF_button <-     downloadButton(
  outputId = 'downloadPlotSurvivalDecrement',
  label = 'Download',
  class = "download_Button"
)
  
# survivalDecrement_modal_window <-
#   bsModal(
#     id = "survivalDecrementPopup",
#     title = "Survival Decrements",
#     trigger = "export_survivalDecrement_modal",
#     size = "large",
#     textOutput("textMessageSurvivalDecrement"),
#     plotOutput("plotSurvivalDecrement"),
#     downloadButton(
#       outputId = 'downloadPlotSurvivalDecrement',
#       label = 'Download',
#       class = "download_Button"
#     )
#   )

dGPF_button <-   downloadButton(
  outputId = 'downloadPlotGrowthPercents',
  label = 'Download',
  class = "download_Button"
)

# growthPercents_modal_window <- bsModal(
#   id = "growthPercentsPopup",
#   title = "Growth Percents",
#   trigger = "export_growthPercents_modal",
#   size = "large",
#   textOutput("textMessageGrowthPercents"),
#   plotOutput("plotGrowthPercents"),
#   downloadButton(
#     outputId = 'downloadPlotGrowthPercents',
#     label = 'Download',
#     class = "download_Button"
#   )
# )


dEC_button <- downloadButton(
  outputId = 'downloadPlotExposureConcentration',
  label = 'Download',
  class = "download_Button"
)

# expousureConcentration_modal_window <-
#   bsModal(
#     id = "ExposureConcentrationPopup",
#     title = "Exposure Concentrations",
#     trigger = "export_exposureConcentration_modal",
#     size = "large",
#     textOutput("textMessageExpousureConcentration"),
#     plotOutput("plotExposureConcentration"),
#     downloadButton(
#       outputId = 'downloadPlotExposureConcentration',
#       label = 'Download',
#       class = "download_Button"
#     )
#   )


################################################################################
# Layout for visualization of scenarios.
################################################################################
tabVisualize <- tabPanel(
  "Visualize Scenarios",
  
  div(
    helper(
      shiny_tag = h3("Visualize Scenarios"),
      icon = "question-circle",
      colour = helper_Color,
      type = "inline",
      title = "Visualize Scenarios",
      content = "The visualization step allows you to compare scenarios before they are simulated.  Visualization options include daily differences in growth, reproduction, and survival functions and differences in exposures and associated effects by scenario.  Click and unclick built scenarios to include them in plots; various plots can be displayed and cleared for convenience."
    ),
    style = 'width:230px'
  ),
  
  sidebarLayout(
    sidebarPanel(
      shinyjs::hidden(
        div(
          id = "Visualization_GRS",
          check_boxes_all_scenarios,
          h4(""),
          check_boxes_Scenarios,
          h4(""),
          hr(),
          h4("Growth, survival, and reproduction by size for selected date"),
          fluidRow(
            column(
              width = 3,
              align = "left",
              day_selection_button
            ),
            column(style = "margin-top: 60px; margin-left: 0; font-size: 120%; font-weight: bold;",
                   width = 9,
                   align = "left",
                   slider_calendar_text_out
            )
          ),
          
          h4(""),
          slider_parameters_button,
          h4(""),
          fluidRow(column(
            width = 12, fluidRow(column(
              width = 12,
              helper(
                shiny_tag = h4("Growth Functions", class = "header4"),
                icon = "question-circle",
                colour = helper_Color,
                type = "inline",
                title = "Growth Functions",
                content = GUI_Tooltip[GUI_Tooltip$Name == "Growth Functions", ]$tooltip
              ),
            )), fluidRow(
              column(width = 6, align = "left", plot_clear_growth_button),
              column(
                width = 6,
                align = "right",
                export_growth_functions_button
              )
            )
          )),
          fluidRow(column(
            width = 12, fluidRow(column(
              width = 12,
              helper(
                shiny_tag = h4("Survival Functions", class = "header4"),
                icon = "question-circle",
                colour = helper_Color,
                type = "inline",
                title = "Survival Functions",
                content = GUI_Tooltip[GUI_Tooltip$Name == "Survival Functions", ]$tooltip
              ),
            )), fluidRow(
              column(
                width = 6,
                align = "left",
                plot_clear_survival_button
              ),
              column(
                width = 6,
                align = "right",
                export_survival_functions_button
              )
            )
          )),
          fluidRow(column(
            width = 12, fluidRow(column(
              width = 12,
              helper(
                shiny_tag = h4("Reproduction Functions", class = "header4"),
                icon = "question-circle",
                colour = helper_Color,
                type = "inline",
                title = "Reproduction Functions",
                content = GUI_Tooltip[GUI_Tooltip$Name == "Reproduction Functions", ]$tooltip
              ),
            )), fluidRow(
              column(
                width = 6,
                align = "left",
                plot_clear_reproduction_button
              ),
              column(
                width = 6,
                align = "right",
                export_reproduction_functions_button
              )
            )
          )),
          h4("")
        )
      ),
      shinyjs::hidden(div(
        id = "Visualization_SPB",
        hr(),
        h4("Scenario values by date"),
        fluidRow(column(
          width = 12, fluidRow(column(
            width = 12,
            helper(
              shiny_tag = h4("Spawning Probabilities", class = "header4"),
              icon = "question-circle",
              colour = helper_Color,
              type = "inline",
              title = "Spawning Probabilities",
              content = GUI_Tooltip[GUI_Tooltip$Name == "Spawning Probabilities", ]$tooltip
            ),
          )), fluidRow(
            column(
              width = 6,
              align = "left",
              plot_clear_spawning_probabilities_button
            ),
            column(
              width = 6,
              align = "right",
              export_spawning_functions_button
            )
          )
        )),
        h4("")
      )),
      
      shinyjs::hidden(
        div(
          id = "Visualization_SDEC",
          shinyjs::hidden(div(id = "Show_SDEC", fluidRow(
            column(width = 12, fluidRow(column(
              width = 12,
              helper(
                shiny_tag = h4("Survival Decrements", class = "header4"),
                icon = "question-circle",
                colour = helper_Color,
                type = "inline",
                title = "Survival Decrements",
                content = GUI_Tooltip[GUI_Tooltip$Name == "Survival Decrements", ]$tooltip
              ),
            )), fluidRow(
              column(
                width = 6,
                align = "left",
                plot_clear_survival_decrements_button
              ),
              column(
                width = 6,
                align = "right",
                export_survival_decrements_button
              )
            ))
          ))),
          h4(""),
          shinyjs::hidden(div(id = "Show_GP", fluidRow(
            column(width = 12, fluidRow(column(
              width = 12,
              helper(
                shiny_tag = h4("Growth Percents", class = "header4"),
                icon = "question-circle",
                colour = helper_Color,
                type = "inline",
                title = "Growth Percents",
                content = GUI_Tooltip[GUI_Tooltip$Name == "Growth Percents", ]$tooltip
              ),
            )), fluidRow(
              column(
                width = 6,
                align = "left",
                plot_clear_growth_percents_button
              ),
              column(
                width = 6,
                align = "right",
                export_growth_percents_button
              )
            ))
          ))),
          h4(""),
          fluidRow(column(
            width = 12, fluidRow(column(
              width = 12,
              helper(
                shiny_tag = h4("Exposure Concentrations", class = "header4"),
                icon = "question-circle",
                colour = helper_Color,
                type = "inline",
                title = "Exposure Concentrations",
                content = GUI_Tooltip[GUI_Tooltip$Name == "Exposure Concentrations", ]$tooltip
              ),
            )), fluidRow(
              column(
                width = 6,
                align = "left",
                plot_clear_exposure_concentrations_button
              ),
              column(
                width = 6,
                align = "right",
                export_exposure_concentrations_button
              )
            )
          )),
        )
      ),
      
      width = 4
    ),
    
    mainPanel
    (
      shinyjs::hidden(div(id = "Growth_out_Main", plotOutput(outputId = "Growth_out"))),
      
      # growth_modal_window,
      
      shinyjs::hidden(div(
        id = "Survival_out_Main", plotOutput(outputId = "Survival_out")
      )),
      
      # survival_modal_window,
      
      shinyjs::hidden(div(
        id = "Reproduction_out_Main", plotOutput(outputId = "Reproduction_out")
      )),
      
      # reproduction_modal_window,
      
      shinyjs::hidden(div(
        id = "SpawningProb_out_Main", plotOutput(outputId = "SpawningProb_Out")
      )),
      
      # spawning_modal_window,
      
      shinyjs::hidden(div(
        id = "SurvivalDecrement_out_Main", plotOutput(outputId = "SurvivalDecrement_out")
      )),
      
      # survivalDecrement_modal_window,
      
      shinyjs::hidden(div(
        id = "GrowthPercents_out_Main", plotOutput(outputId = "GrowthPercents_out")
      )),
      
      # growthPercents_modal_window,
      
      shinyjs::hidden(div(
        id = "ExposureConcentration_out_Main", plotOutput(outputId = "ExposureConcentration_out")
      )),
      
      # expousureConcentration_modal_window,
      
      width = 8
    )
    
  )
)