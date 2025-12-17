################################################################################
#  Events used for the handling of visualization of scenarios.
################################################################################

observe({
  if (is.null(input$Check_Scenario_Names))
  {
    updateCheckboxGroupInput(
      session,
      inputId = "Check_Scenario_Names",
      choices = as.list(scenario_names),
      selected = NULL
    )
    updateSwitchInput(session, inputId = "plot_clear_growth", value = FALSE)
    updateSwitchInput(session, inputId = "plot_clear_survival", value = FALSE)
    updateSwitchInput(session, inputId = "plot_clear_reproduction", value = FALSE)
    updateSwitchInput(session, inputId = "plot_clear_spawning_probabilities", value = FALSE)
    updateSwitchInput(session, inputId = "plot_clear_survival_decrements", value = FALSE)
    updateSwitchInput(session, inputId = "plot_clear_growth_percents", value = FALSE)
    updateSwitchInput(session, inputId = "plot_clear_exposure_concentrations", value = FALSE)
  }
})

observeEvent(input$slider_DaySelection, {
  dayNumber <- input$slider_DaySelection
  if (!is.na(dayNumber))
  {
    if (dayNumber != CurrentDaySelection)
    {
      CurrentDaySelection <<- dayNumber
      updateSliderInput(session, inputId = "slider_parameters", value = dayNumber)
    }
  }
}, ignoreInit = TRUE)

observeEvent(input$slider_parameters, {
  slider_position <- input$slider_parameters
  if (slider_position != CurrentDaySelection)
  {
    updateNumericInput(session, inputId = "slider_DaySelection", value = slider_position)
  }
}, ignoreInit = TRUE)


#-------------------------------------------------------------------------------
#  Plotting events
#-------------------------------------------------------------------------------
observeEvent(input$plot_growth, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios.")
  } else
  {
    output$Growth_out <- renderPlot({
      plot_growth_parameters(input$Check_Scenario_Names, input$slider_parameters)
    })
    shinyjs::show(id = "Growth_out_Main")
  }
})

observeEvent(input$plot_clear_growth, {
  if (input$plot_clear_growth)
  {
    if (is.null(input$Check_Scenario_Names))
    {
      shinyjs::hide(id = "Growth_out_Main")
      updateSwitchInput(session, inputId = "plot_clear_growth", value = FALSE)
      shinyjs::info("Please select one or more scenarios.")
    } else
    {
      output$Growth_out <- renderPlot({
        plot_growth_parameters(input$Check_Scenario_Names, input$slider_parameters)
      })
      shinyjs::show(id = "Growth_out_Main")
    }
  } else
  {
    shinyjs::hide(id = "Growth_out_Main")
  }
  
}, ignoreInit = TRUE)

observeEvent(input$plot_survival, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios.")
  } else
  {
    output$Survival_out <- renderPlot({
      plot_survival_parameters(input$Check_Scenario_Names, input$slider_parameters)
    })
    shinyjs::show(id = "Survival_out_Main")
  }
})

observeEvent(input$plot_clear_survival, {
  if (input$plot_clear_survival)
  {
    if (is.null(input$Check_Scenario_Names))
    {
      shinyjs::hide(id = "Survival_out_Main")
      updateSwitchInput(session, inputId = "plot_clear_survival", value = FALSE)
      shinyjs::info("Please select one or more scenarios.")
    } else
    {
      output$Survival_out <- renderPlot({
        plot_survival_parameters(input$Check_Scenario_Names, input$slider_parameters)
      })
      shinyjs::show(id = "Survival_out_Main")
    }
  } else
  {
    shinyjs::hide(id = "Survival_out_Main")
  }
  
}, ignoreInit = TRUE)

observeEvent(input$plot_reproduction, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios.")
  } else
  {
    output$Reproduction_out <- renderPlot({
      plot_reproduction_parameters(input$Check_Scenario_Names, input$slider_parameters)
    })
    shinyjs::show(id = "Reproduction_out_Main")
  }
})

