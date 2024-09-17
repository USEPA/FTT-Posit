# Base image https://hub.docker.com/u/rocker/
FROM ghcr.io/usepa/r_studio:latest

WORKDIR /home/app/

COPY . .

# Add backports repository
RUN echo "deb http://deb.debian.org/debian buster-backports main" >> /etc/apt/sources.list

# Install OpenJDK-8
RUN apt-get update && \
    apt-get install -y openjdk-8-jdk -t buster-backports && \
    apt-get install -y ant && \
    apt-get clean;
   

# Setup JAVA_HOME -- useful for docker commandline
ENV JAVA_HOME /usr/lib/jvm/java-8-openjdk-amd64/
RUN export JAVA_HOME
RUN echo $JAVA_HOME

RUN echo 'sanitize_errors off;disable_protocols xdr-streaming xhr-streaming iframe-eventsource iframe-htmlfile;' >> /etc/shiny-server/shiny-server.conf

ENV LD_LIBRARY_PATH /usr/lib/jvm/java-8-openjdk-amd64/lib/amd64:/usr/lib/jvm/java-8-openjdk-amd64/jre/lib/amd64/server
RUN export LD_LIBRARY_PATH

RUN ls -la
RUN Rscript install_packages.R

EXPOSE 3838

CMD ["R", "-e", "options(shiny.port = 3838, shiny.host = '0.0.0.0'); shiny::runApp('/home/app')"]
