# Observe Events associated with the Results tab
observe({
  updateCheckboxGroupInput(session,
                           "Check_Scenario_Names_Results",
                           choices = as.list(names(unlist(modelRuns, recursive = F))),
                           selected = if(input$All_Results) as.list(names(unlist(modelRuns, recursive = F))))
  
  })

observe({
  if (is.null(input$Check_Scenario_Names_Results))
  {
    shinyjs::disable(id = "Download_Results_Report")
    shinyjs::disable(id = "show_results_markdown_modal")
    shinyjs::hide(id = "summaryMatrix_out_Main")
    shinyjs::hide(id = "scenario_summary_results_main")
    updateSwitchInput(session, 
                      inputId = "plot_clear_summary_matrix",
                      value = FALSE)
    updateSwitchInput(session, 
                      inputId = "plot_clear_summary_results_table",
                      value = FALSE)
    updateSwitchInput(session, 
                      inputId = "plot_clear_dailyPopulation",
                      value = FALSE)
    updateSwitchInput(session, 
                      inputId = "plot_clear_populationBiomass",
                      value = FALSE)
    updateSwitchInput(session, 
                      inputId = "plot_clear_meanSize",
                      value = FALSE)
    updateSwitchInput(session, 
                      inputId = "plot_clear_growthPotential",
                      value = FALSE)
    updateSwitchInput(session, 
                      inputId = "plot_clear_transitionalKernel",
                      value = FALSE)
  }else if (length(input$Check_Scenario_Names_Results) == 1)
  {
    SelectedSimulationRunScenarios <<- input$Check_Scenario_Names_Results
    shinyjs::enable(id = "Download_Results_Report")
    shinyjs::enable(id = "show_results_markdown_modal")
    shinyjs::hide(id = "summaryMatrix_out_Main")
    if (summaryMatrix_flag == TRUE)
    {
      shinyjs::info("You must select at least 2 scenarios. If only one scenario was simulated and as a result only one is active, you won't be able to display a summary matrix.")
      summaryMatrix_flag <- FALSE
    }
    updateSwitchInput(session, 
                      inputId = "plot_clear_summary_matrix",
                      value = FALSE)
  }else
  {
    SelectedSimulationRunScenarios <<- input$Check_Scenario_Names_Results
    shinyjs::enable(id = "Download_Results_Report")
    shinyjs::enable(id = "show_results_markdown_modal")
  }
})


observeEvent(input$summary_results_table,
  {
    
    if (is.null(input$Check_Scenario_Names_Results))
    {
      shinyjs::info("Error: no scenarios were selected. Please select one or more scenarios.")
      return(10)
    }else
    {
      SelectedSimulationRunScenarios <<- input$Check_Scenario_Names_Results
      output$scenario_summary_results_table <- DT::renderDataTable(
        {
          return_summary_results_table(input$Check_Scenario_Names_Results)
          
        },
        options = list(
          scrollX = TRUE
        )
      )
      shinyjs::show(id = "scenario_summary_results_main")
    }
    
  }
)

observeEvent(input$plot_clear_summary_results_table,
             {
               if (input$plot_clear_summary_results_table)
               {
                 if (is.null(input$Check_Scenario_Names_Results))
                 {
                   shinyjs::hide(id = "scenario_summary_results_main")
                   updateSwitchInput(session, 
                                     inputId = "plot_clear_summary_results_table",
                                     value = FALSE)
                   shinyjs::info("Error: no scenarios were selected. Please select one or more scenarios.")
                 }else
                 {
                   SelectedSimulationRunScenarios <<- input$Check_Scenario_Names_Results
                   output$scenario_summary_results_table <- DT::renderDataTable(
                     {
                       return_summary_results_table(input$Check_Scenario_Names_Results)
                     },
                     options = list(
                       scrollX = TRUE
                     )
                   )
                   shinyjs::show(id = "scenario_summary_results_main")
                 }
               }else
               {
                 shinyjs::hide(id = "scenario_summary_results_main")
               }
               
             },
             ignoreInit = TRUE)