observeEvent(input$plot_clear_reproduction, {
  if (input$plot_clear_reproduction)
  {
    if (is.null(input$Check_Scenario_Names))
    {
      shinyjs::hide(id = "Reproduction_out_Main")
      updateSwitchInput(session, inputId = "plot_clear_reproduction", value = FALSE)
      shinyjs::info("Please select one or more scenarios.")
    } else
    {
      output$Reproduction_out <- renderPlot({
        plot_reproduction_parameters(input$Check_Scenario_Names, input$slider_parameters)
      })
      shinyjs::show(id = "Reproduction_out_Main")
    }
  } else
  {
    shinyjs::hide(id = "Reproduction_out_Main")
  }
  
}, ignoreInit = TRUE)


observeEvent(input$plot_spawning_probs, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios.")
  } else
  {
    output$SpawningProb_Out <- renderPlot({
      plot_scenarios_spawning_probabilities(input$Check_Scenario_Names)
    })
    shinyjs::show(id = "SpawningProb_out_Main")
  }
})

observeEvent(input$plot_clear_spawning_probabilities, {
  if (input$plot_clear_spawning_probabilities)
  {
    if (is.null(input$Check_Scenario_Names))
    {
      shinyjs::hide(id = "SpawningProb_out_Main")
      updateSwitchInput(session, inputId = "plot_clear_spawning_probabilities", value = FALSE)
      shinyjs::info("Please select one or more scenarios.")
    } else
    {
      output$SpawningProb_Out <- renderPlot({
        plot_scenarios_spawning_probabilities(input$Check_Scenario_Names)
      })
      shinyjs::show(id = "SpawningProb_out_Main")
    }
  } else
  {
    shinyjs::hide(id = "SpawningProb_out_Main")
  }
  
}, ignoreInit = TRUE)


observeEvent(input$plot_survival_decs, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios.")
    
  } else
  {
    output$SurvivalDecrement_out <- renderPlot({
      plot_scenarios_survival_decrements(input$Check_Scenario_Names)
    })
    shinyjs::show(id = "SurvivalDecrement_out_Main")
  }
})

observeEvent(input$plot_clear_survival_decrements, {
  if (input$plot_clear_survival_decrements)
  {
    if (is.null(input$Check_Scenario_Names))
    {
      shinyjs::hide(id = "SurvivalDecrement_out_Main")
      updateSwitchInput(session, inputId = "plot_clear_survival_decrements", value = FALSE)
      shinyjs::info("Please select one or more scenarios.")
    } else
    {
      output$SurvivalDecrement_out <- renderPlot({
        plot_scenarios_survival_decrements(input$Check_Scenario_Names)
      })
      shinyjs::show(id = "SurvivalDecrement_out_Main")
    }
  } else
  {
    shinyjs::hide(id = "SurvivalDecrement_out_Main")
  }
  
}, ignoreInit = TRUE)


observeEvent(input$plot_growth_percents, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios.")
    
  } else
  {
    output$GrowthPercents_out <- renderPlot({
      plot_scenarios_growth_percents(input$Check_Scenario_Names)
    })
    shinyjs::show(id = "GrowthPercents_out_Main")
  }
})

observeEvent(input$plot_clear_growth_percents, {
  if (input$plot_clear_growth_percents)
  {
    if (is.null(input$Check_Scenario_Names))
    {
      shinyjs::hide(id = "GrowthPercents_out_Main")
      updateSwitchInput(session, inputId = "plot_clear_growth_percents", value = FALSE)
      shinyjs::info("Please select one or more scenarios.")
    } else
    {
      output$GrowthPercents_out <- renderPlot({
        plot_scenarios_growth_percents(input$Check_Scenario_Names)
      })
      shinyjs::show(id = "GrowthPercents_out_Main")
    }
  } else
  {
    shinyjs::hide(id = "GrowthPercents_out_Main")
  }
  
}, ignoreInit = TRUE)


observeEvent(input$plot_exposure_concs, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios.")
    
  } else
  {
    output$ExposureConcentration_out <- renderPlot({
      plot_scenarios_exposure_concentrations(input$Check_Scenario_Names)
    })
    shinyjs::show(id = "ExposureConcentration_out_Main")
  }
})

observeEvent(input$plot_clear_exposure_concentrations, {
  if (input$plot_clear_exposure_concentrations)
  {
    if (is.null(input$Check_Scenario_Names))
    {
      shinyjs::hide(id = "ExposureConcentration_out_Main")
      updateSwitchInput(session, inputId = "plot_clear_exposure_concentrations", value = FALSE)
      shinyjs::info("Please select one or more scenarios.")
    } else
    {
      output$ExposureConcentration_out <- renderPlot({
        plot_scenarios_exposure_concentrations(input$Check_Scenario_Names)
      })
      shinyjs::show(id = "ExposureConcentration_out_Main")
    }
  } else
  {
    shinyjs::hide(id = "ExposureConcentration_out_Main")
  }
  
}, ignoreInit = TRUE)


