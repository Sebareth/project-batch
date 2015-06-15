@echo off & cls
@title Checking administrator privileges...
Mode con cols=72 lines=10
::*****************************************************************
Set isAdmin=Mode: administrator
Set isCheckAdmin=This script is running with administrator privileges.
Set redirect_main=You will be redirected to main menu in few seconds.
Set willClose=This script will be closed in few seconds.
::*****************************************************************
echo.
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
	echo %isCheckAdmin%
	echo %redirect_main%
	Ping 127.0.0.1 3>&1 >nul
	goto NEXT
) ELSE (
	echo ####### ERROR: ADMINISTRATOR PRIVILEGES REQUIRED #########
	echo This script must be run as administrator to work properly!  
	echo Please, right click and select "Run As Administrator".
	echo ##########################################################
	echo.
	echo %willClose%
	Ping 127.0.0.1 3>&1 >nul 2>&1
	goto EOF
)
::*****************************************************************
:NEXT
cls
title Welcome, let's continue.
echo.
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
echo %isAdmin%
)
echo Screen cleaned!
pause
::pause>nul

:EOF
EXIT /B