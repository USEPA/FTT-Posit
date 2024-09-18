# Base image https://hub.docker.com/u/rocker/
FROM ghcr.io/usepa/r_studio:latest

WORKDIR /home/app/

COPY . .

# Install OpenJDK-8
    
RUN wget -qO- https://adoptopenjdk.jfrog.io/adoptopenjdk/api/gpg/key/public | apt-key add - && \
    echo "deb https://adoptopenjdk.jfrog.io/adoptopenjdk/deb buster main" | tee /etc/apt/sources.list.d/adoptopenjdk.list && \
    apt-get update && apt-get install -y adoptopenjdk-8-hotspot  
    
# Install Apache Ant
ENV ANT_VERSION 1.10.11
ENV ANT_HOME /opt/ant

RUN wget -qO- https://www.apache.org/dist/ant/binaries/apache-ant-$ANT_VERSION-bin.tar.gz | tar xz -C /opt && \
    mv /opt/apache-ant-$ANT_VERSION $ANT_HOME && \
    update-alternatives --install /usr/bin/ant ant $ANT_HOME/bin/ant 1

# Add Ant PATH
ENV PATH "$PATH:$ANT_HOME/bin"

# check version of Java and Ant
RUN java -version && ant -version

# clean cache
RUN apt-get clean


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