observe({
  updateCheckboxGroupInput(
    session,
    "Check_Scenario_Names",
    choices = as.list(scenario_names),
    selected = if (input$All)
      as.list(scenario_names)
  )
})

observeEvent(input$Check_Scenario_Names, {
  inputScenariosToVis <- input$Check_Scenario_Names
  if (is.null(inputScenariosToVis))
  {
    shinyjs::show(id = "Visualization_SPB")
    shinyjs::show(id = "Visualization_SDEC")
    
  } else
  {
    surv_decr_exists <- FALSE
    for (scenario in 1:length(inputScenariosToVis))
    {
      surv_decr_exists <- exists("survival_decrement", parameters[[inputScenariosToVis[scenario]]])
      if (surv_decr_exists == TRUE)
      {
        shinyjs::show(id = "Visualization_SPB")
        #shinyjs::show(id = "Visualization_SDEC")
        #shinyjs::show(id = "Show_SDEC")
        break
      }
    }
    
    growth_percent_exists <- FALSE
    for (scenario in 1:length(inputScenariosToVis))
    {
      growth_percent_exists <- exists("growth_percent", parameters[[inputScenariosToVis[scenario]]])
      if (growth_percent_exists == TRUE)
      {
        shinyjs::show(id = "Visualization_SPB")
        #shinyjs::show(id = "Visualization_SDEC")
        #shinyjs::show(id = "Show_GP")
        break
      }
    }
    
    if (surv_decr_exists == FALSE &&
        growth_percent_exists == FALSE)
    {
      shinyjs::hide(id = "Visualization_SDEC")
      shinyjs::hide(id = "Show_SDEC")
      shinyjs::hide(id = "Show_GP")
    } else if (surv_decr_exists == FALSE &&
               growth_percent_exists == TRUE)
    {
      shinyjs::show(id = "Visualization_SDEC")
      shinyjs::hide(id = "Show_SDEC")
      shinyjs::show(id = "Show_GP")
    } else if (surv_decr_exists == TRUE &&
               growth_percent_exists == FALSE)
    {
      shinyjs::show(id = "Visualization_SDEC")
      shinyjs::show(id = "Show_SDEC")
      shinyjs::hide(id = "Show_GP")
    } else if (surv_decr_exists == TRUE &&
               growth_percent_exists == TRUE)
    {
      shinyjs::show(id = "Visualization_SDEC")
      shinyjs::show(id = "Show_SDEC")
      shinyjs::show(id = "Show_GP")
    }
    
  }
}, ignoreNULL = TRUE)

#-------------------------------------------------------------------------------
# Clear plots events
#-------------------------------------------------------------------------------
observeEvent(input$clear_growth, {
  shinyjs::hide(id = "Growth_out_Main")
})

observeEvent(input$clear_survival, {
  shinyjs::hide(id = "Survival_out_Main")
})

observeEvent(input$clear_reproduction, {
  shinyjs::hide(id = "Reproduction_out_Main")
})

observeEvent(input$clear_spawning_probabilities, {
  shinyjs::hide(id = "SpawningProb_out_Main")
})

observeEvent(input$clear_survival_decrements, {
  shinyjs::hide(id = "SurvivalDecrement_out_Main")
})

observeEvent(input$clear_growth_percents, {
  shinyjs::hide(id = "GrowthPercents_out_Main")
})

observeEvent(input$clear_exposure_concentrations, {
  shinyjs::hide(id = "ExposureConcentration_out_Main")
})

output$calendar_format <- renderText({
  cdate <- as.POSIXct("2018-10-31")
  cdate <- update(cdate, year = 2018, yday = input$slider_parameters)
  cmonth <- month.name[month(cdate)]
  cday <- mday(cdate)
  paste("Calendar date is ", cmonth, " ", cday)
})

