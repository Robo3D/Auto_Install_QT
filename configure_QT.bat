@REM @Author: Matt Pedler
@REM @Date:   2018-09-21 10:21:35
@REM @Last Modified by:   Matt Pedler
@REM Modified time: 2018-09-21 10:54:45

SET CUR_DIR=%~dp0
SET INSTALL_LOC=%1

ECHO "Current directory = %CUR_DIR%"
ECHO "Install Location = %INSTALL_LOC%"


bitsadmin /transfer myDownloadJob /download /priority normal http://downloadsrv/10mb.zip c:\10mb.zip