# This script contains observe Events for plotting results.
observeEvent(input$plot_dailyPopulation,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$dailyPopulation_out <- renderPlot(
                   {
                     plot_Daily_Population(input$Check_Scenario_Names_Results)
                   }
                 )
                 shinyjs::show(id = "dailyPopulation_out_Main")
               }
             }
)

observeEvent(input$plot_clear_dailyPopulation,
             {
               if (input$plot_clear_dailyPopulation)
               {
                 if (is.null(input$Check_Scenario_Names_Results))
                 {
                   shinyjs::hide(id = "dailyPopulation_out_Main")
                   updateSwitchInput(session, 
                                     inputId = "plot_clear_dailyPopulation",
                                     value = FALSE)
                   shinyjs::info("Error: no scenarios were selected. Please select one or more scenarios.")
                 }else
                 {
                   output$dailyPopulation_out <- renderPlot(
                     {
                       plot_Daily_Population(input$Check_Scenario_Names_Results)
                     }
                   )
                   shinyjs::show(id = "dailyPopulation_out_Main")
                 }
               }else
               {
                 shinyjs::hide(id = "dailyPopulation_out_Main")
               }
               
             },
             ignoreInit = TRUE)


observeEvent(input$plot_populationBiomass,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$populationBiomass_out <- renderPlot(
                   {
                     plot_Population_Biomass(input$Check_Scenario_Names_Results)
                   }
                 )
                 shinyjs::show(id = "populationBiomass_out_Main")
               }
             }
)

observeEvent(input$plot_clear_populationBiomass,
             {
               if (input$plot_clear_populationBiomass)
               {
                 if (is.null(input$Check_Scenario_Names_Results))
                 {
                   shinyjs::hide(id = "populationBiomass_out_Main")
                   updateSwitchInput(session, 
                                     inputId = "plot_clear_populationBiomass",
                                     value = FALSE)
                   shinyjs::info("Error: no scenarios were selected. Please select one or more scenarios.")
                 }else
                 {
                   output$populationBiomass_out <- renderPlot(
                     {
                       plot_Population_Biomass(input$Check_Scenario_Names_Results)
                     }
                   )
                   shinyjs::show(id = "populationBiomass_out_Main")
                 }
               }else
               {
                 shinyjs::hide(id = "populationBiomass_out_Main")
               }
               
             },
             ignoreInit = TRUE)


observeEvent(input$plot_meanSize,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$meanSize_out <- renderPlot(
                   {
                     plot_Mean_Size(input$Check_Scenario_Names_Results)
                   }
                 )
                 shinyjs::show(id = "meanSize_out_Main")
               }
             }
)

observeEvent(input$plot_clear_meanSize,
             {
               if (input$plot_clear_meanSize)
               {
                 if (is.null(input$Check_Scenario_Names_Results))
                 {
                   shinyjs::hide(id = "meanSize_out_Main")
                   updateSwitchInput(session, 
                                     inputId = "plot_clear_meanSize",
                                     value = FALSE)
                   shinyjs::info("Error: no scenarios were selected. Please select one or more scenarios.")
                 }else
                 {
                   output$meanSize_out <- renderPlot(
                     {
                       plot_Mean_Size(input$Check_Scenario_Names_Results)
                     }
                   )
                   shinyjs::show(id = "meanSize_out_Main")
                 }
               }else
               {
                 shinyjs::hide(id = "meanSize_out_Main")
               }
               
             },
             ignoreInit = TRUE)


observeEvent(input$plot_growthPotential,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$growthPotential_out <- renderPlot(
                   {
                     plot_Growth_Potential(input$Check_Scenario_Names_Results)
                   }
                 )
                 shinyjs::show(id = "growthPotential_out_Main")
               }
             }
)

observeEvent(input$plot_clear_growthPotential,
             {
               if (input$plot_clear_growthPotential)
               {
                 if (is.null(input$Check_Scenario_Names_Results))
                 {
                   shinyjs::hide(id = "growthPotential_out_Main")
                   updateSwitchInput(session, 
                                     inputId = "plot_clear_growthPotential",
                                     value = FALSE)
                   shinyjs::info("Error: no scenarios were selected. Please select one or more scenarios.")
                 }else
                 {
                   output$growthPotential_out <- renderPlot(
                     {
                       plot_Growth_Potential(input$Check_Scenario_Names_Results)
                     }
                   )
                   shinyjs::show(id = "growthPotential_out_Main")
                 }
               }else
               {
                 shinyjs::hide(id = "growthPotential_out_Main")
               }
               
             },
             ignoreInit = TRUE)