observe({
  cdate <- as.POSIXct("2018-10-31")
  cdate <- update(cdate, year = 2018, yday = input$slider_parameters)
  cmonth <- month.name[month(cdate)]
  cday <- mday(cdate)
  lbl_str <- paste("Corresponding calendar date is ", cmonth, " ", cday)
  output$calendar_format <- renderText({
    lbl_str
  })
  #    updateSliderInput(session, inputId = "slider_parameters", label = lbl_str)
})

#-------------------------------------------------------------------------------
# Observe events that will trigger the opening of modal windows for downloading plots
#-------------------------------------------------------------------------------
# R markdown
output$downloadSpeciesProfile <- downloadHandler(
  pdf_filename <- function()
  {
    fish_name <- sub(" ", "_", CurrentSpeciesName)
    paste(fish_name, "_Profile.pdf", sep = "")
  },
  content = function(pdf_filename)
  {
    system.name <- Sys.info()[["sysname"]]
    fish_name <- sub(" ", "_", CurrentSpeciesName)
    path_html <- ifelse(
      system.name == "Windows",
      paste("www\\", fish_name, "_Profile.html", sep = ""),
      paste("www/", fish_name, "_Profile.html", sep = "")
    )
    file.rename(html_to_pdf(
      file_path = path_html,
      dir = "www",
      render_exist = TRUE
    ),
    pdf_filename)
  },
  contentType = "pdf"
)

#-------------------------------------------------------------------------------
# Growth Functions
#-------------------------------------------------------------------------------
# observeEvent(input$export_growth_modal, {
#   if (is.null(input$Check_Scenario_Names))
#   {
#     output$plotGrowth <- NULL
#     output$textMessageGrowth <- renderText({
#       paste(
#         "Please select one or more scenarios before attempting to export a plot.",
#         "To close this window click the 'Close' button below."
#       )
#     })
#     shinyjs::disable(id = "downloadPlotGrowth")
#   } else
#   {
#     output$textMessageGrowth <- NULL
#     shinyjs::enable(id = "downloadPlotGrowth")
#     output$plotGrowth <- renderPlot(plot_growth_parameters(input$Check_Scenario_Names, input$slider_parameters))
#   }
# })

output$myGrowthParameters <- renderPlot({
  plot_growth_parameters(input$Check_Scenario_Names, input$slider_parameters)
})

plotGPModal <- function() {
  modalDialog(
    title = "",
    plotOutput("myGrowthParameters"),
    size = "l",
    footer = tagList(
      dGF_button,
      modalButton("Close")
    )
  )
}

observeEvent(input$export_growth_modal, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios before attempting to export a plot.")
  }else
  {
    showModal(plotGPModal())
  }
})


output$downloadPlotGrowth <- downloadHandler(
  filename <- function()
  {
    paste("Growth_Functions", ".png", sep = "")
  },
  content = function(file)
  {
    png(
      file,
      width = input$shiny_width * 2,
      height = input$shiny_height * 2,
      res = 300
    )
    plot_growth_parameters(input$Check_Scenario_Names, input$slider_parameters)
    dev.off()
  },
  contentType = "png"
)

#-------------------------------------------------------------------------------
# Survival Functions
#-------------------------------------------------------------------------------
# observeEvent(input$export_survival_modal, {
#   if (is.null(input$Check_Scenario_Names))
#   {
#     output$plotSurvival <- NULL
#     output$textMessageSurvival <- renderText({
#       paste(
#         "Please select one or more scenarios before attempting to export a plot.",
#         "To close this window click the 'Close' button below."
#       )
#     })
#     
#     shinyjs::disable(id = "downloadPlotSurvival")
#   } else
#   {
#     output$textMessageSurvival <- NULL
#     shinyjs::enable(id = "downloadPlotSurvival")
#     output$plotSurvival <- renderPlot(
#       plot_survival_parameters(input$Check_Scenario_Names, input$slider_parameters)
#     )
#   }
# })

output$mySurvivalParameters <- renderPlot({
  plot_survival_parameters(input$Check_Scenario_Names, input$slider_parameters)
})

plotSurvivalModal <- function() {
  modalDialog(
    title = "",
    plotOutput("mySurvivalParameters"),
    size = "l",
    footer = tagList(
      dSF_button,
      modalButton("Close")
    )
  )
}

observeEvent(input$export_survival_modal, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios before attempting to export a plot.")
  }else
  {
    showModal(plotSurvivalModal())
  }
})

