@echo off & cls
@title ADMINISTRATOR PASSWORD REQUIRED
mode con cols=72 lines=10

::*****************************************************************
@title Administrative permissions required. Detecting permissions..
Set Detecting=Administrative permissions required. Detecting permissions..
Set Success=Success: Administrative permissions confirmed for %COMPUTERNAME%\%UserName% 
Set Failure=Failure: Current permissions inadequate.

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
Set menu_text= Menu after admin mode
Set option_text=Choose an option:
@echo off & cls
@title Batch Utility
echo.
echo.      ========================Menu============================
echo            	%menu_text% 
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo.      ========================================================
Set option=
echo. & set /p option=%option_text% || GOTO :EOF
echo. & call :menu_[%option%]
pause

::*****************************************************************
:menu_[1] Test
cls
echo Test
pause
goto:menuLOOP

::*****************************************************************
:EOF
EXIT /B