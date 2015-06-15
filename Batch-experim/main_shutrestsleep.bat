@Echo off & cls
Mode con cols=75 lines=15

::*****************************************************************
@title Administrative permissions required. Detecting permissions..
Set Success=Success: Administrative permissions confirmed for %COMPUTERNAME%\%UserName% 
Set Failure=Failure: Current permissions inadequate.

:detect
Set detecting=Administrative permissions required. Detecting permissions..
echo %detecting%
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo Success: Administrative permissions confirmed for %COMPUTERNAME%\%UserName% 
		pause>nul
		goto:menuLOOP
    ) else (
        echo Failure: Current permissions inadequate.
		pause>nul
		goto password
    )
:password
if not "%UserName%"=="Administrator" (
	runas /user:%COMPUTERNAME%\%UserName% %0 %*
	1>nul timeout /t 3 /nobreak
) else (
	goto EOF
) 
::*****************************************************************
:menuLOOP
Set menu_text=Power option: Sleep, Shutdown, Restart, Session, Refresh
Set cancel_text=Type X to cancel previous actions
Set option_text=Choose an option:
@title Windows Power Options
cls
echo.
echo	 	%menu_text% 
echo       ============================================================
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo		%cancel_text%
echo.      ============================================================
Set option=
echo. & set /p option=%option_text% || GOTO :EOF
echo. & call :menu_[%option%]
pause>nul

::*****************************************************************
:menu_[1] Sleep
cls
title Sleep
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
SHUTDOWN -i /h /t %seconds% /c "Sleep in progress, you have %seconds% seconds."
echo This script will be closed in few seconds.
Ping 127.0.0.1 3>&1 >nul 2>&1
::1>nul timeout /t 3 /nobreak
goto EOF

::*****************************************************************
:menu_[2] Shutdown
cls
title Shutdown
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
SHUTDOWN -i /s /t %seconds% /c "Shutdown in progress, you have %seconds% seconds."
echo This script will be closed in few seconds.
Ping 127.0.0.1 3>&1 >nul 2>&1
::1>nul timeout /t 3 /nobreak
goto EOF

::*****************************************************************
:menu_[3] Restart
cls
title Restart
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
SHUTDOWN -i /r /t %seconds% /c "Restart in progress, you have %seconds% seconds."
echo This script will be closed in few seconds.
Ping 127.0.0.1 3>&1 >nul 2>&1
::1>nul timeout /t 3 /nobreak
goto EOF

::*****************************************************************
:menu_[4] Close current session
cls
title Close current session
:SECONDS
echo.
Set /P seconds=Close current session in ___ seconds ? :
echo You choose to close current session in %seconds% seconds !
goto CONFIRM

:CONFIRM
Set /P confirm=Confirm to Close current session in %seconds% seconds[Y/N]?
if /I "%confirm%" EQU "Y" goto :SESSION
if /I "%confirm%" EQU "N" goto :menuLOOP

:SESSION
cls
title Close current session in %seconds%
SHUTDOWN -i /l /f /t %seconds% /c "Close current session in progress, you have %seconds% seconds."
echo This script will be closed in few seconds.
Ping 127.0.0.1 3>&1 >nul 2>&1
::1>nul timeout /t 3 /nobreak
goto EOF
::*****************************************************************
:menu_[5] Refresh your Desktop
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
ping -n 5 127.0.0.1 >nul 2>&1   
taskkill /F /IM %ExplorerExe% >nul
echo.
ping -n 10 127.0.0.1 >nul 2>&1   
echo.
start %ExplorerExe% >nul
echo %Running%
1>nul timeout /t 20 /nobreak   
echo.   
echo %Fully%
pause>nul
goto:menuLOOP

::*****************************************************************
:CANCEL
echo %cancel_text%
Set /P "=cancel=Type X to cancel:" > nul
if /I "%cancel%" EQU "X" goto :CANCEL
::SHUTDOWN /a
echo %% have been cancelled.
pause
goto:menuLOOP

:PAUSE
pause>nul
goto:menuLOOP

:EOF
pause>nul
EXIT /B
	