observeEvent(input$plot_transitionalKernel,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 shinyjs::info("Please select one or more scenarios.")
               }else
               {
                 output$transitionalKernel_out <- renderPlot(
                   {
                     plot_Transitional_Kernel(input$Check_Scenario_Names_Results)
                   }
                 )
                 shinyjs::show(id = "transitionalKernel_out_Main")
               }
             }
)

observeEvent(input$plot_clear_transitionalKernel,
             {
               if (input$plot_clear_transitionalKernel)
               {
                 if (is.null(input$Check_Scenario_Names_Results))
                 {
                   shinyjs::hide(id = "transitionalKernel_out_Main")
                   updateSwitchInput(session, 
                                     inputId = "plot_clear_transitionalKernel",
                                     value = FALSE)
                   shinyjs::info("Error: no scenarios were selected. Please select one or more scenarios.")
                 }else
                 {
                   output$transitionalKernel_out <- renderPlot(
                     {
                       plot_Transitional_Kernel(input$Check_Scenario_Names_Results)
                     }
                   )
                   shinyjs::show(id = "transitionalKernel_out_Main")
                 }
               }else
               {
                 shinyjs::hide(id = "transitionalKernel_out_Main")
               }
               
             },
             ignoreInit = TRUE)


observeEvent(input$plot_summaryMatrix, 
             {
               if (length(input$Check_Scenario_Names_Results) >= 2)
               {
                 
                 shinyjs::show(id = "summaryMatrix_out_Main")
                 
               }else
               {
                 shinyjs::hide(id = "summaryMatrix_out_Main")
                 error_message <- "You must select at least 2 scenarios. If only one scenario was simulated and as a result only one is active, you won't be able to display a summary matrix."
                 shinyjs::info(error_message)
               }
             }
)

observeEvent(input$plot_clear_summary_matrix,
             {
               if (input$plot_clear_summary_matrix)
               {
                 if (is.null(input$Check_Scenario_Names_Results))
                 {
                   shinyjs::hide(id = "summaryMatrix_out_Main")
                   updateSwitchInput(session, 
                                     inputId = "plot_clear_summary_matrix",
                                     value = FALSE)
                   error_message <- "You must select at least 2 scenarios. If only one scenario was simulated and as a result only one is active, you won't be able to display a summary matrix."
                   shinyjs::info(error_message)
                 }else if (length(input$Check_Scenario_Names_Results) == 1)
                 {
                   shinyjs::hide(id = "summaryMatrix_out_Main")
                   updateSwitchInput(session, 
                                     inputId = "plot_clear_summary_matrix",
                                     value = FALSE)
                   error_message <- "You must select at least 2 scenarios. If only one scenario was simulated and as a result only one is active, you won't be able to display a summary matrix."
                   shinyjs::info(error_message)
                 }else
                 {
                   shinyjs::show(id = "summaryMatrix_out_Main")
                 }
               }else
               {
                 shinyjs::hide(id = "summaryMatrix_out_Main")
                 updateSwitchInput(session, 
                                   inputId = "plot_clear_summary_matrix",
                                   value = FALSE)
               }
               
             },
             ignoreInit = TRUE)

output$summaryMatrix_out <- renderPlot(
  {
    if (length(input$Check_Scenario_Names_Results) < 2)
    {
      shinyjs::hide(id = "summaryMatrix_out_Main")
      shinyjs::info("You must select at least 2 scenarios. If only one scenario was simulated and as a result only one is active, you won't be able to display a summary matrix.")
    }else{
      plot_Summary_Matrix(input$Check_Scenario_Names_Results)
    }
  }
)


#####################################################################################################
# Clear plots events
#####################################################################################################
observeEvent(input$clear_scenarios_summary_results,
             {
               shinyjs::hide(id = "scenario_summary_results_main")
             }
)