output$downloadPlotSurvival <- downloadHandler(
  filename <- function()
  {
    paste("Survival_Functions", ".png", sep = "")
  },
  content = function(file)
  {
    png(
      file,
      width = input$shiny_width * 2,
      height = input$shiny_height * 2,
      res = 300
    )
    plot_survival_parameters(input$Check_Scenario_Names, input$slider_parameters)
    dev.off()
  },
  contentType = "png"
)

#-------------------------------------------------------------------------------
# Reproduction Functions
#-------------------------------------------------------------------------------
# observeEvent(input$export_reproduction_modal, {
#   if (is.null(input$Check_Scenario_Names))
#   {
#     output$plotReproduction <- NULL
#     output$textMessageReproduction <- renderText({
#       paste(
#         "Please select one or more scenarios before attempting to export a plot.",
#         "To close this window click the 'Close' button below."
#       )
#     })
#     
#     shinyjs::disable(id = "downloadPlotReproduction")
#   } else
#   {
#     output$textMessageReproduction <- NULL
#     shinyjs::enable(id = "downloadPlotReproduction")
#     output$plotReproduction <- renderPlot(
#       plot_reproduction_parameters(input$Check_Scenario_Names, input$slider_parameters)
#     )
#   }
# })

output$myReproductionParameters <- renderPlot({
  plot_reproduction_parameters(input$Check_Scenario_Names, input$slider_parameters)
})

plotReproductionModal <- function() {
  modalDialog(
    title = "",
    plotOutput("myReproductionParameters"),
    size = "l",
    footer = tagList(
      dRF_button,
      modalButton("Close")
    )
  )
}

observeEvent(input$export_reproduction_modal, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios before attempting to export a plot.")
  }else
  {
    showModal(plotReproductionModal())
  }
})

output$downloadPlotReproduction <- downloadHandler(
  filename <- function()
  {
    paste("Reproduction_Functions", ".png", sep = "")
  },
  content = function(file)
  {
    png(
      file,
      width = input$shiny_width * 2,
      height = input$shiny_height * 2,
      res = 300
    )
    plot_reproduction_parameters(input$Check_Scenario_Names, input$slider_parameters)
    dev.off()
  },
  contentType = "png"
)

#-------------------------------------------------------------------------------
# Spawning Probabilities
#-------------------------------------------------------------------------------
# observeEvent(input$export_spawning_modal, {
#   if (is.null(input$Check_Scenario_Names))
#   {
#     output$plotSpawning <- NULL
#     output$textMessageSpawning <- renderText({
#       paste(
#         "Please select one or more scenarios before attempting to export a plot.",
#         "To close this window click the 'Close' button below."
#       )
#     })
#     
#     shinyjs::disable(id = "downloadPlotSpawning")
#   } else
#   {
#     output$textMessageSpawning <- NULL
#     shinyjs::enable(id = "downloadPlotSpawning")
#     output$plotSpawning <- renderPlot(plot_scenarios_spawning_probabilities(input$Check_Scenario_Names))
#   }
# })

output$mySpawningParameters <- renderPlot({
  plot_scenarios_spawning_probabilities(input$Check_Scenario_Names)
})

plotSpawningModal <- function() {
  modalDialog(
    title = "",
    plotOutput("mySpawningParameters"),
    size = "l",
    footer = tagList(
      dSPF_button,
      modalButton("Close")
    )
  )
}

observeEvent(input$export_spawning_modal, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios before attempting to export a plot.")
  }else
  {
    showModal(plotSpawningModal())
  }
})

output$downloadPlotSpawning <- downloadHandler(
  filename <- function()
  {
    paste("Spawning_Functions", ".png", sep = "")
  },
  content = function(file)
  {
    png(
      file,
      width = input$shiny_width * 2,
      height = input$shiny_height * 2,
      res = 300
    )
    plot_scenarios_spawning_probabilities(input$Check_Scenario_Names)
    dev.off()
  },
  contentType = "png"
)

