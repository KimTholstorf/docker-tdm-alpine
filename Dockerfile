
FROM openjdk:8u181-jre-alpine3.8
LABEL version="1.0"
LABEL TDM="2.1.7"
LABEL TDM_BUILD="9468226"
LABEL MAINTAINER="kim@tholstorf.dk"
LABEL DISCRIPTION="Docker image for VMware TAM Data Manager (Alpine3.8+JRE8u181)"

ENV TDM_VERTION=2.1.7
ENV TDM_BUILD=9468226

# prepare everything, then download and extract TDM binary
RUN apk add --no-cache bash unzip &&\
    mkdir /usr/share/vha &&\
    mkdir /usr/share/vha/scripts &&\
    cd /usr/share/vha &&\
    wget http://ftpsite.vmware.com/download/rlspsrl/tdm/2.1.7/GA/tdm-2.1.7-GA-build-9468226-Java-PRODUCTION.zip &&\
    unzip tdm-2.1.7-GA-build-9468226-Java-PRODUCTION.zip -d /usr/share/vha &&\
    rm -f tdm-2.1.7-GA-build-9468226-Java-PRODUCTION.zip
ADD scripts /usr/share/vha/scripts

WORKDIR /usr/share/vha

EXPOSE 80 8080 8443
ENTRYPOINT ["bash", "/usr/share/vha/scripts/vha_docker.sh"]