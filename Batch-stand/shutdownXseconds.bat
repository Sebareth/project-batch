@echo off & cls
Mode con cols=72 lines=10
::*********************************************************************************
set title=Shutdown in X seconds
::*********************************************************************************

echo ***************************
echo ** %title%               **
echo ***************************

:SECONDS
echo.
set /p seconds=Shutdown in ___ seconds ? :
echo You choose to shutdown in %seconds% seconds !
goto CONFIRM

:CONFIRM
set /P confirm=Confirm to shutdown in %seconds% seconds[Y/N]?
if /I "%confirm%" EQU "Y" goto :SHUTDOWN
if /I "%confirm%" EQU "N" goto :PAUSE
goto SECONDS

:SHUTDOWN
cls
title Shutdown in %seconds%
SHUTDOWN /s /t %seconds% /c "Shutdown in progress, you have %seconds% seconds."
echo This script will be closed in few seconds.
Ping 127.0.0.1 3>&1 >nul 2>&1
goto EOF

::*********************************************************************************
:PAUSE
pause>nul
goto SECONDS

:EOF
EXIT