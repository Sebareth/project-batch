@echo off & cls
@title Checking administrator privileges...
Mode con cols=72 lines=10
::*****************************************************************
echo.
NET SESSION >nul 2>&1
IF %ERRORLEVEL% EQU 0 (
	echo This script is running as administrator privilege.
	echo You will be redirected to main menu in few seconds.
	Ping 127.0.0.1 3>&1 >nul
	goto NEXT
) ELSE (
	echo ####### ERROR: ADMINISTRATOR PRIVILEGES REQUIRED #########
	echo This script must be run as administrator to work properly!  
	echo Please, right click and select "Run As Administrator".
	echo ##########################################################
	rem echo.
	echo This script will be closed in few seconds.
	Ping 127.0.0.1 3>&1 >nul 2>&1
	goto EOF
)
::*****************************************************************
:NEXT
cls
title Welcome, let's continue.
rem echo.
echo Screen cleaned!
pause
::pause>nul

:EOF
EXIT /B