# Base image https://hub.docker.com/u/rocker/
FROM ghcr.io/usepa/r_studio:latest

WORKDIR /home/app/

COPY . .

# Install-open-jdk11
RUN apt-get update && \
    apt-get install -y default-jdk && \
    apt-get install -y ant && \
    apt-get clean;

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-11-openjdk-amd64/
RUN export JAVA_HOME
RUN echo $JAVA_HOME

RUN echo 'sanitize_errors off;disable_protocols xdr-streaming xhr-streaming iframe-eventsource iframe-htmlfile;' >> /etc/shiny-server/shiny-server.conf

ENV LD_LIBRARY_PATH /usr/lib/jvm/java-11-openjdk-amd64/lib/amd64:/usr/lib/jvm/java-11-openjdk-amd64/jre/lib/amd64/server
RUN export LD_LIBRARY_PATH

# Install xlsx package
RUN R -e "install.packages('xlsx', repos='https://cloud.r-project.org/')"

RUN ls -la
RUN Rscript install_packages.R

EXPOSE 3838

CMD ["R", "-e", "options(shiny.port = 3838, shiny.host = '0.0.0.0'); shiny::runApp('/home/app')"]
