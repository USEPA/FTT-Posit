# Welcome to the Fish Toxicity Translator R Shiny GUI App
# If you have any problems running this code - contact Nate Pollesch (pollesch.nathan@epa.gov)

# Install and load all necessary packages from CRAN/Bioconductor
rm(list = ls())

# #### Non-web hosted package manager ####
#
# # This package manager makes installing and running other packages easier
# # install.packages("pacman") # This line can be commented out after it is installed once.
# # library(openxlsx)
# library(pacman)
# # This command loads all the necssary packages for the app and the FishToxTranslator
# pacman::p_load("shiny","shinyjs","plotly","lubridate",
#                "readr","DT","shinyWidgets","shinydashboard",
#                "shinyBS","purrr","stringr", "Matrix",
#                "statmod", "truncnorm", "tibble", "plot.matrix",
#                "shinybusy", "readxl", "writexl",
#                "xlsx", "magick")
#
# # This command installs and loads the FishToxTranslator Package from the local tar.gz file
#install.packages("FishToxTranslator_0.1.11.tar.gz",type="source")

#Install Sentry package
#install.packages("sentryR")

# library(FishToxTranslator)

#library(FishToxTranslator)
#devtools::install_github('npollesch/FishToxTranslator', upgrade="never")

#### Web hosted package management ####
library("shiny")
library("shinyjs")
library("plotly")
library("lubridate")
library("readr")
library("DT")
library("shinyWidgets")
library("shinydashboard")
library("shinyBS")
library("purrr")
library("stringr")
library("Matrix")
library("statmod")
library("truncnorm")
library("tibble")
library("plot.matrix")
library("shinybusy")
library("readxl")
library("writexl")
library("xlsx")
#library("magick") #not in use
library("devtools")
library("shiny.pwa")
library("shinyhelper")
library(FishToxTranslator)

# Add Sentry library
library(sentryR)

# This loads the local App Source Files
source("Initialize_Lists.R")
source("Baseline_Tab_Functions_Server.R")
source("Stressor_Tab_Functions_Server.R")
source("DeleteScenario_Tab_Functions_Server.R")
source("DeleteResults_Tab_Functions_Server.R")
source("ImportScenario_Tab_Functions_Server.R")
source("ImportResults_Tab_Functions_Server.R")
source("Visualize_Tab_Functions_Server.R")
source("Run_Tab_Functions_Server_NP.R")
source("Results_Tab_Functions_Server.R")
source("widgets.R")
source("FT_UI.R")
source("FT_Server.R")

# Configure Sentry error handling
configure_sentry(dsn = Sys.getenv('https://3d3c74380d1a43e73b33b78dee00fb27@ccte-app-monitoring.epa.gov/57'), 
                 app_name = "fish-tox-translator", app_version = "1.0.0",
		 modules = packages)

error_handler <- function() {
    capture_exception(error = geterrmessage())
}

options(shiny.error = error_handler)

# This runs the Shiny App!
shinyApp(ui <- FT_UI, server <- FT_Server)
