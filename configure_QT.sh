# @Author: matt
# @Date:   2018-09-20 12:37:05
# @Last Modified by:   Matt Pedler
# @Last Modified time: 2018-09-20 18:24:52
#!/bin/sh

CUR_DIR="$( cd "$( dirname "$0}" )" && pwd )"
INSTALL_LOC="$( cd "$( dirname "$1}" )" && pwd )"

echo "Current Dir = $CUR_DIR"
echo "Install Location = $INSTALL_LOC"

#Download file
if [ ! -f $CUR_DIR/qt-opensource-linux-x64-5.10.1.run ]; then
    echo "Downloading QT This may take some time"
    wget -nv https://s3.us-east-2.amazonaws.com/robo-cura-staging/resources/qt-opensource-linux-x64-5.10.1.run
elif [[ $(md5sum $CUR_DIR/qt-opensource-linux-x64-5.10.1.run) != "8bc46db7cd82d738fa0015aea0bf7cb1  $CUR_DIR/qt-opensource-linux-x64-5.10.1.run" ]]; then
    echo "MD5 didn't match... Downloading QT again. This may take some time"
    rm -f $CUR_DIR/qt-opensource-linux-x64-5.10.1.run
    wget -nv http://mirrors.ocf.berkeley.edu/qt/archive/qt/5.10/5.10.1/qt-opensource-linux-x64-5.10.1.run
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

echo "Running installer for QT"
chmod +x $INSTALLER
$INSTALLER -v --platform minimal --script $INSTALL_SCRIPT QT_AUTOINSTALL_DIR=$INSTALL_LOC
echo "Finished installing QT at $INSTALL_LOC"