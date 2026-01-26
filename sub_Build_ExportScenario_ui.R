################################################################################
# HTML elements and layout for export-building scenario.
################################################################################
subExport <- tabPanel("Export Scenario", sidebarLayout(
  sidebarPanel(
    shinyjs::hidden(div(id = "HideExportScenarioButton", export_scenario_button)),
    
    shinyjs::hidden(div(
      id = "ExportScenarioButton",
      h4("Select scenario to export"),
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
        label = "Excel",
        class = "download_Button"
      )
    ))
    
  ),
  
  mainPanel()
))