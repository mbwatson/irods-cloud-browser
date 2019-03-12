#####################
# Build environment #
#####################

FROM ubuntu:bionic AS builder

RUN apt-get update && apt-get -y install curl zip unzip npm openjdk-8-jdk build-essential

# Create and set working directory
RUN mkdir -p /src/irods-cloud-frontend

WORKDIR /src/irods-cloud-frontend

# Add `/src/irods-cloud-frontend/node_modules/.bin` to $PATH
ENV PATH /src/irods-cloud-frontend/node_modules/.bin:$PATH

# Install and cache app dependencies
COPY ./irods-cloud-frontend/package*.json /src/irods-cloud-frontend/

RUN npm install
RUN npm install -g gulp gulp-cli grunt

COPY ./irods-cloud-frontend/ /src/irods-cloud-frontend/

COPY ./irods-cloud-backend/ /src/irods-cloud-backend/

ENV JAVA_HOME=/usr/lib/jvm/java-8-openjdk-amd64

RUN curl -s "https://get.sdkman.io" | bash

RUN /bin/bash -c "source /root/.sdkman/bin/sdkman-init.sh && \
    sdk install java 8.0.202-zulu && \
    sdk install grails 2.5.0 && \
    sdk install groovy 2.4.3 && \
    gulp gen-war && gulp backend-build && \
    sh"

##############
# Production #
##############

FROM tomcat:jre8-alpine
COPY --from=builder /src/irods-cloud-backend/irods-cloud-backend.war /usr/local/tomcat/webapps/
ADD ./irods-cloud-backend/runit.sh /
EXPOSE 8080
CMD ["/runit.sh"]
