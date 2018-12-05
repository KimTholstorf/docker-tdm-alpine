#!/bin/bash
#
# To use this script run it as root and it will switch to the specified user
#
# ----steps-----------------------
# Switches to vha user
# Start or Stop tomcat server
# Start or Stop basex server
# --------------------------------
#
if [[ ${EUID} -ne 0 ]]; then
    echo "This script needs to be run as root"
    exit 1
else
	echo ""
    echo "------Script running as '`whoami`'------"
	echo ""
fi

#define where tomcat is 
VHA_HOME="/usr/share/vha"
TOMCAT_HOME="$VHA_HOME/tomcat"
TOMCAT_SCRIPT="$VHA_HOME/tomcat/bin/catalina.sh"
BASEX_DIR="$VHA_HOME/basex/bin"
BASEX_START_SCRIPT="$BASEX_DIR/basexserver -p41984 -e41985>>vha-basexdb.log 2>&1 &"
BASEX_STOP_SCRIPT="$BASEX_DIR/basexserverstop -p41984 -e41985"

case "$1" in
start)
	echo "Checking to see if BaseX Server is running..."
	output1=`ps -ef | grep org.basex.BaseXServer | grep -v 'grep' | awk '{print$1}'`
	if [ "$output1" == "vha" -o "$output1" == "root" ]
	then
		echo "BaseX Server for HealthAnalyzer is already running."
		echo ""
	else
		echo "BaseX Server for HealthAnalyzer is not running"
		echo "Switching to different HealthAnalyzer user 'vha' and starting BaseX server"
		su - vha -c "cd $VHA_HOME; $BASEX_START_SCRIPT"
		echo ""
	fi

	echo "Checking to see if Tomcat Server is running..."
	output1=`ps -ef | grep org.apache.catalina.startup.Bootstrap | grep -v 'grep' | awk '{print$1}'`
	if [ "$output1" == "vha" -o "$output1" == "root" ]
	then
		echo "Tomcat Server for HealthAnalyzer is already running."
	else
		echo "Tomcat Server for HealthAnalyzer is not running"	  
		echo "Switching to different HealthAnalyzer user 'vha' and starting Tomcat server"
		su - vha -c "cd $TOMCAT_HOME; $TOMCAT_SCRIPT start"
		echo ""		
	fi	
	;;
stop)
	echo "Checking to see if BaseX Server is running..."
	output1=`ps -ef | grep org.basex.BaseXServer | grep -v 'grep' | awk '{print$1}'`
	if [ "$output1" == "vha" -o "$output1" == "root" ]
	then
		echo "BaseX Server for HealthAnalyzer is running. Stopping BaseX..."
		echo "Switching to different HealthAnalyzer user 'vha' and stopping BaseX server"
		echo ""
		su - vha -c "$BASEX_STOP_SCRIPT"
	else
	  echo "BaseX Server for HealthAnalyzer is not running"
	fi
	
	echo "Checking to see if Tomcat Server is running..."
	output1=`ps -ef | grep org.apache.catalina.startup.Bootstrap | grep -v 'grep' | awk '{print$1}'`
	if [ "$output1" == "vha" -o "$output1" == "root" ]
	then
		echo "Tomcat Server for HealthAnalyzer is running. Stopping Tomcat..."
		echo "Switching to different HealthAnalyzer user 'vha' and stopping Tomcat server"
		echo ""
		su - vha -c "$TOMCAT_SCRIPT stop"
	else
	  echo "Tomcat Server for HealthAnalyzer is not running"
	fi
    ;;
*)
    echo "usage: $0 (start|stop)"
	exit 1
esac

exit 0