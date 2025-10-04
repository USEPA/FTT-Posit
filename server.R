FT_Server <- function(input, output, session) {
  
  observe_helpers(session = shiny::getDefaultReactiveDomain(),
                  help_dir = "helpfiles", withMathJax = FALSE)
  
  source("tab_Build_server.R", local = TRUE)
  source("tab_Visualize_server.R", local = TRUE)
  source("tab_Run_server.R", local = TRUE)
  source("tab_Results_server.R", local = TRUE)
  source("tab_Reset_server.R", local = TRUE)
  

  keep_alive <- shiny::reactiveTimer(intervalMs = 10000, session = shiny::getDefaultReactiveDomain())
  shiny::observe({keep_alive()})
  
}

    
  
    
  
    
      
   
  
              
  
  