observeEvent(input$clear_dailyPopulation,
             {
               shinyjs::hide(id = "dailyPopulation_out_Main")
             }
)

observeEvent(input$clear_populationBiomass,
             {
               shinyjs::hide(id = "populationBiomass_out_Main")
             }
)

observeEvent(input$clear_meanSize,
             {
               shinyjs::hide(id = "meanSize_out_Main")
             }
)

observeEvent(input$clear_growthPotential,
             {
               shinyjs::hide(id = "growthPotential_out_Main")
             }
)

observeEvent(input$clear_transitionalKernel,
             {
               shinyjs::hide(id = "transitionalKernel_out_Main")
             }
)

observeEvent(input$clear_matrix,
             {
               shinyjs::hide(id = "summaryMatrix_out_Main")
               summaryMatrix_flag <- FALSE
             }
)

####################################################################################################
# Download Summary Matrix Data and Summary Results as CSV files.
####################################################################################################
# Downloadable csv of selected dataset
output$Summary_Matrix_Data.csv <- downloadHandler(
  filename = function() {
    paste("Summary_Matrix_Data-", Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    # summMats <- as.data.frame(SummaryMatrix(modelOutputs))
    summMats <- SummaryMatrix(unlist(modelRuns,recursive=F)[inputScenariosForResults])
    write.csv(summMats, file, row.names = FALSE)
  }
)

# Downloadable csv of selected dataset
output$Summary_Results_Table.csv <- downloadHandler(
  filename = function() {
    paste("Summary_Results_Table-", Sys.Date(), ".csv", sep = "")
  },
  content = function(file) {
    summaryTable <- as.data.frame(SummaryTable(modelOutputs))
    write.csv(summaryTable, file, row.names = FALSE)
  }
)

####################################################################################################
# Modal windows
####################################################################################################
# Summary Results Table
observeEvent(input$export_summaryResults_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotSummaryResults <- NULL
                 output$textMessageSummaryResults <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotSummaryResults")
               }else
               {
                 output$textMessageSummaryResults <- NULL
                 shinyjs::enable(id = "downloadPlotSummaryResults")
                 output$plotSummaryResults <- DT::renderDataTable(
                   {
                     return_summary_results_table(input$Check_Scenario_Names_Results)
                               
                   },
                   options = list(scrollX = TRUE)
                 )
               }
             }
)

output$downloadPlotSummaryResults <- downloadHandler(
  filename <- function()
  {
    paste("Summary_Results_Table", "csv", sep = ".")
  },
  content = function(file) 
  {
    summaryTable <- as.data.frame(SummaryTable(modelOutputs))
    write.csv(summaryTable, file, row.names = FALSE)
  }
) 


# Summary Matrix
observeEvent(input$export_summaryMatrix_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotSummaryMatrix <- NULL
                 output$textMessageSummaryMatrix <- renderText(
                   {
                     paste("Please select two or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotSummaryMatrix")
                 summaryMatrix_flag <- FALSE
                 
               }else if (length(input$Check_Scenario_Names_Results) < 2)
               {
                 output$plotSummaryMatrix <- NULL
                 summaryMatrix_flag <- FALSE
                 output$textMessageSummaryMatrix <- renderText(
                   {
                     paste("You must select at least 2 scenarios.",
                           "If only one scenario was simulated and as a result only one is active, ",
                           "you won't be able to display a results matrix.")
                   }
                 )
               }else
               {
                 output$textMessageSummaryMatrix <- NULL
                 summaryMatrix_flag <- TRUE
                 shinyjs::enable(id = "downloadPlotSummaryMatrix")
                 output$plotSummaryMatrix <- renderPlot({
                   plot_Summary_Matrix(input$Check_Scenario_Names_Results)
                 }, height = function() {
                   session$clientData$output_plotSummaryMatrix_width*0.8
                 })
               }
             }
)

# Summary Matrix
output$SMatrix <- renderUI(
  {
    plotOutput("plotSummaryMatrix", height = "auto")
  }
)

output$downloadPlotSummaryMatrix <- downloadHandler(
  filename <- function()
  {
    paste("Summary_Matrix", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 4,
        height = input$shiny_height * 4,
        res = 300)
    plot_Summary_Matrix(input$Check_Scenario_Names_Results)
    dev.off()
  }
) 

