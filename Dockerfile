
FROM java:8u181-jre-alpine3.8
LABEL version="1.0"
LABEL TDM="2.1.7"
LABEL MAINTAINER="kim@tholstorf.dk"
LABEL DISCRIPTION="Docker image for VMware TAM Data Manager (Alpine3.8+JRE8u181)"

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

# Install needed packages and prepare Alpine in the same way the original OVA was prepared
# This will later be changed to be more af a Docker native way of doing this
RUN apk add --no-cache bash shadow wget unzip && \ groupadd vha && \ useradd vha -p vha99 -s /bin/bash -g vha && \ useradd vha root
# Download and install the TDM JAVA binaries (tomcat and basex)
RUN wget http://ftpsite.vmware.com/download/rlspsrl/tdm/2.1.7/GA/tdm-2.1.7-GA-build-9468226-Java-PRODUCTION.zip && \ unzip -d $VHA_HOME && \ rm -f tdm-2.1.7-GA-build-9468226-Java-PRODUCTION.zip && \ chown -R vha:vha $VHA_BASE_DIR && \ chmod a+x $VHA_BASE_DIR/tomcat/bin/*.sh && \ chmod a+x $VHA_BASE_DIR/basex/*.sh

# dir taken from TDM OVA dir /usr/share/vha/scripts
ADD scripts /usr/share/vha/

WORKDIR $VHA_HOME

# In this first version everything are kept as close to how the OVA launches basex and tomcap. The vha.sh script must launch as root, but vha-sh will switch to vha user 
# This will later be changed after modificaions to the vha.sh scrips or run process
# USER vha
EXPOSE 80 41984 8443
ENTRYPOINT [ "/usr/share/vha/scripts/vha.sh, "start" ] 