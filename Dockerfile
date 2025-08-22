# Base image from https://hub.docker.com/u/rocker/
FROM ghcr.io/usepa/r_studio:latest

WORKDIR /home/app/

COPY . .

# List directory contents for debugging
RUN ls -la

# Execute additional R script for package installation
RUN Rscript install_packages.R

#RUN R -e "install.packages('xlsx', repos = 'http://cran.us.r-project.org')"
# Install rJava and dependencies
RUN R -e "install.packages('rJava', repos='https://cloud.r-project.org/')"
RUN R -e "install.packages('xlsxjars', repos='https://cloud.r-project.org/')"

# Install xlsx package
RUN R -e "install.packages('xlsx', repos='https://cloud.r-project.org/')"

EXPOSE 3838

CMD ["R", "-e", "options(shiny.port = 3838, shiny.host = '0.0.0.0'); shiny::runApp('/home/app')"]
