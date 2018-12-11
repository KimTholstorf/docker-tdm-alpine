#!/bin/bash
echo "------Script running as '`whoami`'------"
echo "starting BaseX server"
cd /usr/share/vha
/usr/share/vha/basex/bin/basexserver -p41984 -e41985 >&1 &
echo "starting Tomcat server"
cd /usr/share/vha/tomcat
/usr/share/vha/tomcat/bin/catalina.sh start >&1 &
# crude wait hack to prevent script from exiting and stopping container-process despite basex/tomcat is still running
# I know, I know - still better than an infinite loop...
wait
echo "Huh? - entrypoint script exited! Container-process will end emediately"
exit 0