#-------------------------------------------------------------------------------
# Survival Decrements
#-------------------------------------------------------------------------------
# observeEvent(input$export_survivalDecrement_modal, {
#   if (is.null(input$Check_Scenario_Names))
#   {
#     output$plotSurvivalDecrement <- NULL
#     output$textMessageSurvivalDecrement <- renderText({
#       paste(
#         "Please select one or more scenarios before attempting to export a plot.",
#         "To close this window click the 'Close' button below."
#       )
#     })
#     
#     shinyjs::disable(id = "downloadPlotSurvivalDecrement")
#   } else
#   {
#     output$textMessageSurvivalDecrement <- NULL
#     shinyjs::enable(id = "downloadPlotSurvivalDecrement")
#     output$plotSurvivalDecrement <- renderPlot(plot_scenarios_survival_decrements(input$Check_Scenario_Names))
#   }
# })

output$mySurvivalDecrementParameters <- renderPlot({
  plot_scenarios_survival_decrements(input$Check_Scenario_Names)
})

plotSurvivalDecrementModal <- function() {
  modalDialog(
    title = "",
    plotOutput("mySurvivalDecrementParameters"),
    size = "l",
    footer = tagList(
      dSDF_button,
      modalButton("Close")
    )
  )
}

observeEvent(input$export_survivalDecrement_modal, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios before attempting to export a plot.")
  }else
  {
    showModal(plotSurvivalDecrementModal())
  }
})

output$downloadPlotSurvivalDecrement <- downloadHandler(
  filename <- function()
  {
    paste("Survival_Decrement", ".png", sep = "")
  },
  content = function(file)
  {
    png(
      file,
      width = input$shiny_width * 2,
      height = input$shiny_height * 2,
      res = 300
    )
    plot_scenarios_survival_decrements(input$Check_Scenario_Names)
    dev.off()
  },
  contentType = "png"
)

#-------------------------------------------------------------------------------
# Growth Percents
#-------------------------------------------------------------------------------
# observeEvent(input$export_growthPercents_modal, {
#   if (is.null(input$Check_Scenario_Names))
#   {
#     output$plotGrowthPercents <- NULL
#     output$textMessageGrowthPercents <- renderText({
#       paste(
#         "Please select one or more scenarios before attempting to export a plot.",
#         "To close this window click the 'Close' button below."
#       )
#     })
#     
#     shinyjs::disable(id = "downloadPlotGrowthPercents")
#   } else
#   {
#     output$textMessageGrowthPercents <- NULL
#     shinyjs::enable(id = "downloadPlotGrowthPercents")
#     output$plotGrowthPercents <- renderPlot(plot_scenarios_growth_percents(input$Check_Scenario_Names))
#   }
# })

output$myGrowthPercentsParameters <- renderPlot({
  plot_scenarios_growth_percents(input$Check_Scenario_Names)
})

plotGrowthPercentsModal <- function() {
  modalDialog(
    title = "",
    plotOutput("myGrowthPercentsParameters"),
    size = "l",
    footer = tagList(
      dGPF_button,
      modalButton("Close")
    )
  )
}

observeEvent(input$export_growthPercents_modal, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios before attempting to export a plot.")
  }else
  {
    showModal(plotGrowthPercentsModal())
  }
})

output$downloadGrowthPercents <- downloadHandler(
  filename <- function()
  {
    paste("Growth_Percents", ".png", sep = "")
  },
  content = function(file)
  {
    png(
      file,
      width = input$shiny_width * 2,
      height = input$shiny_height * 2,
      res = 300
    )
    plot_scenarios_growth_percents(input$Check_Scenario_Names)
    dev.off()
  },
  contentType = "png"
)

#-------------------------------------------------------------------------------
# Exposure Concentrations
#-------------------------------------------------------------------------------
# observeEvent(input$export_exposureConcentration_modal, {
#   if (is.null(input$Check_Scenario_Names))
#   {
#     output$plotExposureConcentration <- NULL
#     output$textMessageExposureConcentration <- renderText({
#       paste(
#         "Please select one or more scenarios before attempting to export a plot.",
#         "To close this window click the 'Close' button below."
#       )
#     })
#     
#     shinyjs::disable(id = "downloadPlotExposureConcentration")
#   } else
#   {
#     output$textMessageExposureConcentration <- NULL
#     shinyjs::enable(id = "downloadPlotExposureConcentration")
#     output$plotExposureConcentration <- renderPlot(plot_scenarios_exposure_concentrations(input$Check_Scenario_Names))
#   }
# })

output$myExposureConcentrationParameters <- renderPlot({
  plot_scenarios_exposure_concentrations(input$Check_Scenario_Names)
})

