@echo off & cls
@title Shutdown in X seconds...
Mode con cols=72 lines=10
::*****************************************************************
::if not "%UserName%"=="Administrator" (
	::runas /user:%COMPUTERNAME%\%UserName% %0 %* 
	::1>nul timeout /t 3 /nobreak
::) ELSE (
::goto:menuLOOP
:)
::*****************************************************************
::Shutdown in X seconds
::Restart
::Sleep
::Refresh Explorer.exe
::
:menuLOOP
Set menu_text= Power option: Sleep, Shutdown, Restart, Refresh
Set option_text=Choose an option:
@echo off & cls
@title Batch Utility
echo.
echo.      ========================Menu============================
echo		%menu_text% 
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo.      ========================================================
Set option=
echo. & set /p option=%option_text% || GOTO :EOF
echo. & call :menu_[%option%]
pause

::*****************************************************************
:menu_[1] Sleep in X seconds
cls
title Sleep in X seconds
:SECONDS
echo.
Set /p seconds=Sleep in ___ seconds ? :
echo You choose to sleep in %seconds% seconds !
goto CONFIRM

:CONFIRM
Set /P confirm=Confirm to sleep in %seconds% seconds[Y/N]?
if /I "%confirm%" EQU "Y" goto :SLEEP
if /I "%confirm%" EQU "N" goto :menuLOOP

:SLEEP
cls
title Sleep in %seconds%
SHUTDOWN /h /t %seconds% /c "Sleep in progress, you have %seconds% seconds."
echo This script will be closed in few seconds.
Ping 127.0.0.1 3>&1 >nul 2>&1
::1>nul timeout /t 3 /nobreak
goto EOF

::*****************************************************************
:menu_[2] Shutdown in X seconds
cls
title Shutdown in X seconds
:SECONDS
echo.
Set /p seconds=Shutdown in ___ seconds ? :
echo You choose to shutdown in %seconds% seconds !
goto CONFIRM

:CONFIRM
Set /P confirm=Confirm to shutdown in %seconds% seconds[Y/N]?
if /I "%confirm%" EQU "Y" goto :SHUTDOWN
if /I "%confirm%" EQU "N" goto :menuLOOP

:SHUTDOWN
cls
title Shutdown in %seconds%
SHUTDOWN /s /t %seconds% /c "Shutdown in progress, you have %seconds% seconds."
echo This script will be closed in few seconds.
Ping 127.0.0.1 3>&1 >nul 2>&1
::1>nul timeout /t 3 /nobreak
goto EOF

::*****************************************************************
:menu_[3] Restart in X seconds
cls
title Restart in X seconds
:SECONDS
echo.
Set /p seconds=Restart in ___ seconds ? :
echo You choose to restart in %seconds% seconds !
goto CONFIRM

:CONFIRM
Set /P confirm=Confirm to restart in %seconds% seconds[Y/N]?
if /I "%confirm%" EQU "Y" goto :RESTART
if /I "%confirm%" EQU "N" goto :menuLOOP

:RESTART
cls
title Restart in %seconds%
SHUTDOWN /r /t %seconds% /c "Restart in progress, you have %seconds% seconds."
echo This script will be closed in few seconds.
Ping 127.0.0.1 3>&1 >nul 2>&1
::1>nul timeout /t 3 /nobreak
goto EOF

::*****************************************************************
:menu_[4] Refresh your Desktop
set ExplorerExe=explorer.exe
set Kill=You choose to restart your desktop, this will take few seconds.
set Running=Success! Your desktop has been restarted.
set Fully=Your desktop is now fully loaded!
cls
Title Refresh your Desktop

:CHOICE1
set /P Refresh=Do you want to FULL refresh %ExplorerExe% [Y/N]?
if /I "%Refresh%" EQU "Y" goto :REFRESH
if /I "%Refresh%" EQU "N" goto :menuLOOP
goto :CHOICE1

:REFRESH
echo %Kill%
ping -n 5 127.0.0.1 >NUL 2>&1   
taskkill /F /IM %ExplorerExe% >NUL
echo.
ping -n 10 127.0.0.1 >NUL 2>&1   
echo.
start %ExplorerExe% >NUL
echo %Running%
1>nul timeout /t 20 /nobreak   
echo.   
echo %Fully%
pause>NUL
goto:menuLOOP

::*****************************************************************
:PAUSE
pause>nul
goto:menuLOOP

:EOF
EXIT