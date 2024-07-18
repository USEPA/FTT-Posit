observeEvent(input$Delete_Results,
             {
               if (input$selectResultsName  == "None Selected")
               {
                 output$textMessageDeleteResults <- renderText(
                   {
                     paste("Please select one of the Results from the drop-down menu.", 
                           "To close this window click the 'Close' button below.")
                   }
                 )
                  shinyjs::disable(id = "actionDeleteResults")
               }else
               {
                 output$textMessageDeleteResults <- renderText(
                   {
                     str1 <- paste("Do you really want to delete the results with run ID ", 
                                   input$selectResultsRunID, " and name ", 
                                   input$selectResultsName,"?", sep = "")
                     paste(str1,
                           "If the answer is yes, click the 'Confirm and Delete' button below.", 
                           "Click the 'Close' button or 'X' (top right corner) to exit this window.",
                           sep = "\n")
                   }
                 )
                 
                 shinyjs::enable(id = "actionDeleteResults")
                 
               }
               
             }
)

observeEvent(input$selectResultsRunID,
             {
               chosenRunID <- input$selectResultsRunID
               updateSelectInput(session,
                                 inputId = "selectResultsName",
                                 choices = c("None Selected", as.list(names(modelRuns[[chosenRunID]]))),
                                 selected = "None Selected")
             },
             ignoreNULL = FALSE
)

observe(
  {
    if (input$selectResultsRunID == "None Selected" || input$selectResultsRunID == "")
    {
      shinyjs::hide(id = "ResultsNameButton")
    }else
    {
      shinyjs::show(id = "ResultsNameButton")
    }
  }
)

observeEvent(input$selectResultsName,
             {
               chosenScenario <- input$selectResultsName
               if (chosenScenario == "None Selected")
               {
                 shinyjs::hide(id = "DeleteResultsButton")
               }else
               {
                 shinyjs::show(id = "DeleteResultsButton")
               }
             },
             ignoreNULL = FALSE
)


observeEvent(input$actionDeleteResults,
             {
               chosenRunID <- input$selectResultsRunID
               delete_Results(input$selectResultsRunID, input$selectResultsName)
               
               updateCheckboxGroupInput(session, "Check_Scenario_Names_Results",
                                        choices = as.list(names(unlist(modelRuns, recursive = F))))
               
               updateCheckboxInput(session, 
                                   inputId = "All_Results",
                                   value = FALSE)
               
               updateSelectInput(session, "downloadResults",
                                 choices = c("None Selected", as.list(names(unlist(modelRuns, recursive = F)))),
                                 selected = "None Selected")
               
               updateSelectInput(session, "selectResultsName",
                                 choices = c("None Selected", as.list(names(modelRuns[[chosenRunID]]))),
                                 selected = "None Selected")
               
               updateSelectInput(session, "selectResultsRunID",
                                 choices = c("None Selected", as.list(runID)),
                                 selected = "None Selected")
               
               updateSelectInput(session, "selectRunID",
                                 choices = c("None Selected", as.list(runID)),
                                 selected = "None Selected")
               
               updateSelectInput(session, "selectAssociatedScenario",
                                 choices = c("None Selected", as.list(names(modelRuns[[chosenRunID]]))),
                                 selected = "None Selected")
               
               shinyjs::disable(id = "actionDeleteResults")
               
               if (length(runID) == 0)
               {
                 shinyjs::hide(id = "Results_Options")
                 shinyjs::hide(id = "scenario_summary_results_main")
                 shinyjs::hide(id = "dailyPopulation_out_Main")
                 shinyjs::hide(id = "populationBiomass_out_Main")
                 shinyjs::hide(id = "meanSize_out_Main")
                 shinyjs::hide(id = "growthPotential_out_Main")
                 shinyjs::hide(id = "transitionalKernel_out_Main")
                 shinyjs::hide(id = "summaryMatrix_out_Main")
                 shinyjs::hide(id = "HideSelectionResultsRunId")
                 shinyjs::hide(id = "ResultsNameButton")
                 shinyjs::hide(id = "DeleteResultsButton")
                 shinyjs::hide(id = "HideSelectionRunID")
                 shinyjs::hide(id = "AssociatedScenarioButton")
                 shinyjs::hide(id = "DownloadResultsButton")
               }
               
               removeModal()
               
             }
)