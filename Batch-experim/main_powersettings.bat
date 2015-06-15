@echo off & cls
@title Detecting administrative permissions..
mode con cols=75 lines=15
::stand_permissions.bat******************************************
Set Detecting=Administrative permissions required. Detecting permissions..
Set Success=Success: Administrative permissions confirmed for %COMPUTERNAME%\%UserName% 
Set Failure=Failure: 

:detect
echo %Detecting%
    net session >nul 2>&1
    if %errorLevel% == 0 (
        echo %Success%
		goto:menuLOOP
    ) else (
        echo %Failure%
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
Set option_text=Choose an option or Type X to cancel:
@title Windows Power Options
cls
echo.
echo	 	%menu_text% 
echo       ============================================================
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo.      ============================================================
Set option=
echo. & set /p option=%option_text% || GOTO :EOF
echo. & call :menu_[%option%]
pause>nul

::*****************************************************************
Set closed=This script will be closed in few seconds.

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
echo %closed%
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
echo %closed%
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
echo %closed%
Ping 127.0.0.1 3>&1 >nul 2>&1
::1>nul timeout /t 3 /nobreak
goto EOF

::*****************************************************************
:menu_[4] Close session
cls
title Close session
:SECONDS
echo.
Set /P seconds=Close session in ___ seconds ? :
echo You choose to close session in %seconds% seconds !
goto CONFIRM

:CONFIRM
Set /P confirm=Confirm to close session in %seconds% seconds[Y/N]?
if /I "%confirm%" EQU "Y" goto :SESSION
if /I "%confirm%" EQU "N" goto :menuLOOP

:SESSION
cls
title Close session in %seconds%
SHUTDOWN -i /l /f /t %seconds% /c "Close session in progress, you have %seconds% seconds."
echo %closed%
Ping 127.0.0.1 3>&1 >nul 2>&1
::1>nul timeout /t 3 /nobreak
goto EOF
::*****************************************************************
:menu_[5] Refresh your Desktop (not yet)
set ExplorerExe=explorer.exe
set Kill=You choose to restart your desktop, this will take few seconds.
set Running=Success! Your desktop has been restarted.
set Fully=Your desktop is now fully loaded!
cls
Title Refresh your Desktop

:QUESTION
set /P Refresh=Do you want to FULL refresh %ExplorerExe% [Y/N]?
if /I "%Refresh%" EQU "Y" goto :REFRESH
if /I "%Refresh%" EQU "N" goto :menuLOOP

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
:: Not yet available
:::CANCEL
::echo %cancel_text%
::Set /P "=cancel=Type X to cancel:" > nul
::if /I "%cancel%" EQU "X" goto :CANCEL
::SHUTDOWN /a
::echo Action have been cancelled.
::pause
::goto:menuLOOP

::*****************************************************************
:: Not yet available 
:: Launch a program.exe AFTER explorer.exe THEN display "FULLY running"
:: THEN close program.exe
::*****************************************************************
:: Not yet available
:: Launch a program.exe who will close explorer.exe THEN display 
:: "explorer.exe closed by program.exe" for better performance, 
:: closing program.exe will run explorer.exe
::*****************************************************************
:: Not yet available
:: Use default duration -60 seconds or Custom duration :SECONDS
:: Finish to kill few processes before to achieve action
:: Display Type X notification to cancel action
::******************************************************************
:: Not yet available
:: Cleanup after specific actions
:: AUTO-cleanup or custom cleanup
::******************************************************************
:: Not yet available
:: Txt file log for everyactions done with date and time
::******************************************************************



:PAUSE
pause>nul
goto:menuLOOP

:EOF
pause>nul
EXIT /B
	