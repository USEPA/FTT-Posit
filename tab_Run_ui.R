################################################################################
# HTML elements for the running of simulations.
################################################################################
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

################################################################################
# Layout for the running of simulations.
################################################################################
tabRunScenarios <- tabPanel(
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
