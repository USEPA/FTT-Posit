# Install and load all necessary packages from CRAN/Bioconductor
rm(list = ls())

# cat("JAVA_HOME = ", Sys.getenv("JAVA_HOME"), "\n")
# cat("Pandoc location = ", find.package("pandoc"), "\n")

devtools::install_github('https://github.com/USEPA/FTT-R/blob/324d0874c567887b46b2dc64268ffed165d098f9/FishToxTranslator_0.1.20.1.tar.gz', upgrade="never")
devtools::install_github('jasonmoy28/psycModel')

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
library("tinytex")
library("FishToxTranslator")

pandoc_activate()

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