observeEvent(input$export_summaryMatrixTable_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotSummaryMatrixTable <- NULL
                 output$textMessageSummaryMatrixTable <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export table.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotSummaryMatrixTable")
               }else if (length(input$Check_Scenario_Names_Results) < 2)
               {
                 output$plotSummaryMatrixTable <- NULL
                 output$textMessageSummaryMatrixTable <- renderText(
                   {
                     paste("You must select at least 2 scenarios.",
                           "If only one scenario was simulated and as a result only one is active, ",
                           "you won't be able to display a results matrix table.")
                   }
                 )
               }else
               {
                 output$textMessageSummaryMatrixTable <- NULL
                 shinyjs::enable(id = "downloadPlotSummaryMatrixTable")
                 output$plotSummaryMatrixTable <- DT::renderDataTable(
                   {
                     as.data.frame(SummaryMatrix(modelOutputs))
                   },
                   options = list(scrollX = TRUE)
                 )
               }
             }
)

output$downloadPlotSummaryMatrixTable <- downloadHandler(
  filename <- function()
  {
    paste("Summary_Matrix_Table", "csv", sep = ".")
  },
  content = function(file) 
  {
    summMats <- as.data.frame(SummaryMatrix(modelOutputs))
    write.csv(summMats, file, row.names = FALSE)
  }
) 

# Daily Population
observeEvent(input$export_dailyPopulation_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotDailyPopulation <- NULL
                 output$textMessageDailyPopulation <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotDailyPopulation")
               }else
               {
                 output$textMessageDailyPopulation <- NULL
                 shinyjs::enable(id = "downloadPlotDailyPopulation")
                 output$plotDailyPopulation <- renderPlot(
                   plot_Daily_Population(input$Check_Scenario_Names_Results)
                 )
               }
             }
)

output$downloadPlotDailyPopulation <- downloadHandler(
  filename <- function()
  {
    paste("Daily_Population", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Daily_Population(input$Check_Scenario_Names_Results)
    dev.off()
  }
) 

# Population Biomass
observeEvent(input$export_populationBiomass_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotPopulationBiomass <- NULL
                 output$textMessagePopulationBiomass <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotPopulationBiomass")
               }else
               {
                 output$textMessagePopulationBiomass <- NULL
                 shinyjs::enable(id = "downloadPlotPopulationBiomass")
                 output$plotPopulationBiomass <- renderPlot(
                   plot_Population_Biomass(input$Check_Scenario_Names_Results)
                 )
               }
             }
)

output$downloadPlotPopulationBiomass <- downloadHandler(
  filename <- function()
  {
    paste("Population_Biomass", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Population_Biomass(input$Check_Scenario_Names_Results)
    dev.off()
  }
) 

# Mean Size
observeEvent(input$export_meanSize_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotMeanSize <- NULL
                 output$textMessageMeanSize <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotMeanSize")
               }else
               {
                 output$textMessageMeanSize <- NULL
                 shinyjs::enable(id = "downloadPlotMeanSize")
                 output$plotMeanSize <- renderPlot(
                   plot_Mean_Size(input$Check_Scenario_Names_Results)
                 )
               }
             }
)

output$downloadPlotMeanSize <- downloadHandler(
  filename <- function()
  {
    paste("Mean_Size", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Mean_Size(input$Check_Scenario_Names_Results)
    dev.off()
  }
) 

# Growth Potential
observeEvent(input$export_growthPotential_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotGrowthPotential <- NULL
                 output$textMessageGrowthPotential <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotGrowthPotential")
               }else
               {
                 output$textMessageGrowthPotential <- NULL
                 shinyjs::enable(id = "downloadPlotGrowthPotential")
                 output$plotGrowthPotential <- renderPlot(
                   plot_Growth_Potential(input$Check_Scenario_Names_Results)
                 )
               }
             }
)