plotExposureConcentrationModal <- function() {
  modalDialog(
    title = "",
    plotOutput("myExposureConcentrationParameters"),
    size = "l",
    footer = tagList(
      dEC_button,
      modalButton("Close")
    )
  )
}

observeEvent(input$export_exposureConcentration_modal, {
  if (is.null(input$Check_Scenario_Names))
  {
    shinyjs::info("Please select one or more scenarios before attempting to export a plot.")
  }else
  {
    showModal(plotExposureConcentrationModal())
  }
})

output$downloadPlotExposureConcentration <- downloadHandler(
  filename <- function()
  {
    paste("Exposure_Concentrations", ".png", sep = "")
  },
  content = function(file)
  {
    png(
      file,
      width = input$shiny_width * 2,
      height = input$shiny_height * 2,
      res = 300
    )
    plot_scenarios_exposure_concentrations(input$Check_Scenario_Names)
    dev.off()
  },
  contentType = "png"
)


################################################################################
#  Functions used for the visualization of scenarios.
################################################################################
plot_growth_parameters <- function(inputScenariosToVis, dateInput)
{
  if (is.null(inputScenariosToVis))
  {
    return(10)
  } else
  {
    FishToxTranslator::PlotGrowth(parameters[inputScenariosToVis], dateInput)
  }
}

plot_survival_parameters <- function(inputScenariosToVis, dateInput)
{
  if (is.null(inputScenariosToVis))
  {
    return(10)
  } else
  {
    FishToxTranslator::PlotSurvival(parameters[inputScenariosToVis], dateInput)
  }
}

plot_reproduction_parameters <- function(inputScenariosToVis, dateInput)
{
  if (is.null(inputScenariosToVis))
  {
    return(10)
  } else
  {
    FishToxTranslator::PlotReproduction(parameters[inputScenariosToVis], dateInput)
  }
}

plot_scenarios_spawning_probabilities <- function(inputScenariosToVis)
{
  if (is.null(inputScenariosToVis))
  {
    return(10)
  } else
  {
    FishToxTranslator::PlotSpawningProbs(parameters[inputScenariosToVis])
  }
}

plot_scenarios_survival_decrements <- function(inputScenariosToVis)
{
  surv_decr_exists <- FALSE
  
  if (is.null(inputScenariosToVis))
  {
    return(10)
  } else
  {
    for (scenario in 1:length(inputScenariosToVis))
    {
      surv_decr_exists <- exists("survival_decrement", parameters[[inputScenariosToVis[scenario]]])
      if (surv_decr_exists == TRUE)
        break
    }
    if (surv_decr_exists == TRUE)
    {
      FishToxTranslator::PlotSurvivalDecrements(parameters[inputScenariosToVis])
    }
    else
    {
      shinyjs::hide(id = "Show_SDEC")
      return(10)
    }
  }
}

plot_scenarios_growth_percents <- function(inputScenariosToVis)
{
  growth_percents_exists <- FALSE
  
  if (is.null(inputScenariosToVis))
  {
    return(10)
  } else
  {
    for (scenario in 1:length(inputScenariosToVis))
    {
      growth_percents_exists <- exists("growth_percent", parameters[[inputScenariosToVis[scenario]]])
      if (growth_percents_exists == TRUE)
        break
    }
    if (growth_percents_exists == TRUE)
    {
      FishToxTranslator::PlotGrowthPercents(parameters[inputScenariosToVis])
    }
    else
    {
      shinyjs::hide(id = "Show_GP")
      return(10)
    }
  }
}

plot_scenarios_exposure_concentrations <- function(inputScenariosToVis)
{
  exp_conc_exists <- FALSE
  
  if (is.null(inputScenariosToVis))
  {
    return(10)
  } else
  {
    for (scenario in 1:length(inputScenariosToVis))
    {
      exp_conc_exists <- exists("exp_concentrations", parameters[[inputScenariosToVis[scenario]]])
      if (exp_conc_exists == TRUE)
        break
    }
    if (exp_conc_exists == TRUE)
    {
      FishToxTranslator::PlotExposureConcentrations(parameters[inputScenariosToVis])
    }
    else
    {
      shinyjs::hide(id = "Visualization_SDEC")
      return(10)
    }
  }
}

