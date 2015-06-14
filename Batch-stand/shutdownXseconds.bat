@echo off & cls
Mode con cols=72 lines=10
title %title%

set title=Shutdown in X seconds

echo ***************************
echo ** Shutdown in X seconds **
echo ***************************

:QUEST1
echo.
set /p seconds=Shutdown in ___ seconds ? :
echo You choose to shutdown in %seconds% seconds !
goto QUEST2

:QUEST2
set /P confirm=Confirm to shutdown in %seconds% seconds[Y/N]?
if /I "%confirm%" EQU "Y" goto :SHUTDOWN
if /I "%confirm%" EQU "N" goto :PAUSE
goto QUEST1

:SHUTDOWN
cls
title Shutdown in %seconds%
SHUTDOWN /s /t %seconds% /c "Shutdown in progress, you have %seconds% seconds."
goto EOF

:PAUSE
pause>nul
goto QUEST1

:EOF
EXIT