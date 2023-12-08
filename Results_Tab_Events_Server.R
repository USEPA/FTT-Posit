# Observe Events associated with the Results tab
observe({
  updateCheckboxGroupInput(session,
                           "Check_Scenario_Names_Results",
                           choices = as.list(names(unlist(modelRuns, recursive = F))),
                           selected = if(input$All_Results) as.list(names(unlist(modelRuns, recursive = F))))
})

observeEvent(input$Check_Scenario_Names_Results,
             {
               if (length(input$Check_Scenario_Names_Results) < 2)
               {
                 shinyjs::hide(id = "summaryMatrix_out_Main")
                 if (summaryMatrix_flag == TRUE)
                 {
                   shinyjs::info("You must select at least 2 scenarios. If only one scenario was simulated and as a result only one is active, you won't be able to display a summary matrix.")
                   summaryMatrix_flag <- FALSE
                 }
               }
             }
)

observeEvent(input$summary_results_table,
  {
    
    if (is.null(input$Check_Scenario_Names_Results))
    {
      shinyjs::info("Error: no scenarios were selected. Please select one or more scenarios.")
      return(10)
    }else
    {
      # inputScenarioNamesResults <- input$Check_Scenario_Names_Results
      output$scenario_summary_results_table <- DT::renderDataTable(
        {
          return_summary_results_table(input$Check_Scenario_Names_Results)
        },
        options = list(scrollX = TRUE)
      )
      shinyjs::show(id = "scenario_summary_results_main")
    }
    
  }
)

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
                 output$plotSummaryMatrix <- renderPlot(
                   plot_Summary_Matrix(input$Check_Scenario_Names_Results)
                 )
               }
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
    Results_Workbook <- createWorkbook(type='xlsx')
    
    # Sheet 0: results information
    sheet_0 <- createSheet(Results_Workbook, sheetName = "Results_report_information")
    list1 <- input$Check_Scenario_Names_Results
    len_list1 <- length(list1)
    num_cols <- max(length(list1), 9)
    rows  <- createRow(sheet_0, rowIndex = 1:7)       # 7 rows
    cells <- createCell(rows, colIndex = 1:num_cols)  # columns in each row
    setCellValue(cells[[1,1]], "Results Report Information")          # put in Row 1, Column 1
    setCellValue(cells[[2,1]], "Scenarios:")                          # put in Row 2, Column 1
    setCellValue(cells[[3,1]], "Descriptions:")                       # put in Row 3, Column 1
    setCellValue(cells[[4,1]], "Report Date/Time:")                   # put in Row 4, Column 1
    setCellValue(cells[[5,1]], "Report contents")                     # put in Row 5, Column 1
    setCellValue(cells[[6,1]], "Fish Toxicity Translator Version:")   # put in Row 6, Column 1
    setCellValue(cells[[7,1]], "For more information visit:")         # put in Row 7, Column 1
    
    for (i in 1:len_list1)
    {
      j <- i + 1
      setCellValue(cells[[2,j]], list1[[i]])
      setCellValue(cells[[3,j]], scenarioDescriptions[[i]])
    }
    
    # Date of report
    setCellValue(cells[[4,2]], date()) 
    
    # Report contents
    setCellValue(cells[[5,2]], "Summary_Results_Table") 
    setCellValue(cells[[5,3]], "Summary_Matrix")
    setCellValue(cells[[5,4]], "Summary_Matrix_Table")
    setCellValue(cells[[5,5]], "Daily_Population_Image")
    setCellValue(cells[[5,6]], "Population_Biomass_Image")
    setCellValue(cells[[5,7]], "Mean_Size_Image")
    setCellValue(cells[[5,8]], "Growth_Potential_Image")
    setCellValue(cells[[5,9]], "Transition_Kernel_Image")
    
    # Fish Toxicity Translator Package version number
    setCellValue(cells[[6,2]], packageVersion("FishToxTranslator"))
    
    # Website
    setCellValue(cells[[7,2]], "<link to website>")
    
    # Sheet 1: Summary Results Table
    summaryTable <- as.data.frame(SummaryTable(modelOutputs))
    sheet_1 <- createSheet(Results_Workbook, sheetName = "Summary_Results_Table")
    addDataFrame(summaryTable, 
                 sheet = sheet_1, 
                 startRow = 1, 
                 startColumn = 1,
                 row.names = FALSE)
    setColumnWidth(sheet_1, colIndex = c(1:100), colWidth = 30)
    
    # Sheet 2: Summary Matrix Image
    sheet_2 <- createSheet(Results_Workbook, sheetName = "Summary_Matrix")
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
    sheet_3 <- createSheet(Results_Workbook, sheetName = "Summary_Matrix_Table")
    addDataFrame(summMats, 
                 sheet = sheet_3, 
                 startRow = 1, 
                 startColumn = 1,
                 row.names = FALSE)
    setColumnWidth(sheet_3, colIndex = c(1:100), colWidth = 30)
    
    # Sheet 4: Daily Population Image
    sheet_4 <- createSheet(Results_Workbook, sheetName = "Daily_Population_Image")
    image_path2 <- tempfile(pattern = "", fileext = ".png")
    png(image_path2,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Daily_Population(input$Check_Scenario_Names_Results)
    dev.off()
    addPicture(file = image_path2, 
               sheet = sheet_4, 
               scale = 1, 
               startRow = 4, 
               startColumn = 4)
    
    # Sheet 5: Population Biomass Image
    sheet_5 <- createSheet(Results_Workbook, sheetName = "Population_Biomass_Image")
    image_path3 <- tempfile(pattern = "", fileext = ".png")
    png(image_path3,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Population_Biomass(input$Check_Scenario_Names_Results)
    dev.off()
    addPicture(file = image_path3, 
               sheet = sheet_5, 
               scale = 1, 
               startRow = 4, 
               startColumn = 4)
    
    # Sheet 6: Mean Size Image
    sheet_6 <- createSheet(Results_Workbook, sheetName = "Mean_Size_Image")
    image_path4 <- tempfile(pattern = "", fileext = ".png")
    png(image_path4,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Mean_Size(input$Check_Scenario_Names_Results)
    dev.off()
    addPicture(file = image_path4, 
               sheet = sheet_6, 
               scale = 1, 
               startRow = 4, 
               startColumn = 4)
    
    # Sheet 7: Growth Potential Image
    sheet_7 <- createSheet(Results_Workbook, sheetName = "Growth_Potential_Image")
    image_path5 <- tempfile(pattern = "", fileext = ".png")
    png(image_path5,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Growth_Potential(input$Check_Scenario_Names_Results)
    dev.off()
    addPicture(file = image_path5, 
               sheet = sheet_7, 
               scale = 1, 
               startRow = 4, 
               startColumn = 4)
    
    # Sheet 8: Transition Kernel Image
    sheet_8 <- createSheet(Results_Workbook, sheetName = "Transition_Kernel_Image")
    image_path6 <- tempfile(pattern = "", fileext = ".png")
    png(image_path6,
        width = input$shiny_width * 2,
        height = input$shiny_height * 2,
        res = 300)
    plot_Transitional_Kernel(input$Check_Scenario_Names_Results)
    dev.off()
    addPicture(file = image_path6, 
               sheet = sheet_8, 
               scale = 1, 
               startRow = 4, 
               startColumn = 4)
    
    saveWorkbook(Results_Workbook,file)
    # Delete temporarily created files.
    # unlink(file.path(tempdir(), "*"))
  }
 
) 
