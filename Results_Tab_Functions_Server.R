#####################################################################################################
#  Functions associated with the Results tab.
#####################################################################################################
return_summary_results_table <- function(inputScenariosForResults)
{
  if (is.null(inputScenariosForResults))
  {
    return(NULL)
  }else
  {
    summaryTableResults <- FishToxTranslator:::SummaryTable(unlist(modelRuns,recursive=F)[inputScenariosForResults])
    return(summaryTableResults)
  }
}

plot_Daily_Population <- function(inputScenariosForResults)
{
  if (is.null(inputScenariosForResults))
  {
    return(10)
  }else
  {
    FishToxTranslator:::PlotPopulation(unlist(modelRuns,recursive=F)[inputScenariosForResults])
  }
}

plot_Population_Biomass <- function(inputScenariosForResults)
{
  if (is.null(inputScenariosForResults))
  {
    return(10)
  }else
  {
    FishToxTranslator:::PlotBiomass(unlist(modelRuns,recursive=F)[inputScenariosForResults])
    # PlotBiomass(modelOutputs[inputScenariosForResults])
  }
}

plot_Mean_Size <- function(inputScenariosForResults)
{
  if (is.null(inputScenariosForResults))
  {
    return(10)
  }else
  {
    FishToxTranslator:::PlotMeanSize(unlist(modelRuns,recursive=F)[inputScenariosForResults])
    # PlotMeanSize(modelOutputs[inputScenariosForResults])
  }
}

plot_Growth_Potential <- function(inputScenariosForResults)
{
  if (is.null(inputScenariosForResults))
  {
    return(10)
  }else
  {
    FishToxTranslator:::PlotGrowthPotential(unlist(modelRuns,recursive=F)[inputScenariosForResults])
    # PlotGrowthPotential(modelOutputs[inputScenariosForResults])
  }
}

plot_Transitional_Kernel <- function(inputScenariosForResults)
{
  if (is.null(inputScenariosForResults))
  {
    return(10)
  }else
  {
    FishToxTranslator:::PlotTransitionKernel(unlist(modelRuns,recursive=F)[inputScenariosForResults])
  }
}


plot_Summary_Matrix <- function(inputScenariosForResults)
{
  FishToxTranslator:::PlotSummaryMatrix(unlist(modelRuns,recursive=F)[inputScenariosForResults])
}