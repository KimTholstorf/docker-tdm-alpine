ROM java:8u181-jre-alpine3.8
MAINTAINER Kim Tholstorf <kim@tholstorf.dk>

ENV TDM_VERTION=2.1.7
ENV TDM_BUILD=9468226

# set ENV that vha.sh script uses
ENV VHA_HOME="/usr/share/vha"
ENV VHA_BASE_DIR="/usr/share/vha"
ENV TOMCAT_HOME="$VHA_HOME/tomcat"
ENV TOMCAT_SCRIPT="$VHA_HOME/tomcat/bin/catalina.sh"
ENV BASEX_DIR="$VHA_HOME/basex/bin"
ENV BASEX_START_SCRIPT="$BASEX_DIR/basexserver -p41984 -e41985 >&1 &"
ENV BASEX_STOP_SCRIPT="$BASEX_DIR/basexserverstop -p41984 -e41985"

# Intall needed packages and prepare Alpine
RUN apk add --no-cache bash shadow wget unzip && \ groupadd vha && \ useradd vha -p vha99 -s /bin/bash -g vha && \ useradd vha root
# Download and install the TDM JAVA binaries
RUN wget http://ftpsite.vmware.com/download/rlspsrl/tdm/2.1.7/GA/tdm-2.1.7-GA-build-9468226-Java-PRODUCTION.zip && \ unzip -d $VHA_HOME && \ rm -f tdm-2.1.7-GA-build-9468226-Java-PRODUCTION.zip


WORKDIR /usr/share/vha
USER vha




RUN 
CMD 