# Base image https://hub.docker.com/u/rocker/
FROM ghcr.io/usepa/r_studio:latest

WORKDIR /home/app/

COPY . .

# # Install Chromium
# RUN apt-get update && apt-get install -y chromium chromium-driver

# Install xlsx package
# Install Java
RUN apt-get update && \
    apt-get install -y default-jdk && \
    apt-get clean

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV PATH=$JAVA_HOME/bin:$PATH

# Reconfigure rJava
RUN R CMD javareconf

# Install rJava and xlsx packages in R
RUN R -e "install.packages('rJava', repos='http://cran.rstudio.com/')"
RUN R -e "install.packages('xlsx', repos='http://cran.rstudio.com/')"


RUN ls -la
RUN Rscript install_packages.R

EXPOSE 3838

CMD ["R", "-e", "options(shiny.port = 3838, shiny.host = '0.0.0.0'); shiny::runApp('/home/app')"]
