@echo off & cls
@title Start Windows services...
Mode con cols=72 lines=10

::*****************************************************************
Set menu_text=Start Windows Services
Set option_text=Choose an option or hit ENTER to quit:

Set TmpFile=TmpFile.txt
Set Resultat=Result.txt
If Exist %TmpFile% Del %TmpFile%
If Exist %Resultat% Del %Resultat%

::*****************************************************************
echo.
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
	goto:menuLOOP
) ELSE (
	echo ####### ERROR: ADMINISTRATOR PRIVILEGES REQUIRED #########
	echo This script must be run as administrator to work properly!  
	echo Please, right click and select "Run As Administrator".
	echo This script will be closed in few seconds.
	echo ##########################################################
	echo.
	Ping 127.0.0.1 3>&1 >nul 2>&1
	goto EOF
)
::*****************************************************************
:menuLOOP
cls
echo.
echo.      ========================Menu============================
echo.
echo            	%menu_text% 
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo.      ========================================================
goto :OPTION

:OPTION
Set option=
echo. & set /p option=%option_text% || GOTO :EOF
echo. & call :menu_[%option%]
pause>NUL

::*********************************************************************************
:menu_[1] List all services
title Listing all services available
net start
pause>nul
goto:menuLOOP


echo %date% *** %time% >> %TmpFile%
For %%a in (%process%) Do Call :KillMyProcess %%a
Cmd /U /C Type %TmpFile% > %Resultat%
Start %Resultat%
goto :menuLOOP

:KillMyProcess
Taskkill /IM "%~1.exe" /F >> %TmpFile% 2>&1 >nul
echo ***************************************************************************** >> %TmpFile%
exit /b 

::menu_[2] Start Windows Update
cls
title Starting Task wuauserv
sc start Schedule
if %errorlevel% == 2 echo Could not start service.
if %errorlevel% == 0 echo Service started successfully.
echo Errorlevel: %errorlevel%
pause>nul
goto:menuLOOP

::*********************************************************************************
:EXIT
pause>nul
goto:menuLOOP

:EOF
EXIT /B