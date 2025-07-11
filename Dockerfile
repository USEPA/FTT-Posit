# Base image https://hub.docker.com/u/rocker/
FROM ghcr.io/usepa/r_studio:latest

WORKDIR /home/app/

COPY . .

# Install Snap and Chromium
RUN apt-get update && \
    apt-get install -y snapd && \
    snap install core && \
    snap install chromium

# Install xlsx package
RUN R -e "install.packages('xlsx', repos='https://cloud.r-project.org/')"


RUN ls -la
RUN Rscript install_packages.R

EXPOSE 3838

CMD ["R", "-e", "options(shiny.port = 3838, shiny.host = '0.0.0.0'); shiny::runApp('/home/app')"]
