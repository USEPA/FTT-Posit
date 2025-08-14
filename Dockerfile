# Base image https://hub.docker.com/u/rocker/
FROM ghcr.io/usepa/r_studio:latest

WORKDIR /home/app/

COPY . .

# # Install Chromium
# RUN apt-get update && apt-get install -y chromium chromium-driver

# Install xlsx package
RUN R -e "install.packages('xlsx', repos='https://cloud.r-project.org/')"


RUN ls -la
RUN Rscript install_packages.R

EXPOSE 3838

CMD ["R", "-e", "options(shiny.port = 3838, shiny.host = '0.0.0.0'); shiny::runApp('/home/app')"]