output$downloadPlotGrowthPotential <- downloadHandler(
  filename <- function()
  {
    paste("Growth_Potential", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Growth_Potential(input$Check_Scenario_Names_Results)
    dev.off()
  }
) 

# Transitional Kernel
observeEvent(input$export_transitionalKernel_modal,
             {
               if (is.null(input$Check_Scenario_Names_Results))
               {
                 output$plotTransitionalKernel <- NULL
                 output$textMessageTransitionalKernel <- renderText(
                   {
                     paste("Please select one or more scenarios before attempting to export a plot.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                 shinyjs::disable(id = "downloadPlotTransitionalKernel")
               }else
               {
                 output$textMessageTransitionalKernel <- NULL
                 shinyjs::enable(id = "downloadPlotTransitionalKernel")
                 output$plotTransitionalKernel <- renderPlot(
                   plot_Transitional_Kernel(input$Check_Scenario_Names_Results)
                 )
               }
             }
)

output$downloadPlotTransitionalKernel <- downloadHandler(
  filename <- function()
  {
    paste("Transitional_Kernel", "png", sep = ".")
  },
  content = function(file) 
  {
    png(file,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Transitional_Kernel(input$Check_Scenario_Names_Results)
    dev.off()
  }
) 

output$Download_Results_Report <- downloadHandler(
  filename <- function()
  {
      paste("Results_Report", "xlsx", sep = ".")
  },
  content = function(file) 
  {
      Results_Workbook <- xlsx::createWorkbook(type='xlsx')
      
      # Sheet 0: results information
      sheet_0 <- xlsx::createSheet(Results_Workbook, sheetName = "Results_report_information")
      list1 <- input$Check_Scenario_Names_Results
      len_list1 <- length(list1)
      num_cols <- max(length(list1), 9)
      rows  <- xlsx::createRow(sheet_0, rowIndex = 1:7)       # 7 rows
      cells <- xlsx::createCell(rows, colIndex = 1:num_cols)  # columns in each row
      xlsx::setCellValue(cells[[1,1]], "Results Report Information")          # put in Row 1, Column 1
      xlsx::setCellValue(cells[[2,1]], "Scenarios:")                          # put in Row 2, Column 1
      xlsx::setCellValue(cells[[3,1]], "Descriptions:")                       # put in Row 3, Column 1
      xlsx::setCellValue(cells[[4,1]], "Report Date/Time:")                   # put in Row 4, Column 1
      xlsx::setCellValue(cells[[5,1]], "Report contents")                     # put in Row 5, Column 1
      xlsx::setCellValue(cells[[6,1]], "Fish Toxicity Translator Version:")   # put in Row 6, Column 1
      xlsx::setCellValue(cells[[7,1]], "For more information visit:")         # put in Row 7, Column 1
      
      for (i in 1:len_list1)
      {
        j <- i + 1
        for (k in 1:length(runID))
        {
          str1 <- paste("^",runID[k], sep = "")
          if (grepl(str1, list1[[i]]))
          {
            k1 <- length(modelRunInfo[[runID[k]]]$modelRunScenarios)
            str2 <- modelRunInfo[[runID[k]]]$modelRunScenarios[k1]
            scenario_desc <- scenarioDescriptions[[str2]]
          }
        }
        
        xlsx::setCellValue(cells[[2,j]], list1[[i]])
        xlsx::setCellValue(cells[[3,j]], scenario_desc)
      }
      
      # Date of report
      xlsx::setCellValue(cells[[4,2]], date()) 
      
      # Report contents
      xlsx::setCellValue(cells[[5,2]], "Summary_Results_Table")
      if (length(input$Check_Scenario_Names_Results) >= 2)
      {
        xlsx::setCellValue(cells[[5,3]], "Summary_Matrix")
        xlsx::setCellValue(cells[[5,4]], "Summary_Matrix_Table")
        xlsx::setCellValue(cells[[5,5]], "Daily_Population_Image")
        xlsx::setCellValue(cells[[5,6]], "Population_Biomass_Image")
        xlsx::setCellValue(cells[[5,7]], "Mean_Size_Image")
        xlsx::setCellValue(cells[[5,8]], "Growth_Potential_Image")
        xlsx::setCellValue(cells[[5,9]], "Transition_Kernel_Image")
      }else{
        xlsx::setCellValue(cells[[5,3]], "Daily_Population_Image")
        xlsx::setCellValue(cells[[5,4]], "Population_Biomass_Image")
        xlsx::setCellValue(cells[[5,5]], "Mean_Size_Image")
        xlsx::setCellValue(cells[[5,6]], "Growth_Potential_Image")
        xlsx::setCellValue(cells[[5,7]], "Transition_Kernel_Image")
      }
      
      
      # Fish Toxicity Translator Package version number
      xlsx::setCellValue(cells[[6,2]], packageVersion("FishToxTranslator"))
      
      # Website
      xlsx::setCellValue(cells[[7,2]], "<link to website>")
      
      # Sheet 1: Summary Results Table
      summaryTable <- as.data.frame(SummaryTable(modelOutputs))
      sheet_1 <- xlsx::createSheet(Results_Workbook, sheetName = "Summary_Results_Table")
      xlsx::addDataFrame(summaryTable,
                         sheet = sheet_1, 
                         startRow = 1, 
                         startColumn = 1,
                         row.names = FALSE)
                   
      xlsx::setColumnWidth(sheet_1, colIndex = c(1:100), colWidth = 30)
      
      if (length(input$Check_Scenario_Names_Results) >= 2)
      {
        # Sheet 2: Summary Matrix Image
        sheet_2 <- xlsx::createSheet(Results_Workbook, sheetName = "Summary_Matrix")
        image_path1 <- tempfile(pattern = "", fileext = ".png")
        png(image_path1,
            width = input$shiny_width * 4,
            height = input$shiny_height * 4,
            res = 300)
        plot_Summary_Matrix(input$Check_Scenario_Names_Results)
        dev.off()
        addPicture(file = image_path1,
                   sheet = sheet_2, 
                   scale = 1, 
                   startRow = 4, 
                   startColumn = 4)
        
        # Sheet 3: Summary Matrix Table
        summMats <- as.data.frame(SummaryMatrix(modelOutputs))
        sheet_3 <- xlsx::createSheet(Results_Workbook, sheetName = "Summary_Matrix_Table")
        xlsx::addDataFrame(summMats,
                           sheet = sheet_3, 
                           startRow = 1, 
                           startColumn = 1,
                           row.names = FALSE)
                     
        xlsx::setColumnWidth(sheet_3, colIndex = c(1:100), colWidth = 30)
      }
      
      
      # Sheet 4: Daily Population Image
      sheet_4 <- xlsx::createSheet(Results_Workbook, sheetName = "Daily_Population_Image")
      image_path2 <- tempfile(pattern = "", fileext = ".png")
      png(image_path2,
          width = input$shiny_width * 2,
          height = input$shiny_height * 2,
          res = 300)
      plot_Daily_Population(input$Check_Scenario_Names_Results)
      dev.off()
      xlsx::addPicture(file = image_path2,
                       sheet = sheet_4, 
                       scale = 1, 
                       startRow = 4, 
                       startColumn = 4)
      
      # Sheet 5: Population Biomass Image
      sheet_5 <- xlsx::createSheet(Results_Workbook, sheetName = "Population_Biomass_Image")
      image_path3 <- tempfile(pattern = "", fileext = ".png")
      png(image_path3,
          width = input$shiny_width * 2,
          height = input$shiny_height * 2,
          res = 300)
      plot_Population_Biomass(input$Check_Scenario_Names_Results)
      dev.off()
      xlsx::addPicture(file = image_path3,
                       sheet = sheet_5, 
                       scale = 1, 
                       startRow = 4, 
                       startColumn = 4)
                 
      # Sheet 6: Mean Size Image
      sheet_6 <- xlsx::createSheet(Results_Workbook, sheetName = "Mean_Size_Image")
      image_path4 <- tempfile(pattern = "", fileext = ".png")
      png(image_path4,
          width = input$shiny_width * 2,
          height = input$shiny_height * 2,
          res = 300)
      plot_Mean_Size(input$Check_Scenario_Names_Results)
      dev.off()
      xlsx::addPicture(file = image_path4,
                       sheet = sheet_6, 
                       scale = 1, 
                       startRow = 4, 
                       startColumn = 4)
                 
      # Sheet 7: Growth Potential Image
      sheet_7 <- xlsx::createSheet(Results_Workbook, sheetName = "Growth_Potential_Image")
      image_path5 <- tempfile(pattern = "", fileext = ".png")
      png(image_path5,
          width = input$shiny_width * 2,
          height = input$shiny_height * 2,
          res = 300)
      plot_Growth_Potential(input$Check_Scenario_Names_Results)
      dev.off()
      xlsx::addPicture(file = image_path5,
                       sheet = sheet_7, 
                       scale = 1, 
                       startRow = 4, 
                       startColumn = 4)
                 
      # Sheet 8: Transition Kernel Image
      # sheet_8 <- xlsx::createSheet(Results_Workbook, sheetName = "Transition_Kernel_Image")
      # image_path6 <- tempfile(pattern = "", fileext = ".png")
      # png(image_path6,
      #     width = input$shiny_width * 2,
      #     height = input$shiny_height * 2,
      #     res = 300)
      # plot_Transitional_Kernel(input$Check_Scenario_Names_Results)
      # dev.off()
      # xlsx::addPicture(file = image_path6,
      #                  sheet = sheet_8, 
      #                  scale = 1, 
      #                  startRow = 4, 
      #                  startColumn = 4)
      
      xlsx::saveWorkbook(Results_Workbook,file)
    }
 
) 

################################################################################
#  Render R markdown document
################################################################################
generate_markdown <- reactive({
  req(input$Check_Scenario_Names_Results)
  # output$results_markdown <- NULL
  if (length(input$Check_Scenario_Names_Results) >= 1)
  {
    return(TRUE)
  }else 
  {
    return(FALSE)
  }
})
  
output$results_markdown <- renderUI(
  {
    if (generate_markdown() == TRUE)
    {
      path_rmd <- "Results_Report.Rmd"

      # Render into www folder.
      system.name <- Sys.info()[["sysname"]]
      path_html <- ifelse(system.name=="Windows", paste("www\\","Results_Report.html",sep = ""),paste("www/","Results_Report.html",sep = ""))
      render(
        path_rmd,
        output_format = "html_document",
        output_file = path_html,
        envir = new.env()
      )
      tags$iframe(
        style = "border-width: 0;",
        width = "100%",
        height = 1200,
        src = paste("Results_Report.html",sep = "")
        # Filename relative to the www/ folder.

      )
    }
  }
)

# outputOptions(output, "results_markdown", suspendWhenHidden = TRUE)

# observeEvent(input$close_markd_window,
#              {
#                output$results_markdown <- renderUI({})
#                on.exit(removeModal())
#              }
# )

# observeEvent(input$show_results_markdown_modal,
#              {
#                output$results_markdown <- renderUI(
#                  {
#                    path_rmd <- "Results_Report.Rmd"
#                    # Render into www/ folder.
#                    path_html <- "www\\Results_Report.html"
#                    render(
#                      path_rmd,
#                      output_file = path_html
#                    )
#                    tags$iframe(
#                      style = "border-width: 0;",
#                      width = "100%",
#                      height = 1200,
#                      # Filename relative to the www/ folder.
#                      src = basename(path_html)
#                    )
#                    
#                  }
#                )
#                
#              },ignoreInit = TRUE)



# R markdown
output$downloadResultsMarkdown <- downloadHandler(
  filename <- function()
  {
    paste("Results_Report", "pdf", sep = ".")
  },
  content = function(file) 
  {
    # src <- normalizePath('Species_Profile.Rmd')
    # owd <- setwd(tempdir())
    # on.exit(setwd(owd))
    # file.copy(src, 'Species_Profile.Rmd')
    # library(rmarkdown)
    # library(tinytex)
    # out <- render('Species_Profile.Rmd',pdf_document())
    # file.rename(out, file)
    system.name <- Sys.info()[["sysname"]]
    report_html <- "Results_Report.html"
    path_html <- ifelse(system.name=="Windows", paste("www\\",report_html,sep = ""), paste("www/",report_html,sep = ""))
    file.rename(html_to_pdf(file_path = path_html), file)
  }
) 
