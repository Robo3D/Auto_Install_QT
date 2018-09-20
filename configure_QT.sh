# @Author: matt
# @Date:   2018-09-20 12:37:05
# @Last Modified by:   matt
# @Last Modified time: 2018-09-20 13:52:33
#!/bin/sh

CUR_DIR="$( cd "$( dirname "$0}" )" && pwd )"
INSTALL_PREFIX="$( cd "$( dirname "$1}" )" && pwd )"

echo "Current Dir = $CUR_DIR"
echo "Install Prefix = $INSTALL_PREFIX"

#Download file
if [ ! -f $CUR_DIR/qt-opensource-linux-x64-5.10.1.run ]; then
    echo "Downloading QT This may take some time"
    wget http://mirrors.ocf.berkeley.edu/qt/archive/qt/5.10/5.10.1/qt-opensource-linux-x64-5.10.1.run
elif [[ $(md5sum $CUR_DIR/qt-opensource-linux-x64-5.10.1.run) != "8bc46db7cd82d738fa0015aea0bf7cb1  $CUR_DIR/qt-opensource-linux-x64-5.10.1.run" ]]; then
    echo "MD5 didn't match... Downloading QT again. This may take some time"
    rm -f $CUR_DIR/qt-opensource-linux-x64-5.10.1.run
    wget http://mirrors.ocf.berkeley.edu/qt/archive/qt/5.10/5.10.1/qt-opensource-linux-x64-5.10.1.run
else
    echo "File is already downloaded"
fi

# Check md5 hash. If it doesn't match up then abort
if [[ $(md5sum $CUR_DIR/qt-opensource-linux-x64-5.10.1.run) != "8bc46db7cd82d738fa0015aea0bf7cb1  $CUR_DIR/qt-opensource-linux-x64-5.10.1.run" ]]; then
    echo "Downloaded file does not equal hash. Aborting"
    exit 1
else
    echo "MD5 Matches!"
fi

INSTALLER=$CUR_DIR/qt-opensource-linux-x64-5.10.1.run
INSTALL_SCRIPT=$CUR_DIR/auto_install.qs
INSTALL_LOC=$CUR_DIR/qt

echo "Running installer for QT"
chmod a+x $INSTALLER
$INSTALLER -v --platform minimal --script $INSTALL_SCRIPT QT_AUTOINSTALL_DIR=$INSTALL_LOC

echo "Moving Files"

QT=$INSTALL_LOC/5.10.1/gcc_64
#easy
QT_BIN=$QT/bin
QT_LIB=$QT/lib 
QT_LIBEXEC=$QT/libexec 
QT_INCLUDE=$QT/include 
#harder
QT_PLUGINS=$QT/plugins 
QT_QML=$QT/qml 
QT_MKSPECS=$QT/mkspecs 

# Move easy files
cp -v -r $QT_BIN $INSTALL_PREFIX
cp -v -r $QT_LIB $INSTALL_PREFIX
cp -v -r $QT_LIBEXEC $INSTALL_PREFIX
cp -v -r $QT_INCLUDE $INSTALL_PREFIX

# Move harder files
IP_LIB=$INSTALL_PREFIX/lib/
cp -v -r $QT_PLUGINS $IP_LIB
cp -v -r $QT_QML $IP_LIB
cp -v -r $QT_MKSPECS $IP_LIB

echo "Finished!"