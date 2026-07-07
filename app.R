# Welcome to the Fish Toxicity Translator R Shiny GUI App
# If you have any problems running this code - contact Nate Pollesch (pollesch.nathan@epa.gov)

# Install and load all necessary packages from CRAN/Bioconductor
rm(list = ls())

# This loads the local App Source Files
# source("Initialize_Lists.R")


# This runs the Shiny App!
shinyApp(ui <- FT_UI, server <- FT_Server)

