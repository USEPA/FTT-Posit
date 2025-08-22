# Base image from https://hub.docker.com/u/rocker/
FROM ghcr.io/usepa/r_studio:latest

WORKDIR /home/app/

COPY . .

# Install Java
RUN apt-get update && \
    apt-get install -y default-jdk && \
    apt-get clean

# Set JAVA_HOME environment variable
ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64
ENV LD_LIBRARY_PATH=$JAVA_HOME/lib/server
ENV PATH=$JAVA_HOME/bin:$PATH

# Reconfigure rJava
RUN R CMD javareconf

# List directory contents for debugging
RUN ls -la

# Execute additional R script for package installation
RUN Rscript install_packages.R

EXPOSE 3838

CMD ["R", "-e", "options(shiny.port = 3838, shiny.host = '0.0.0.0'); shiny::runApp('/home/app')"]
