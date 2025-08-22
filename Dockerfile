# Base image from https://hub.docker.com/u/rocker/
FROM ghcr.io/usepa/r_studio:latest

WORKDIR /home/app/

COPY . .

# List directory contents for debugging
RUN ls -la

# Execute additional R script for package installation
RUN Rscript install_packages.R

RUN R -e "install.packages('xlsx', repos = 'http://cran.us.r-project.org')"

EXPOSE 3838

CMD ["R", "-e", "options(shiny.port = 3838, shiny.host = '0.0.0.0'); shiny::runApp('/home/app')"]
