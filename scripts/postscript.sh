#!/bin/bash

VHA_BASE_DIR="/usr/share/vha"

echo "creating group 'vha'"
groupadd vha

useradd vha -p vha99 -s /bin/bash -g vha
echo "user 'vha' created with password vha99 and added to group vha"

echo "Changing ownership of $VHA_BASE_DIR"
chown -R vha:vha $VHA_BASE_DIR

echo "Changing permissions for /usr/share/vha/tomcat/bin/*.sh"
chmod a+x $VHA_BASE_DIR/tomcat/bin/*.sh

echo "Changing permissions for /usr/share/vha/basex/*.sh"
chmod a+x $VHA_BASE_DIR/basex/*.sh

echo "Changing permissions for /usr/share/vha/housekeeper/*.sh"
chmod a+x $VHA_BASE_DIR/housekeeper/*.sh

#
#------------------------------------------------
# Copy all required scripts to their destinations
#------------------------------------------------
#
echo "Copying 'vha.sh' to /etc/init.d/"
cp /usr/share/vha/scripts/vha.sh /etc/init.d/

chmod a+x /etc/init.d/vha.sh

#
#------------------------------------------------
# Create symbolic links to /etc/init.d/vha.sh 
# from various rc#.d folders
#------------------------------------------------
#
cd /etc/rc.d/rc0.d
ln -s ../../init.d/vha.sh K17vha
echo "created symbolic link from rc0.d as K17vha"

cd /etc/rc.d/rc1.d
ln -s ../../init.d/vha.sh K17vha
echo "created symbolic link from rc1.d as K17vha"

cd /etc/rc.d/rc2.d
ln -s ../../init.d/vha.sh S86vha
echo "created symbolic link from rc2.d as S86vha"

cd /etc/rc.d/rc3.d
ln -s ../../init.d/vha.sh S86vha
echo "created symbolic link from rc3.d as S86vha"

cd /etc/rc.d/rc4.d
ln -s ../../init.d/vha.sh S86vha
echo "created symbolic link from rc4.d as S86vha"

cd /etc/rc.d/rc5.d
ln -s ../../init.d/vha.sh S86vha
echo "created symbolic link from rc5.d as S86vha"

cd /etc/rc.d/rc6.d
ln -s ../../init.d/vha.sh K17vha
echo "created symbolic link from rc6.d as K17vha"

echo ""
echo "Done installing the Appliance"
echo ""