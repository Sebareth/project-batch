@echo off & cls
Mode con cols=72 lines=10
::*********************************************************************************
Set menu_text=Menu Example
Set option_text=Choose an option or hit ENTER to quit:
::*********************************************************************************

:menuLOOP
echo.
echo.      ========================Menu============================
echo.
echo            		%menu_text% 
echo.
for /f "tokens=1,2,* delims=_ " %%A in ('"findstr /b /c:":menu_" "%~f0""') do echo.           %%B  %%C
echo.      ========================================================
goto :OPTION

:OPTION
Set option=
echo. & set /p option=%option_text% || GOTO :EOF
echo. & call :menu_[%option%] || GOTO :OPTION
pause>NUL

::*********************************************************************************
:EXIT
pause>nul
goto EOF

:EOF
EXIT
