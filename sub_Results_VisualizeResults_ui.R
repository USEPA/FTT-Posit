################################################################################
#  HTML elements for the visualization of simulation results.
################################################################################
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
  tags$head(tags$style("#summaryMatrixPopup .modal-body{ min-height:800px}")),
  uiOutput("SMatrix"),
  textOutput("textMessageSummaryMatrix"),
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


export_results_report_button <-
  downloadButton(
    outputId = "Download_Results_Report",
    label = "Excel",
    class = "download_Button"
  )


export_results_markdown_button <-
  actionButton(
    inputId = "show_results_markdown_modal",
    label = "PDF",
    class = "actButtonD1",
    icon = icon("download")
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

results_markdown_modal_window <- tagAppendAttributes(results_markdown_modal_window,
                                                     class = "modal1class")


################################################################################
# Layout for the visualization of results.
################################################################################
subVisualizeResults <- tabPanel("Visualize Results", sidebarLayout(
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
      fluidRow(column(
        width = 12, fluidRow(column(
          width = 12,
          helper(
            shiny_tag = h4("Summary Results Table", class = "header4"),
            icon = "question-circle",
            colour = helper_Color,
            type = "inline",
            title = "Summary Results Table",
            content = GUI_Tooltip[GUI_Tooltip$Name == "Summary Results Table", ]$tooltip
          ),
        )), fluidRow(
          column(
            width = 6,
            align = "left",
            plot_clear_summary_results_button
          ),
          column(
            width = 6,
            align = "right",
            export_summaryResults_button
          )
        )
      )),
      
      br(),
      fluidRow(column(
        width = 12, fluidRow(column(
          width = 12,
          helper(
            shiny_tag = h4("Summary Matrix", class = "header4"),
            icon = "question-circle",
            colour = helper_Color,
            type = "inline",
            title = "Summary Matrix",
            content = GUI_Tooltip[GUI_Tooltip$Name == "Summary Matrix", ]$tooltip
          ),
        )), fluidRow(
          column(
            width = 4,
            align = "left",
            plot_clear_summary_matrix_button
          ),
          column(width = 4, align = "right", export_matrix_button),
          column(
            width = 4,
            align = "right",
            export_summaryMatrixTable_button
          )
        )
      )),
      
      br(),
      hr(),
      h4("View Selected Plots"),
      hr(),
      fluidRow(column(
        width = 12, fluidRow(column(
          width = 12,
          helper(
            shiny_tag = h4("Daily Population", class = "header4"),
            icon = "question-circle",
            colour = helper_Color,
            type = "inline",
            title = "Daily Population",
            content = GUI_Tooltip[GUI_Tooltip$Name == "Daily Population", ]$tooltip
          ),
        )), fluidRow(
          column(
            width = 6,
            align = "left",
            plot_clear_dailyPopulation_button
          ),
          column(
            width = 6,
            align = "right",
            export_dailyPopulation_button
          )
        )
      )),
      
      br(),
      fluidRow(column(
        width = 12, fluidRow(column(
          width = 12,
          helper(
            shiny_tag = h4("Population Biomass", class = "header4"),
            icon = "question-circle",
            colour = helper_Color,
            type = "inline",
            title = "Population Biomass",
            content = GUI_Tooltip[GUI_Tooltip$Name == "Population Biomass", ]$tooltip
          ),
        )), fluidRow(
          column(
            width = 6,
            align = "left",
            plot_clear_populationBiomass_button
          ),
          column(
            width = 6,
            align = "right",
            export_populationBiomass_button
          )
        )
      )),
      
      br(),
      fluidRow(column(
        width = 12, fluidRow(column(
          width = 12,
          helper(
            shiny_tag = h4("Mean Size", class = "header4"),
            icon = "question-circle",
            colour = helper_Color,
            type = "inline",
            title = "Mean Size",
            content = GUI_Tooltip[GUI_Tooltip$Name == "Mean Size", ]$tooltip
          ),
        )), fluidRow(
          column(
            width = 6,
            align = "left",
            plot_clear_meanSize_button
          ),
          column(width = 6, align = "right", export_meanSize_button)
        )
      )),
      
      br(),
      fluidRow(column(
        width = 12, fluidRow(column(
          width = 12,
          helper(
            shiny_tag = h4("Growth Potential", class = "header4"),
            icon = "question-circle",
            colour = helper_Color,
            type = "inline",
            title = "Growth Potential",
            content = GUI_Tooltip[GUI_Tooltip$Name == "Growth Potential", ]$tooltip
          ),
        )), fluidRow(
          column(
            width = 6,
            align = "left",
            plot_clear_growthPotential_button
          ),
          column(
            width = 6,
            align = "right",
            export_growthPotential_button
          )
        )
      )),
      
      br(),
      hr(),
      
      fluidRow(
        column(width = 4, align = "left", div(
          helper(
            shiny_tag = h4("Export Results", class = "header4"),
            icon = "question-circle",
            colour = helper_Color,
            type = "inline",
            title = "Export Results Report",
            content = "Create and download a report containing all of the data and information for the currently selected scenario results in PDF or Excel format."
          )
        )),
        column(
          width = 4,
          offset = 0,
          align = "right",
          export_results_markdown_button
        ),
        column(
          width = 4,
          offset = 0,
          align = "right",
          export_results_report_button
        )
      ),
      h4(""),
      results_markdown_modal_window
    )
  ), width = 4),
  
  mainPanel
  (
    shinyjs::hidden(
      div(id = "scenario_summary_results_main", DT::dataTableOutput("scenario_summary_results_table"))
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
      id = "dailyPopulation_out_Main", plotOutput(outputId = "dailyPopulation_out")
    )),
    
    dailyPopulation_modal_window,
    
    shinyjs::hidden(div(
      id = "populationBiomass_out_Main", plotOutput(outputId = "populationBiomass_out")
    )),
    
    populationBiomass_modal_window,
    
    shinyjs::hidden(div(
      id = "meanSize_out_Main", plotOutput(outputId = "meanSize_out")
    )),
    
    meanSize_modal_window,
    
    shinyjs::hidden(div(
      id = "growthPotential_out_Main", plotOutput(outputId = "growthPotential_out")
    )),
    
    growthPotential_modal_window,
    
    shinyjs::hidden(div(
      id = "transitionalKernel_out_Main", plotOutput(outputId = "transitionalKernel_out")
    )),
    
    transitionalKernel_modal_window,
    
    width = 8
  )
))
