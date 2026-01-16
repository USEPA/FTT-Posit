# Install and load all necessary packages from CRAN/Bioconductor
rm(list = ls())

# # This command installs and loads the FishToxTranslator Package from the local tar.gz file
# install.packages("FishToxTranslator_0.1.19.5.tar.gz",type="source")
#Install Sentry package
#install.packages("sentryR")
#devtools::install_github('npollesch/FishToxTranslator', upgrade="never")

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

cat("JAVA_HOME = ", Sys.getenv("JAVA_HOME"), "\n")
cat("Pandoc location = ", find.package("pandoc"), "\n")
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
library("devtools")
library("shiny.pwa")
library("shinyhelper")
library("openxlsx2")
library("markdown")
library("pandoc")
library("rmarkdown")
library("knitr")
library("kableExtra")
library("psycModel")
library("pagedown")
library("pixiedust")
library("FishToxTranslator")

pandoc_activate()

# Add Sentry library
# library(sentryR)

## Intialize data.frames and lists used throughout code
parameters <- list() #list to store parameters for different scenarios
ExposureConcentrations <- list()  # list used to store exposure concentration profiles.
scenario_names <- vector() # Vector for storing scenario names
CurrentBaselineScenarioName <- NA
CurrentStressorScenarioName <- NA
CurrentImportedScenarioName <- NA
CurrentSpeciesName <- NA

TemporaryBaselineScenarioName <- NA

CurrentDaySelection <- 91

# Create an empty list to store scenario descriptions
scenarioDescriptions <- list()
CurrentScenarioDescription <- NA

inputz_t_0 <- list()

# Define run id variable
runID <- vector()
currentRunID <- NA

submittedRunID <- c()
submittedResultsName <- c()
runID_Exists <- FALSE
scenarioName_Exists <- FALSE

summaryMatrix_flag <- FALSE

# Initialize lists to store model output
# temp List stores the most recent model runs
tempOutputs <- list()

# modelOutputs will store all completed model runs
modelOutputs <- list()

# Create list to store model run parameters.
modelRunParams <- data.frame(noSizeClasses = NA,
                             solverOrder = NA,
                             isPredet = NA,
                             isUnif = NA, 
                             unifN0 = NA,
                             predetFileString = NA)

# Create list to store tempOutputs
modelRuns <- list()

# Create list to store model run information
modelRunInfo <- list()

# Create variable to store current scenario names used in the last simulation run
SelectedSimulationRunScenarios <- vector()


inputPredeterminedGrowthEffectsData <- data.frame()

# Styles for action buttons
helper_Color <- "#4d8055"

# Read Excel file and corresponding tabs.
GUI_Tooltip <- read.xlsx2(file = "Tooltip_and_input_database.xlsx",
                         sheetName = "Sheet1",
                         check.names = FALSE,
                         detectDates = FALSE)

# This loads the local App Source Files
source("ui.R")
source("server.R")


## configure Sentry error handling
# configure_sentry(dsn = "https://3d3c74380d1a43e73b33b78dee00fb27@ccte-app-monitoring.epa.gov/57",
#                  app_name = "fish-tox-translator", app_version = "1.0.0")
# 
# error_handler <- function() {
#   capture_exception(error = geterrmessage())
# }
# 
# options(shiny.error = error_handler)