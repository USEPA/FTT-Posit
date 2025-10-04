source("sub_Build_Baseline_ui.R", local = TRUE)
source("sub_Build_Stressor_ui.R", local = TRUE)
source("sub_Build_ExportScenario_ui.R", local = TRUE)
source("sub_Build_ImportScenario_ui.R", local = TRUE)
source("sub_Build_DeleteScenario_ui.R", local = TRUE)

tabBuild <- tabPanel(
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
  
  tabsetPanel(subBaseline, subStressor, subExport, subImport, subDelete, id = "tabsetPanel_scenarios")
)