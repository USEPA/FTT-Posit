subExportResults <- tabPanel("Export Results", sidebarLayout(
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
        label = "Excel",
        class = "download_Button"
      )
    ))
  ),
  
  mainPanel()
))
