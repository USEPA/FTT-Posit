tabHome <- tabPanel(
  "About",
  div(
    img(
      src = 'ft_logov01beta.png',
      width = 300,
      halign = "center"
    ),
    style = "text-align: center;"
  ),
  
  h2("What is the Fish Toxicity Translator?"),
  h4(
    'The Fish Toxicity Translator is a model that translates acute and chronic effects of
                         chemical exposures to population level impacts for a specified life history and
                         chemical exposure profile.  Annual simulations are created by building stressor scenarios that include daily dynamics. Results focus on comparison of stressor scenarios to baseline scenarios.'
  ),
  tags$ul(h5(
    tags$li(
      'The Fish Toxicity Translator works by introducing stressor scenarios to an underlying annual baseline life history model'
    )
  ), h5(tags$li(
    paste(
      'The model has a built-in parameterization for Fathead minnow (P. promelas) life history and can be parameterized for other species using the available Species Life History Template',
      sep = ""
    )
  )), h5(
    tags$li(
      'Non-chemical stressors can also be modeled and overlaid on baseline or chemical stressor scenarios.  The current non-chemical stressors included in the model are (1) Over-winter growth and survival and (2) Density-dependent growth effects'
    )
  ), h5(
    tags$li(
      'Model outputs include a variety of daily population metrics including:
                                 number of individuals, total biomass, average size, and daily minimum and maximum population growth potential. Annual population metrics include asymtotic population growth rate (lambda) and annual maximum growth potential to estimate long term effects of exposure'
    )
  )),
  h2("Fish Toxicity Translator Workflow"),
  div(
    img(
      src = 'workflow_diagram_2.png',
      width = 729,
      halign = "center"
    ),
    style = "text-align: center;"
  ),
  h2("Contact Information"),
  h5(
    "This beta version of the graphical user interface and model is undergoing continuous development.  Please do not hesitate to contact Nate Pollesch (pollesch.nathan@epa.gov) or Matthew Etterson (etterson.matthew@epa.gov) with any questions."
  )
)
  
  