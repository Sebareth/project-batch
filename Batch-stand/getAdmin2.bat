@echo off & cls
@title ADMINISTRATOR PASSWORD REQUIRED
mode con cols=72 lines=10

::*****************************************************************
if not "%UserName%"=="Administrator" (
	runas /env /user:%COMPUTERNAME%\%UserName% %0 %* 
	1>nul timeout /t 3 /nobreak
) ELSE (
goto:menuLOOP
)
::*****************************************************************
:menuLOOP
Set menu_text= Menu after admin mode
Set option_text=Choose an option or hit ENTER to quit:
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