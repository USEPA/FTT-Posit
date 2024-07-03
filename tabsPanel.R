source("SubTabs_Panel.R", local = TRUE)

tabHome <- tabPanel(
  "About",
  div(
    img(
      src = 'ft_logov01beta.png',
      width = 300,
      halign = "center"
    ),
    style = "text-align: center;"
  ),
  
  h2("What is the Fish Toxicity Translator?"),
  h4(
    'The Fish Toxicity Translator is a model that translates acute and chronic effects of
                         chemical exposures to population level impacts for a specified life history and
                         chemical exposure profile.  Annual simulations are created by building stressor scenarios that include daily dynamics. Results focus on comparison of stressor scenarios to baseline scenarios.'
  ),
  tags$ul(h5(
    tags$li(
      'The Fish Toxicity Translator works by introducing stressor scenarios to an underlying annual baseline life history model'
    )
  ), h5(tags$li(
    paste(
      'The model has a built-in parameterization for Fathead minnow (P. promelas) life history and can be parameterized for other species using the available Species Life History Template',
      sep = ""
    )
  )), h5(
    tags$li(
      'Non-chemical stressors can also be modeled and overlaid on baseline or chemical stressor scenarios.  The current non-chemical stressors included in the model are (1) Over-winter growth and survival and (2) Density-dependent growth effects'
    )
  ), h5(
    tags$li(
      'Model outputs include a variety of daily population metrics including:
                                 number of individuals, total biomass, average size, and daily minimum and maximum population growth potential. Annual population metrics include asymtotic population growth rate (lambda) and annual maximum growth potential to estimate long term effects of exposure'
    )
  )),
  h2("Fish Toxicity Translator Workflow"),
  div(
    img(
      src = 'workflow_diagram_2.png',
      width = 729,
      halign = "center"
    ),
    style = "text-align: center;"
  ),
  h2("Contact Information"),
  h5(
    "This beta version of the graphical user interface and model is undergoing continuous development.  Please do not hesitate to contact Nate Pollesch (pollesch.nathan@epa.gov) or Matthew Etterson (etterson.matthew@epa.gov) with any questions."
  )
)

tab1 <- tabPanel(
  "Scenario Builder",
  
  div(
    helper(
      shiny_tag = h3("Scenario Builder"),
      icon = "question-circle",
      colour = helper_Color,
      type = "inline",
      title = "Scenario Builder",
      content = GUI_Tooltip[GUI_Tooltip$Name == "Scenario Builder", ]$tooltip
    ),
    style = 'width:200px'
  ),
  
  tabsetPanel(subtab1, subtab2, subtab3, subtab4, subtab5, id = "tabsetPanel_scenarios")
)


tab2 <- tabPanel(
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
          h4("Visualize: Growth, Survival, and Reproduction"),
          hr(),
          day_selection_button,
          h4(""),
          slider_parameters_button,
          h4(""),
          br(),
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
          br(),
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
          h4(""),
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
        h4("Visualize: Scenario Parameters"),
        hr(),
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
      
      growth_modal_window,
      
      shinyjs::hidden(div(
        id = "Survival_out_Main", plotOutput(outputId = "Survival_out")
      )),
      
      survival_modal_window,
      
      shinyjs::hidden(div(
        id = "Reproduction_out_Main", plotOutput(outputId = "Reproduction_out")
      )),
      
      reproduction_modal_window,
      
      shinyjs::hidden(div(
        id = "SpawningProb_out_Main", plotOutput(outputId = "SpawningProb_Out")
      )),
      
      spawning_modal_window,
      
      shinyjs::hidden(div(
        id = "SurvivalDecrement_out_Main", plotOutput(outputId = "SurvivalDecrement_out")
      )),
      
      survivalDecrement_modal_window,
      
      shinyjs::hidden(div(
        id = "GrowthPercents_out_Main", plotOutput(outputId = "GrowthPercents_out")
      )),
      
      growthPercents_modal_window,
      
      shinyjs::hidden(div(
        id = "ExposureConcentration_out_Main", plotOutput(outputId = "ExposureConcentration_out")
      )),
      
      expousureConcentration_modal_window,
      
      width = 8
    )
    
  )
)


tab3 <- tabPanel(
  "Run Scenarios",
  
  div(
    helper(
      shiny_tag = h3("Run Scenarios"),
      icon = "question-circle",
      colour = helper_Color,
      type = "inline",
      title = "Run Scenarios",
      content = "Choose the model scenarios you would like to simulate. Initial conditions and computational parameters are input below."
    ),
    style = 'width:180px'
  ),
  
  sidebarLayout(
    sidebarPanel(
      shinyjs::hidden(
        div(id = "HideAddSimulationRunButton", add_simulation_run_button, br())
      ),
      
      shinyjs::hidden(
        div(
          id = "Run_Scenarios_Options",
          check_boxes_all_runs,
          br(),
          check_boxes_Scenarios_Run,
          br(),
          runid_textBox,
          br(),
          runid_action_button,
          br(),
          runid_out_text,
          br()
        )
      ),
      
      shinyjs::hidden(
        div(
          id = "Run_Parameters_Distributions",
          h4("Computational Parameters"),
          "Default computational parameters are recommended, altering these values may result in numerical inaccuracies or increased simulation run times.",
          br(),
          br(),
          num_size_classes_button,
          
          br(),
          solver_order_button,
          
          br(),
          h4("Initial conditions and simulation parameters"),
          select_initial_distribution_button,
          
          conditionalPanel(condition = "input.initial_distribution == 'Predetermined'", fluidRow(
            column(
              width = 12,
              upload_predeterminedDist_button,
              download_predeterminedDist_button
            )
          )),
          
          conditionalPanel(condition = "input.initial_distribution == 'Uniform'", initial_population_button)
        )
      ),
      
      shinyjs::hidden(
        div(id = "run_simulations_section", run_simulations_button, br())
      )
    ),
    
    mainPanel(shinyjs::hidden(
      div(
        id = "Predetermined_Initial_Distribution_Main",
        plotOutput(outputId = "Predetermined_Initial_Distribution_out")
      )
    ))  # Main Panel closing bracket
  )    # sidebarLayout closing bracket
  
)    # Tab Panel closing bracket



tab4 <- tabPanel(
  "Results",
  
  div(
    helper(
      shiny_tag = h3("Results"),
      icon = "question-circle",
      colour = helper_Color,
      type = "inline",
      title = "Results",
      content = "In the results step, model outputs are visualized and compared.  Numerical text-based summaries of model outputs are produced as well as a variety of visualizations to explore model behavior across scenarios and within a single modeled scenario."
    ),
    style = 'width:100px'
  ),
  
  tabsetPanel(subtab41, subtab42, subtab43, subtab44)
  
)

tab5 <- tabPanel(
  "Reset/Clear App",
  
  div(
    helper(
      shiny_tag = h3("Reset"),
      icon = "question-circle",
      colour = helper_Color,
      type = "inline",
      title = "Reset App",
      content = "The reset/clear tab contains a button that will remove all scenarios and results currently stored in memory and will restore the app to its original state."
    ),
    style = 'width:90px'
  ),
  
  reset_clear_button,
  h4(""),
  verbatimTextOutput("textMessageResetApp"),
  tags$head(tags$style(
    HTML("#textMessageResetApp {font-size: 20px;}")
  ))
)
