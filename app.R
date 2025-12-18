# Welcome to the Fish Toxicity Translator R Shiny GUI App
# If you have any problems running this code - contact Nate Pollesch (pollesch.nathan@epa.gov)



## For building a manifest to use on PositConnect

rsconnect::writeManifest() ## RUN ONCE BEFORE EACH GitHub Push ##

## Needs a web available version of all packages, so installing FishToxTranslator package directly from FTT-R GitHub Repo

#devtools::install_github('https://github.com/USEPA/FTT-R/blob/324d0874c567887b46b2dc64268ffed165d098f9/FishToxTranslator_0.1.20.1.tar.gz', upgrade="never")

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
library("openxlsx")
library("markdown")
library("rmarkdown")
library("knitr")
library("kableExtra")
library("psycModel")
library("pagedown")
library("pixiedust")
library("FishToxTranslator")
library("openxlsx2")
library("pandoc")

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


# This runs the Shiny App!
shinyApp(ui <- FT_UI, server <- FT_Server)

