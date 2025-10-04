source("sub_Results_VisualizeResults_ui.R")
source("sub_Results_ExportResults_ui.R")
source("sub_Results_ImportResults_ui.R")
source("sub_Results_DeleteResults_ui.R")

tabResults <- tabPanel(
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
  
  tabsetPanel(subVisualizeResults, subExportResults, subImportResults, subDeleteResults)
  
)