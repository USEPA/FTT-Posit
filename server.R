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

  session$onSessionEnded(function() {
      stopApp()
    })
  
  onSessionEnded = function(callback) {
"Registers the given callback to be invoked when the session is closed (i.e., the connection to the client has been severed). The return value is a function which unregisters the callback. If multiple callbacks are registered, the order in which they are invoked is not guaranteed."
    return(.closedCallbacks$register(callback))
  }


}

    
  
    
      
   
  
              
  
  
