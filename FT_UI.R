source("tabsPanel.R")

fn <- "anti-clickjacking.js"
fnpath <-
  list.files(pattern = fn,
             full.names = TRUE,
             recursive = TRUE)

FT_UI <- function(req) {
  fluidPage(
    useShinyjs(),
    tags$style(id = "antiClickjack", HTML("body{display:none !important;}")),
    
    includeScript(fnpath, type = "text/javascript"),
    
    tags$script(
      "$(document).on('shiny:connected', function(event) {
                var myWidth = $(window).width();
                Shiny.onInputChange('shiny_width',myWidth)});"
    ),
    
    tags$script(
      "$(document).on('shiny:connected', function(event) {
                var myHeight = $(window).height();
                Shiny.onInputChange('shiny_height',myHeight)});"
    ),
    tags$head(tags$style(
      HTML("hr {border-top: 2px solid #000000;}")
    )),
    
    tags$head(tags$style("body { word-wrap: break-word; }")),
    
    #switchInput color while on
    tags$head(tags$style(
      HTML(
        '.bootstrap-switch .bootstrap-switch-handle-off.bootstrap-switch-danger,
                                       .bootstrap-switch .bootstrap-switch-handle-on.bootstrap-switch-danger {
                                        background: #4f97d1;
                                        color: black;
                                        }'
      )
    )),
    
    #switchInput color while off
    tags$head(tags$style(
      HTML(
        '.bootstrap-switch .bootstrap-switch-handle-off.bootstrap-switch-info,
                                       .bootstrap-switch .bootstrap-switch-handle-on.bootstrap-switch-info {
                                        background: #f0f0f0;
                                        color: black;
                                        }'
      )
    )),
    
    tags$head(
      tags$style(
        ".header4 {
    font-size: 120%;
    font-weight: bold;
    font-thickness: 120%;
    padding: 0px;
    margin-left: 0;
  }"
      )
    ), 
    
    # CSS class for action buttons.
    tags$head(
      tags$style(
        ".actButton{
                          background-color: #337ab7;
                          color: #ffffff;
                          border-color: #2e6da4;
                          width: 60%;
                          height: 40px;
                          font-size: 100%;
                          align: center;
                          padding: 0px;
                          margin-left: 0;
                          margin-top: -5px;
                       }

                       .actButton:hover {
                          background-color: #337ab7;
                          color: #ff0000;
                          border-color: #2e6da4;
                          width: 60%;
                          height: 40px;
                          font-size: 100%;
                          align: center;
                          padding: 0px;
                          margin-left: 0;
                          margin-top: -5px;
                          }
                       .actButton:focus {
                          background-color: #337ab7;
                          color: #00ff00;
                          border-color: #2e6da4;
                          width: 60%;
                          height: 40px;
                          font-size: 100%;
                          align: center;
                          padding: 0px;
                          margin-left: 0;
                          margin-top: -5px;
                       }"
      )
    ),
    
    # CSS class for action buttons.
    tags$head(
      tags$style(
        ".actButtonD{
                          background-color: #1a4480;
                          color: #ffffff;
                          border-color: #2e6da4;
                          width: 35%;
                          height: 30px;
                          font-size: 70%;
                          align: left;
                          padding: 0px;
                          margin-right: 0;
                       }
                       .actButtonD:hover {
                          background-color: #1a4480;
                          color: #ff0000;
                          border-color: #2e6da4;
                          width: 35%;
                          height: 30px;
                          font-size: 70%;
                          align: left;
                          padding: 0px;
                          margin-right: 0;
                          }
                       .actButtonD:focus {
                          background-color: #1a4480;
                          color: #00ff00;
                          border-color: #2e6da4;
                          width: 35%;
                          height: 30px;
                          font-size: 70%;
                          align: left;
                          padding: 0px;
                          margin-right: 0;
                       }"
      )
    ),
    
    tags$head(
      tags$style(
        ".actButtonD1{
                          background-color: #1a4480;
                          color: #ffffff;
                          border-color: #2e6da4;
                          width: 80px;
                          height: 37px;
                          font-size: 80%;
                          align: left;
                          padding: 0px;
                          margin-right: 0;
                       }
                       .actButtonD1:hover {
                          background-color: #1a4480;
                          color: #ff0000;
                          border-color: #2e6da4;
                          width: 80px;
                          height: 37px;
                          font-size: 80%;
                          align: left;
                          padding: 0px;
                          margin-right: 0;
                          }
                       .actButtonD1:focus {
                          background-color: #1a4480;
                          color: #00ff00;
                          border-color: #2e6da4;
                          width: 80px;
                          height: 37px;
                          font-size: 80%;
                          align: left;
                          padding: 0px;
                          margin-right: 0;
                       }"
      )
    ),
    
    # CSS class for download buttons.
    tags$head(
      tags$style(
        ".download_Button{
                          background-color: #337ab7;
                          color: #ffffff;
                          border-color: #2e6da4;
                          align: left;
                       }
                       .download_Button:hover {
                          background-color: #337ab7;
                          color: #ff0000;
                          border-color: #2e6da4;
                          align: left;
                          }
                       .download_Button:focus {
                          background-color: #337ab7;
                          color: #00ff00;
                          border-color: #2e6da4;
                          align: left;
                       }"
      )
    ),
    
    # CSS class for fluid rows.
    tags$head(
      tags$style(
        ".fluid_row{
                          border: 4px double red;
                          flex-flow: column wrap;
                       }"
      )
    ),
    
    # CSS class for fluid rows.
    tags$head(
      tags$style(
        ".columns1{
                          flex-shrink: 3;
                       }"
      )
    ),
    
    navbarPage(
      title = "Fish Toxicity Translator v0.1",
      pwa(
        "https://ccte-fishtoxtranslator-dev.epa.gov",
        title = "Fish Toxicity Translator v0.1",
        output = "www",
        icon = "/www/FTT_PWA_512x512.png"
      ),
      tabHome,
      tab1,
      tab2,
      tab3,
      tab4,
      tab5,
      id = "fish_toxicity_app"
    ),
    
    tags$head(
      tags$link(rel = "shortcut icon", href = "favicon.ico"),
      tags$link(
        rel = "apple-touch-icon",
        sizes = "180x180",
        href = "apple-touch-icon.png"
      ),
      tags$link(
        rel = "icon",
        type = "image/png",
        sizes = "32x32",
        href = "favicon-32x32.png"
      ),
      tags$link(
        rel = "icon",
        type = "image/png",
        sizes = "16x16",
        href = "favicon-16x16.png"
      ),
      tags$script(
        HTML(
          'Shiny.addCustomMessageHandler("jsCode",function(message) {eval(message.value);});'
        )
      ),
      tags$style(
        HTML(
          "
        .navbar { background-color: white;}
        .navbar-default .navbar-nav > li > a {color:black;}
        .navbar-default .navbar-nav > .active > a,
        .navbar-default .navbar-nav > .active > a:focus,
        .navbar-default .navbar-nav > .active > a:hover {color: black;background-color: lightgray;}
        .navbar-default .navbar-nav > li > a:hover[data-value='About'] {color:#641be3;background-color: lightgray; text-decoration:none;}
        .navbar-default .navbar-nav > li > a:hover[data-value='Scenario Builder'] {color:#4472c4;background-color: lightgray;text-decoration:none;}
        .navbar-default .navbar-nav > li > a:hover[data-value='Visualize Scenarios'] {color: #548235;background-color: lightgray;text-decoration:none;}
        .navbar-default .navbar-nav > li > a:hover[data-value='Run Scenarios'] {color:#bc003f;background-color: lightgray;text-decoration:none;}
        .navbar-default .navbar-nav > li > a:hover[data-value='Results'] {color: black;background-color: lightgray;text-decoration:none;}
        .navbar-default .navbar-nav > li > a[data-value='About'] {color:#641be3; font-weight: bold;}
        .navbar-default .navbar-nav > li > a[data-value='Scenario Builder'] {color:#4472c4;font-weight: bold;}
        .navbar-default .navbar-nav > li > a[data-value='Visualize Scenarios'] {color: #548235;font-weight: bold;}
        .navbar-default .navbar-nav > li > a[data-value='Run Scenarios'] {color:#bc003f;font-weight: bold;}
        .navbar-default .navbar-nav > li > a[data-value='Results'] {color: black;font-weight: bold;}
                  "
        )
      )
    )
  )
}

